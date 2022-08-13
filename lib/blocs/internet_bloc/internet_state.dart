part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}

class InternetLoss extends InternetState {}

class InternetGained extends InternetState {}
