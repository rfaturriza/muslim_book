part of 'audio_verse_bloc.dart';

@freezed
class AudioVerseState with _$AudioVerseState {
  const factory AudioVerseState({
    @Default(PlayerState.stopped) PlayerState playerState,
    @Default(Duration()) Duration position,
    @Default(Duration()) Duration duration,
    @Default(false) isShowBottomNavPlayer,
    Audio? audioVersePlaying,
    List<Audio?>? listAudioVerses,
    String? errorMessage,
  }) = _AudioVerseState;
}
