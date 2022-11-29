import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/utilities.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../shared/app_navigator.dart';

class AppUserImagePicker extends StatelessWidget {
  const AppUserImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    final ProfileBloc profileBloc = context.read<ProfileBloc>();
    if (Utilities.isAndroidPlatform) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              AppNavigator.pop(context);
              profileBloc.add(const LoadImageFromCamera());
            },
            child: ListTile(
              leading: const Icon(Icons.photo_camera_rounded),
              title: Text(localization.takePhoto),
            ),
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.pop(context);
              profileBloc.add(const LoadImageFromGallery());
            },
            child: ListTile(
              leading: const Icon(Icons.photo),
              title: Text(localization.chooseImageFromGallery),
            ),
          ),
        ],
      );
    } else if (Utilities.isIOSPlatform) {
      return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {
              AppNavigator.pop(context);
              profileBloc.add(const LoadImageFromCamera());
            },
            child: Text(localization.takePhoto),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              AppNavigator.pop(context);
              profileBloc.add(const LoadImageFromGallery());
            },
            child: Text(localization.chooseImageFromGallery),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
