part of 'audio_player_bloc.dart';

@immutable
abstract class AudioPlayerState {}

class AudioPlayed extends AudioPlayerState {}

class AudioPaused extends AudioPlayerState {}