import 'package:flutter/material.dart';

import '../shared/widgets.dart';

class AppMapItem extends StatelessWidget with AppColors, AppGaps {
  AppMapItem(this.title, {this.heightFactor, this.scrollController, super.key});

  final String title;
  final double? heightFactor;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent,
      child: Container(
        margin: EdgeInsets.all(small),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightColor,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      dense: true,
                      title: AppText(
                        title,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ),
                    // if (title == 'DRAGABLE')
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: AppDivider(
                thickness: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
