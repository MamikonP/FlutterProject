// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/constants.dart';
import '../cubit/navigation_bar_cubit.dart';
import '../shared/widgets.dart';
import 'app_banner_ad.dart';

class AppBottomNavigationBar extends StatelessWidget with AppColors, AppGaps {
  AppBottomNavigationBar({super.key});

  List<String>? _itemsName;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    _itemsName ??= <String>[
      localization.explore,
      localization.map,
      localization.settings,
      localization.profile,
    ];
    final List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
      _navigationBarItem(context, 'explore.svg', _itemsName![0]),
      _navigationBarItem(context, 'map.svg', _itemsName![1]),
      _navigationBarItem(context, 'settings-outlined.svg', _itemsName![2]),
      _navigationBarItem(context, 'profile-person.svg', _itemsName![3]),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 5, color: hoverColor),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
            child: BottomNavigationBar(
              items: items,
              backgroundColor: Theme.of(context).colorScheme.background,
              unselectedItemColor: negativeColor,
              selectedItemColor: accentColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              currentIndex: context.read<NavigationBarCubit>().currentPage,
              type: BottomNavigationBarType.fixed,
              onTap: (int value) {
                context
                    .read<NavigationBarCubit>()
                    .navigateTo(_itemsName![value], value);
              },
            ),
          ),
        ),
        const AppBannerAd()
      ],
    );
  }

  BottomNavigationBarItem _navigationBarItem(
    BuildContext context,
    String assetIcon,
    String label, {
    Color? color,
  }) {
    final String selectedItem =
        _itemsName![context.read<NavigationBarCubit>().currentPage];
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(smallest),
        child: AppImage(
          image: 'assets/images/icons/$assetIcon',
          imageType: ImageType.asset,
          color: selectedItem == label ? accentColor : negativeColor,
        ),
      ),
      label: label,
      backgroundColor: color,
    );
  }
}
