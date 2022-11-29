import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/navigation_bar_cubit.dart';
import '../shared/app_screen.dart';
import '../shared/widgets.dart';
import '../widgets/screens/app_home.dart';
import '../widgets/screens/app_map.dart';
import '../widgets/screens/app_profile.dart';
import '../widgets/screens/app_settings.dart';

class AppHomePage extends StatelessWidget with AppColors {
  AppHomePage({super.key});

  final List<Widget> _screens = <Widget>[
    AppHome(),
    const AppMap(),
    AppSettings(),
    AppProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (BuildContext context, NavigationBarState state) {
        if (state is NavigationBarChanged) {
          NavigationBarCubit.pageController.jumpToPage(state.page);
        }
        return AppScreen(
          withNavigationBar: true,
          body: PageView.builder(
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            controller: NavigationBarCubit.pageController,
            itemBuilder: (BuildContext context, int index) {
              return _screens[index];
            },
          ),
        );
      },
    );
  }
}
