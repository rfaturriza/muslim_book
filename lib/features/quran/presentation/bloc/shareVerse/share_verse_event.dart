part of 'share_verse_bloc.dart';

@freezed
class ShareVerseEvent with _$ShareVerseEvent {
  const factory ShareVerseEvent.onInit({
    required final Verses verse,
    final JuzConstant? juz,
    final DetailSurah? surah,
  }) = _OnInit;

  const factory ShareVerseEvent.onChangeBackgroundColor(Color color) =
      _OnChangeBackgroundColor;

  const factory ShareVerseEvent.onChangeFontSize(double fontSize) =
      _OnChangeFontSize;

  const factory ShareVerseEvent.onToggleArabicVisibility(bool? value) =
      _OnToggleArabicVisibility;

  const factory ShareVerseEvent.onToggleLatinVisibility(bool? value) =
      _OnToggleLatinVisibility;

  const factory ShareVerseEvent.onToggleTranslationVisibility(bool? value) =
      _OnToggleTranslationVisibility;

  const factory ShareVerseEvent.onSharePressed(
      RenderRepaintBoundary? boundary) = _OnSharePressed;
}
