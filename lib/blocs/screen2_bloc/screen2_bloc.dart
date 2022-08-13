import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen2_event.dart';
part 'screen2_state.dart';

class Screen2Bloc extends Bloc<Screen2Event, Screen2State> {
  Screen2Bloc() : super(Screen2Initial()) {
    on<CategoryChangingEvent>((event, emit) {
      emit(Screen2CategoryChanged());
    });

    on<CategoryChangedEvent>((event, emit) {
      emit(Screen2Initial());
    });
  }
}
