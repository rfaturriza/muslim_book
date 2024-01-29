part of 'styling_setting_bloc.dart';

@freezed
class StylingSettingEvent with _$StylingSettingEvent {
  const factory StylingSettingEvent.setArabicFontFamily({
    required String fontFamily,
  }) = _SetArabicFontFamily;

  const factory StylingSettingEvent.setArabicFontSize({
    required double fontSize,
  }) = _SetArabicFontSize;

  const factory StylingSettingEvent.setLatinFontSize({
    required double fontSize,
  }) = _SetLatinFontSize;

  const factory StylingSettingEvent.setTranslationFontSize({
    required double fontSize,
  }) = _SetTranslationFontSize;

  const factory StylingSettingEvent.getArabicFontFamily() =
      _GetArabicFontFamily;

  const factory StylingSettingEvent.getArabicFontSize() = _GetArabicFontSize;

  const factory StylingSettingEvent.getLatinFontSize() = _GetLatinFontSize;

  const factory StylingSettingEvent.getTranslationFontSize() =
      _GetTranslationFontSize;
}
