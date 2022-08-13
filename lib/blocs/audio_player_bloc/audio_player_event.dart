part of 'audio_player_bloc.dart';

@immutable
abstract class AudioPlayerEvent {}

class PlayAudioEvents extends AudioPlayerEvent {}

class PauseAudioEvents extends AudioPlayerEvent {}