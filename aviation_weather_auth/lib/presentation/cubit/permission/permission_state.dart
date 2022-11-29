part of 'permission_cubit.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => <Object>[];
}

class PermissionInitial extends PermissionState {
  const PermissionInitial();
}

class PermissionLoading extends PermissionState {
  const PermissionLoading();
}

class PermissionGranted extends PermissionState {
  const PermissionGranted();
}

class PermissionAllowed extends PermissionState {
  const PermissionAllowed();
}

class PermissionDisallowed extends PermissionState {
  const PermissionDisallowed();
}

class PermissionDenied extends PermissionState {
  const PermissionDenied(this.message);
  
  final String message;
}
