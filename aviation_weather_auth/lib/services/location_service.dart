import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/network/base_exception.dart';

class LocationService {
  factory LocationService() {
    return LocationService._();
  }

  factory LocationService.fromMapController(GoogleMapController controller) {
    return LocationService._(googleMapController: controller);
  }

  LocationService._({this.googleMapController});

  GoogleMapController? googleMapController;

  Future<Position> getCurrentPosition() async {
    try {
      final LocationPermission currentPermission =
          await Geolocator.checkPermission();
      if (currentPermission == LocationPermission.denied ||
          currentPermission == LocationPermission.unableToDetermine ||
          currentPermission == LocationPermission.deniedForever) {
        final LocationPermission locationPermission =
            await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          throw BaseAppException(message: 'Location services are disabled');
        }
      }
      return Geolocator.getCurrentPosition();
    } catch (e) {
      throw BaseAppException(message: e.toString());
    }
  }

  Future<LatLng> getCurrentLocation() async {
    final Position position = await getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  Future<double?> get currentZoomLevel async =>
      googleMapController?.getZoomLevel();

  Future<LatLng> get currentPosition async => getCurrentLocation();

  Future<CameraPosition> getInitialCameraPosition() async {
    final LatLng latLng = await currentPosition;
    return CameraPosition(
      target: latLng,
      zoom: 12,
    );
  }

  Future<void> animateCamera(
      {required LatLng target, double zoomLevel = 12}) async {
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: zoomLevel,
        ),
      ),
    );
  }
}
