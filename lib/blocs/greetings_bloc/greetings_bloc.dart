import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'greetings_event.dart';
part 'greetings_state.dart';

class GreetingsBloc extends Bloc<GreetingsEvent, GreetingsState> {
  TimeOfDay? current;

  GreetingsBloc() : super(GreetingsMorning()) {
    current = TimeOfDay.now();
    on<MorningToNoon>((event, emit) {
      emit(GreetingsAfternoon());
    });

    on<NoonToEvening>((event, emit) {
      emit(GreetingsEvening());
    });

    on<EveningToMorning>((event, emit) {
      emit(GreetingsMorning());
    });

    print(current!.hour);
    if (current!.hour >= 4 && current!.hour < 12) {
      add(EveningToMorning());
    } else if (current!.hour >= 12 && current!.hour < 16) {
      add(MorningToNoon());
    } else {
      add(NoonToEvening());
    }
  }
}
