import 'package:flutter/material.dart';

import '../../shared/widgets.dart';

class AppUserFavoriteItem extends StatelessWidget with AppColors, AppGaps {
  AppUserFavoriteItem({
    super.key,
    required this.headerText,
    required this.headerDetail,
  });

  final String headerText;
  final String headerDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(small),
      margin: EdgeInsets.all(small),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: <Widget>[
          _AppUserFavoriteItemInfo(
            leadingText: headerText,
            trailingText: headerDetail,
            isHeader: true,
          ),
          _AppUserFavoriteItemInfo(
            leadingText: '1028 hPa',
            trailingText: 'Calm',
            leadingIcon: Icons.speed,
            trailingIcon: Icons.flag,
          ),
          _AppUserFavoriteItemInfo(
            leadingText: '10.0 km',
            trailingText: '8C',
            leadingIcon: Icons.abc,
            trailingIcon: Icons.abc_outlined,
          ),
          _AppUserFavoriteItemInfo(
            leadingText: '10 km',
            trailingText: 'Updated 32 minutes ago',
            isFooter: true,
          ),
        ],
      ),
    );
  }
}

class _AppUserFavoriteItemInfo extends StatelessWidget with AppColors, AppGaps {
  _AppUserFavoriteItemInfo({
    required this.leadingText,
    required this.trailingText,
    this.leadingIcon,
    this.trailingIcon,
    this.isHeader = false,
    this.isFooter = false,
  });

  final String leadingText;
  final IconData? leadingIcon;
  final String trailingText;
  final IconData? trailingIcon;
  final bool isHeader;
  final bool isFooter;

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return _headerWidget();
    } else if (isFooter) {
      return _footerWidget();
    }
    return _detailWidget();
  }

  Widget _detailWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            if (leadingIcon != null) Icon(leadingIcon),
            AppText(leadingText),
          ],
        ),
        Row(
          children: <Widget>[
            if (trailingIcon != null) Icon(trailingIcon),
            AppText(trailingText),
          ],
        ),
      ],
    );
  }

  Widget _footerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AppText(
          leadingText,
          fontSize: 12,
        ),
        AppText(
          trailingText,
          fontSize: 12,
        ),
      ],
    );
  }

  Widget _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AppText(leadingText),
        DecoratedBox(
          decoration: BoxDecoration(color: darkColor),
          child: Padding(
            padding: EdgeInsets.all(smallest / 2),
            child: AppText(
              trailingText,
              color: lightColor,
            ),
          ),
        ),
      ],
    );
  }
}
