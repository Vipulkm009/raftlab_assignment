part of 'greetings_bloc.dart';

@immutable
abstract class GreetingsState {}

class GreetingsMorning extends GreetingsState {}

class GreetingsAfternoon extends GreetingsState {}

class GreetingsEvening extends GreetingsState {}