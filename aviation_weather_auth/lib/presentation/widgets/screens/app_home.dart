// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets.dart';

class AppHome extends StatelessWidget with AppColors, AppGaps {
  AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppText('Explore'),
    );
  }
}
