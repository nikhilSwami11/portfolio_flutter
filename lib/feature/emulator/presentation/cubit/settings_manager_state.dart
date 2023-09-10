part of 'settings_manager_cubit.dart';

class SettingsManagerState extends Equatable {
  const SettingsManagerState();

  @override
  List<Object> get props => [];
}

class SettingsManagerInitial extends SettingsManagerState {}

class SettingsManagerData extends SettingsManagerState {
  final int colorIndex;
  final bool isAmPmFormat;

  const SettingsManagerData(
      {required this.colorIndex, required this.isAmPmFormat});

  @override
  List<Object> get props => [colorIndex, isAmPmFormat];
}
