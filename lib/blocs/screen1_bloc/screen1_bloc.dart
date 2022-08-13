import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen1_event.dart';
part 'screen1_state.dart';

class Screen1Bloc extends Bloc<Screen1Event, Screen1State> {
  Screen1Bloc() : super(Screen1Initial()) {
    on<Screen1FetchEvent>((event, emit) {
      emit(Screen1Fetched());
    });

    on<Screen1SavedEvent>((event, emit) {
      emit(Screen1Saved());
    });

    on<Screen1SavingEvent>((event, emit) {
      emit(Screen1Saving());
    });
  }
}
