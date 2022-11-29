import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../data/constants.dart';

void showSnackBar(
    BuildContext context, String content, SnackbarState snackBarState) {
  CustomSnackBar snackBar;
  if (snackBarState == SnackbarState.error) {
    snackBar = CustomSnackBar.error(message: content);
  } else if (snackBarState == SnackbarState.success) {
    snackBar = CustomSnackBar.success(message: content);
  } else {
    snackBar = CustomSnackBar.info(message: content);
  }
  showTopSnackBar(
    context,
    snackBar,
    dismissDirection: DismissDirection.horizontal,
    dismissType: DismissType.onSwipe,
  );
}
