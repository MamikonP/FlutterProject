import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/constants.dart';
import '../../shared/widgets.dart';

class AppUserHeader extends StatelessWidget with AppColors, AppGaps {
  AppUserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: EdgeInsets.all(medium),
      child: Row(
        children: <Widget>[
          const AppUserProfile(),
          AppGap(medium, direction: AppGapDirection.horizontal),
          AppText(
            'Hi,\n${user?.displayName ?? 'Dear Guest'}',
            color: lightColor,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}
