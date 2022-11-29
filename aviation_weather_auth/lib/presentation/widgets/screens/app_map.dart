import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../services/location_service.dart';
import '../../cubit/permission/permission_cubit.dart';
import '../../shared/widgets.dart';

class AppMap extends StatefulWidget {
  const AppMap({super.key});

  @override
  State<AppMap> createState() => _AppMapState();
}

class _AppMapState extends State<AppMap>
    with SingleTickerProviderStateMixin, AppColors, AppGaps {
  LocationService _locationService = LocationService();
  Set<Marker> _markers = <Marker>{};
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();
  final StreamController<dynamic> _streamController =
      StreamController<dynamic>.broadcast();
  dynamic selected;
  late Future<CameraPosition> _cameraPosition;

  @override
  void initState() {
    super.initState();
    _cameraPosition = _locationService.getInitialCameraPosition();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _locationService.googleMapController?.dispose();
    _draggableScrollableController.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PermissionCubit>(
      create: (BuildContext context) => PermissionCubit(),
      child: BlocBuilder<PermissionCubit, PermissionState>(
        builder: (BuildContext context, PermissionState state) {
          if (state is PermissionInitial) {
            context
                .read<PermissionCubit>()
                .checkPermission(Permission.location);
          } else if (state is PermissionDisallowed) {
            context
                .read<PermissionCubit>()
                .requestPermission(Permission.location);
          }
          return Stack(
            clipBehavior: Clip.antiAlias,
            children: <Widget>[
              FutureBuilder<CameraPosition>(
                future: _cameraPosition,
                builder: (BuildContext context,
                    AsyncSnapshot<CameraPosition> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: AppText(snapshot.error.toString()),
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(child: AppText('Network error'));
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return const AppLoading();
                    case ConnectionState.done:
                      if (!snapshot.hasData) {
                        return const Center(
                          child: AppText('Location permissions are disabled'),
                        );
                      }
                      return GoogleMap(
                        onTap: (LatLng argument) {
                          _resetSelected();
                        },
                        zoomControlsEnabled: false,
                        initialCameraPosition: snapshot.data!,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          _locationService =
                              LocationService.fromMapController(controller);
                        },
                        markers: _markers,
                        padding: const EdgeInsets.only(top: 50),
                      );
                  }
                },
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.15,
                right: small,
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(3),
                  color: lightColor.withOpacity(0.7),
                  shadowColor: lightColor,
                  child: IconButton(
                    icon: const Icon(Icons.my_location_sharp),
                    onPressed: () async {
                      final LatLng currentPosition =
                          await _locationService.currentPosition;
                      await _locationService.animateCamera(target: currentPosition);
                    },
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.all(small),
                    color: primaryColor,
                  ),
                ),
              ),
              if (selected != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.15,
                    minChildSize: 0.15,
                    maxChildSize: 0.6,
                    controller: _draggableScrollableController,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return AppMapItem(
                        selected.name as String? ?? 'Unknown',
                        scrollController: scrollController,
                      );
                    },
                  ),
                ),
              AppSearchField(),
            ],
          );
        },
      ),
    );
  }

  void _resetSelected() {
    setState(() {
      if (_draggableScrollableController.isAttached) {
        _draggableScrollableController.reset();
      }
      selected = null;
    });
  }
}
