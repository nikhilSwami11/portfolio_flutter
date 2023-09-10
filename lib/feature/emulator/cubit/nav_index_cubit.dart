import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'nav_index_state.dart';

class NavIndexCubit extends Cubit<NavIndexState> {
  NavIndexCubit() : super(NavIndexInitial());

  int index = 0;
  final PageController pageController = PageController();

  void updateNavIndex(int newIndex) {
    index = newIndex;
    pageController.jumpToPage(newIndex);
    emit(NavIndexCurrent(currentIndex: newIndex));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
