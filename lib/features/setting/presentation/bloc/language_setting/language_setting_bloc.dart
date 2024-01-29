import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/language/get_latin_language_setting.dart';
import '../../../domain/usecases/language/get_prayer_language_setting.dart';
import '../../../domain/usecases/language/get_quran_language_setting.dart';
import '../../../domain/usecases/language/set_latin_language_setting.dart';
import '../../../domain/usecases/language/set_prayer_language_setting.dart';
import '../../../domain/usecases/language/set_quran_language_setting.dart';

part 'language_setting_bloc.freezed.dart';
part 'language_setting_event.dart';
part 'language_setting_state.dart';

@injectable
class LanguageSettingBloc
    extends Bloc<LanguageSettingEvent, LanguageSettingState> {
  final SetLatinLanguageSetting setLatinLanguageSetting;
  final SetPrayerTimeLanguageSetting setPrayerLanguageSetting;
  final SetQuranLanguageSetting setQuranLanguageSetting;
  final GetLatinLanguageSetting getLatinLanguageSetting;
  final GetPrayerTimeLanguageSetting getPrayerLanguageSetting;
  final GetQuranLanguageSetting getQuranLanguageSetting;

  LanguageSettingBloc(
    this.setLatinLanguageSetting,
    this.setPrayerLanguageSetting,
    this.setQuranLanguageSetting,
    this.getLatinLanguageSetting,
    this.getPrayerLanguageSetting,
    this.getQuranLanguageSetting,
  ) : super(const LanguageSettingState()) {
    on<_SetLatinLanguage>(_onSetLatinLanguage);
    on<_SetPrayerLanguage>(_onSetPrayerLanguage);
    on<_SetQuranLanguage>(_onSetQuranLanguage);
    on<_GetLatinLanguage>(_onGetLatinLanguage);
    on<_GetPrayerLanguage>(_onGetPrayerLanguage);
    on<_GetQuranLanguage>(_onGetQuranLanguage);
  }

  void _onSetLatinLanguage(_SetLatinLanguage event, emit) async {
    emit(state.copyWith(
      statusLatin: FormzSubmissionStatus.inProgress,
    ));
    final result = await setLatinLanguageSetting(
      SetLatinLanguageSettingParams(locale: event.locale),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        statusLatin: FormzSubmissionStatus.failure,
      )),
      (_) => emit(state.copyWith(
        statusLatin: FormzSubmissionStatus.success,
        languageLatin: event.locale,
      )),
    );
  }

  void _onSetPrayerLanguage(_SetPrayerLanguage event, emit) async {
    emit(state.copyWith(
      statusPrayerTime: FormzSubmissionStatus.inProgress,
    ));
    final result = await setPrayerLanguageSetting(
      SetPrayerTimeLanguageSettingParams(locale: event.locale),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        statusPrayerTime: FormzSubmissionStatus.failure,
      )),
      (_) => emit(state.copyWith(
        statusPrayerTime: FormzSubmissionStatus.success,
        languagePrayerTime: event.locale,
      )),
    );
  }

  void _onSetQuranLanguage(_SetQuranLanguage event, emit) async {
    emit(state.copyWith(
      statusQuran: FormzSubmissionStatus.inProgress,
    ));
    final result = await setQuranLanguageSetting(
      SetQuranLanguageSettingParams(locale: event.locale),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        statusQuran: FormzSubmissionStatus.failure,
      )),
      (_) => emit(state.copyWith(
        statusQuran: FormzSubmissionStatus.success,
        languageQuran: event.locale,
      )),
    );
  }

  void _onGetLatinLanguage(_GetLatinLanguage event, emit) async {
    final result = await getLatinLanguageSetting(NoParams());
    result.fold(
      (failure) {},
      (locale) => emit(state.copyWith(
        statusLatin: FormzSubmissionStatus.success,
        languageLatin: locale,
      )),
    );
  }

  void _onGetPrayerLanguage(_GetPrayerLanguage event, emit) async {
    final result = await getPrayerLanguageSetting(NoParams());
    result.fold(
      (failure) {},
      (locale) => emit(state.copyWith(
        statusPrayerTime: FormzSubmissionStatus.success,
        languagePrayerTime: locale,
      )),
    );
  }

  void _onGetQuranLanguage(_GetQuranLanguage event, emit) async {
    final result = await getQuranLanguageSetting(NoParams());
    result.fold(
      (failure) {},
      (locale) => emit(state.copyWith(
        statusQuran: FormzSubmissionStatus.success,
        languageQuran: locale,
      )),
    );
  }
}
