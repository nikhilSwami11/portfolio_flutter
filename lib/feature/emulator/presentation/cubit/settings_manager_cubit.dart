import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_manager_state.dart';

class SettingsManagerCubit extends Cubit<SettingsManagerState> {
  SettingsManagerCubit() : super(SettingsManagerInitial());

  int index = 0;
  bool isAmPm = false;
  Color selectedColor = Colors.transparent;

  void changeColor(int newIndex, Color newColor) {
    index = newIndex;
    selectedColor = newColor;
    emit(SettingsManagerData(colorIndex: index, isAmPmFormat: isAmPm));
  }

  void changeAmPmFormat(bool isAmPmFormat) {
    isAmPm = isAmPmFormat;
    emit(SettingsManagerData(colorIndex: index, isAmPmFormat: isAmPm));
  }
}
