part of 'share_verse_bloc.dart';

@freezed
class ShareVerseState with _$ShareVerseState {
  const factory ShareVerseState({
    Verses? verse,
    JuzConstant? juz,
    DetailSurah? surah,
    @Default(false) bool isLoading,
    Color? backgroundColor,
    @Default(10) double fontSize,
    @Default(true) bool isArabicVisible,
    @Default(true) bool isLatinVisible,
    @Default(true) bool isTranslationVisible,
  }) = _ShareVerseState;
}
