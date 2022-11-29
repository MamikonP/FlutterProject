import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../shared/widgets.dart';
import 'app_user_image.dart';

class AppUserProfile extends StatelessWidget {
  const AppUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state is PickImageCancelled) {
          return AppUserImage();
        } else if (state is PickImageLoading) {
          return const AppLoading();
        } else if (state is PickImageLoaded) {
          return AppUserImage(image: state.imageFile);
        } else {
          return AppUserImage();
        }
      },
    );
  }
}
