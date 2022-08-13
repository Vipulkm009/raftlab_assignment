part of 'screen1_bloc.dart';

@immutable
abstract class Screen1Event {}

class Screen1FetchEvent extends Screen1Event {}

class Screen1SavedEvent extends Screen1Event {}

class Screen1SavingEvent extends Screen1Event {}