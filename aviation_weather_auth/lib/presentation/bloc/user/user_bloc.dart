import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/user_repository_impl.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._userRepository) : super(const UserInitial()) {
    on<LoadImageFromGallery>(_onLoadImageFromGallery);
    on<LoadImageFromCamera>(_onLoadImageFromCamera);
    on<SendEmail>(_onSendEmail);
  }

  FutureOr<void> _onLoadImageFromGallery(
      LoadImageFromGallery event, Emitter<UserState> emit) async {
    emit(const PickImageLoading());
    try {
      final XFile file = await _userRepository.pickImage(ImageSource.gallery);
      final File image = File(file.path);
      emit(PickImageLoaded(image));
    } on NullThrownError {
      emit(const PickImageCancelled());
    }
  }

  FutureOr<void> _onLoadImageFromCamera(
      LoadImageFromCamera event, Emitter<UserState> emit) async {
    emit(const PickImageLoading());
    try {
      final XFile file = await _userRepository.pickImage(ImageSource.camera);
      final File image = File(file.path);
      emit(PickImageLoaded(image));
    } on NullThrownError {
      emit(const PickImageCancelled());
    }
  }

  FutureOr<void> _onSendEmail(SendEmail event, Emitter<UserState> emit) async {
    emit(const EmailSending());
    if (await _userRepository.sendEmail()) {
      emit(const EmailSent());
    } else {
      emit(const EmailSendingCancelled());
    }
  }

  final UserRepository _userRepository;
}
