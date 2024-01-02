import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/set_latin_language_setting.dart';
import '../../../domain/usecases/set_prayer_language_setting.dart';
import '../../../domain/usecases/set_quran_language_setting.dart';

part 'language_setting_bloc.freezed.dart';
part 'language_setting_event.dart';
part 'language_setting_state.dart';

@injectable
class LanguageSettingBloc
    extends Bloc<LanguageSettingEvent, LanguageSettingState> {
  final SetLatinLanguageSetting setLatinLanguageSetting;
  final SetPrayerTimeLanguageSetting setPrayerLanguageSetting;
  final SetQuranLanguageSetting setQuranLanguageSetting;

  LanguageSettingBloc(
    this.setLatinLanguageSetting,
    this.setPrayerLanguageSetting,
    this.setQuranLanguageSetting,
  ) : super(const LanguageSettingState()) {
    on<LanguageSettingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
