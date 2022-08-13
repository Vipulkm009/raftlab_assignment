import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc() : super(AudioPaused()) {
    on<PauseAudioEvents>((event, emit) {
      emit(AudioPaused());
    });

    on<PlayAudioEvents>((event, emit) {
      emit(AudioPlayed());
    });
  }
}
