part of 'language_setting_bloc.dart';

@freezed
class LanguageSettingState with _$LanguageSettingState {
  const factory LanguageSettingState({
    Locale? localeLatin,
    Locale? localePrayerTime,
    Locale? localeQuran,
  }) = _SettingState;
}
