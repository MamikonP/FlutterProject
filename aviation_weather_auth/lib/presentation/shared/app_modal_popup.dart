import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/utilities.dart';

Future<void> showModalPopup(BuildContext context, Widget builder,
    {bool dismissible = true}) async {
  if (Utilities.isAndroidPlatform) {
    await showModalBottomSheet(
      context: context,
      isDismissible: dismissible,
      builder: (BuildContext context) {
        return builder;
      },
    );
  } else if (Utilities.isIOSPlatform) {
    await showCupertinoModalPopup(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return builder;
      },
    );
  }
}
