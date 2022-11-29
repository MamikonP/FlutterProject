import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(const PermissionInitial());

  void pulldownRefresh() => emit(const PermissionInitial());

  Future<void> checkPermission(Permission permission) async {
    if (await permission.status == PermissionStatus.granted) {
      emit(const PermissionGranted());
    } else {
      emit(const PermissionDisallowed());
    }
  }

  Future<void> _checkUpdatedPermission(Permission permission) async {
    await checkPermission(permission);
    if (state is PermissionDisallowed) {
      emit(
        const PermissionDenied('Location permissions are denied'),
      );
    } else {
      emit(const PermissionAllowed());
    }
  }

  Future<void> requestPermission(Permission permission) async {
    emit(const PermissionLoading());
    if (await permission.request() == PermissionStatus.permanentlyDenied) {
      emit(
        const PermissionDenied(
            'Location permissions are permanently denied, enable it from settings'),
      );
    } else {
      _checkUpdatedPermission(permission);
    }
  }

  Future<void> enableCurrentLocation() async {
    emit(const PermissionLoading());
    if (await Permission.location.serviceStatus.isDisabled) {
      emit(const PermissionDenied('Location services are disabled'));
    } else {
      _checkUpdatedPermission(Permission.location);
    }
  }
}
