import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/utilities.dart';

class AppPulldownRefresh extends StatelessWidget {
  const AppPulldownRefresh({
    required this.slivers,
    required this.onRefresh,
    super.key,
  });

  final Future<void> Function() onRefresh;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    if ((slivers[0] is CupertinoSliverRefreshControl) == false &&
        Utilities.isIOSPlatform) {
      slivers.insert(
        0,
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
        ),
      );
    }
    final Widget scrollView = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: slivers,
    );

    return Utilities.isAndroidPlatform
        ? RefreshIndicator(
            onRefresh: onRefresh,
            child: scrollView,
          )
        : scrollView;
  }
}
