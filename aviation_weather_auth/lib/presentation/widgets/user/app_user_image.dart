import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/constants.dart';
import '../../shared/app_modal_popup.dart';
import '../../shared/widgets.dart';
import 'app_user_image_picker.dart';

class AppUserImage extends StatelessWidget with AppColors {
  AppUserImage({this.image, super.key});

  final File? image;

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider =
        const AssetImage('assets/images/icons/person.png');
    if (image != null) {
      imageProvider = FileImage(image!);
    }
    return GestureDetector(
      onTap: () {
        showModalPopup(context, const AppUserImagePicker());
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: imageProvider,
                fit: image != null ? BoxFit.cover : BoxFit.none,
              ),
            ),
          ),
          Positioned(
            bottom: -5,
            right: -5,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightColor,
                border: Border.all(
                  color: accentDarkColor,
                  width: 2,
                ),
              ),
              child: const AppImage(
                image: 'assets/images/icons/camera.svg',
                imageType: ImageType.asset,
                fit: BoxFit.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
