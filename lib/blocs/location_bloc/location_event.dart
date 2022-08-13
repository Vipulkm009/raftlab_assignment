part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class FindLocation extends LocationEvent {
  String distance;
  FindLocation(this.distance);
}
