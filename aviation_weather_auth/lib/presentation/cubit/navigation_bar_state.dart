part of 'navigation_bar_cubit.dart';

abstract class NavigationBarState extends Equatable {
  const NavigationBarState();

  @override
  List<Object> get props => <Object>[];
}

class NavigationBarInitial extends NavigationBarState {
  const NavigationBarInitial();
}

class NavigationBarChanging extends NavigationBarState {
  const NavigationBarChanging();
}

class NavigationBarChanged extends NavigationBarState {
  const NavigationBarChanged(this.appBarTitle, this.page);

  final String appBarTitle;
  final int page;
}
