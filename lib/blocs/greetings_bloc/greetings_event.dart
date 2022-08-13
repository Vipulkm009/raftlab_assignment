part of 'greetings_bloc.dart';

@immutable
abstract class GreetingsEvent {}

class MorningToNoon extends GreetingsEvent {}

class NoonToEvening extends GreetingsEvent {}

class EveningToMorning extends GreetingsEvent {}