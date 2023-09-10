import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'light_state.dart';

class LightCubit extends Cubit<LightState> {
  LightCubit() : super(LightInitial());

  bool _lightTurnedOn = true;

  void toggleLights() {
    _lightTurnedOn = !_lightTurnedOn;
    if (_lightTurnedOn) {
      emit(LightTurnedOn());
    } else {
      emit(LightTurnedOff());
    }
  }
}
