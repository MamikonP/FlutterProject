import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(const NavigationBarInitial());

  int _page = 0;
  static final PageController _pageController = PageController();

  int get currentPage => _page;
  static PageController get pageController => _pageController;

  void navigateTo(String name, int page) {
    emit(const NavigationBarChanging());
    emit(NavigationBarChanged(name, page));
    _page = page;
  }
}
