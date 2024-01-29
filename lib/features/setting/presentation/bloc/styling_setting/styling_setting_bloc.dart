import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/features/setting/domain/usecases/styling/set_arabic_font_size_setting.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/styling/get_arabic_font_family_setting.dart';
import '../../../domain/usecases/styling/get_arabic_font_size_setting.dart';
import '../../../domain/usecases/styling/get_latin_font_size_setting.dart';
import '../../../domain/usecases/styling/get_translation_font_size_setting.dart';
import '../../../domain/usecases/styling/set_arabic_font_family_setting.dart';
import '../../../domain/usecases/styling/set_latin_font_size_setting.dart';
import '../../../domain/usecases/styling/set_translation_font_size_setting.dart';

part 'styling_setting_bloc.freezed.dart';
part 'styling_setting_event.dart';
part 'styling_setting_state.dart';

@injectable
class StylingSettingBloc
    extends Bloc<StylingSettingEvent, StylingSettingState> {
  final SetArabicFontFamilySetting setArabicFontFamilySetting;
  final GetArabicFontFamilySetting getArabicFontFamilySetting;
  final SetArabicFontSizeSetting setArabicFontSizeSetting;
  final GetArabicFontSizeSetting getArabicFontSizeSetting;
  final SetLatinFontSizeSetting setLatinFontSizeSetting;
  final GetLatinFontSizeSetting getLatinFontSizeSetting;
  final SetTranslationFontSizeSetting setTranslationFontSizeSetting;
  final GetTranslationFontSizeSetting getTranslationFontSizeSetting;

  StylingSettingBloc(
    this.setArabicFontFamilySetting,
    this.getArabicFontFamilySetting,
    this.setArabicFontSizeSetting,
    this.getArabicFontSizeSetting,
    this.setLatinFontSizeSetting,
    this.getLatinFontSizeSetting,
    this.setTranslationFontSizeSetting,
    this.getTranslationFontSizeSetting,
  ) : super(const StylingSettingState()) {
    on<_SetArabicFontFamily>(_onSetArabicFontFamily);
    on<_SetArabicFontSize>(_onSetArabicFontSize);
    on<_SetLatinFontSize>(_onSetLatinFontSize);
    on<_SetTranslationFontSize>(_onSetTranslationFontSize);
    on<_GetArabicFontFamily>(_onGetArabicFontFamily);
    on<_GetArabicFontSize>(_onGetArabicFontSize);
    on<_GetLatinFontSize>(_onGetLatinFontSize);
    on<_GetTranslationFontSize>(_onGetTranslationFontSize);
  }

  void _onSetArabicFontFamily(_SetArabicFontFamily event, emit) async {
    emit(state.copyWith(
      statusArabicFontFamily: FormzSubmissionStatus.inProgress,
    ));
    final result = await setArabicFontFamilySetting(
      SetArabicFontFamilySettingParams(event.fontFamily),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        statusArabicFontFamily: FormzSubmissionStatus.failure,
      )),
      (_) => emit(state.copyWith(
        statusArabicFontFamily: FormzSubmissionStatus.success,
        fontFamilyArabic: event.fontFamily,
      )),
    );
  }

  void _onSetArabicFontSize(_SetArabicFontSize event, emit) async {
    emit(state.copyWith(
      statusArabicFontSize: FormzSubmissionStatus.inProgress,
    ));
    final result = await setArabicFontSizeSetting(
      SetArabicFontSizeSettingParams(event.fontSize),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        statusArabicFontSize: FormzSubmissionStatus.failure,
      )),
      (_) => emit(state.copyWith(
        statusArabicFontSize: FormzSubmissionStatus.success,
        arabicFontSize: event.fontSize,
      )),
    );
  }

  void _onSetLatinFontSize(_SetLatinFontSize event, emit) async {
    emit(state.copyWith(
      statusLatinFontSize: FormzSubmissionStatus.inProgress,
    ));
    final result = await setLatinFontSizeSetting(
      SetLatinFontSizeSettingParams(event.fontSize),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        statusLatinFontSize: FormzSubmissionStatus.failure,
      )),
      (_) => emit(state.copyWith(
        statusLatinFontSize: FormzSubmissionStatus.success,
        latinFontSize: event.fontSize,
      )),
    );
  }

  void _onSetTranslationFontSize(_SetTranslationFontSize event, emit) async {
    emit(state.copyWith(
      statusTranslationFontSize: FormzSubmissionStatus.inProgress,
    ));
    final result = await setTranslationFontSizeSetting(
      SetTranslationFontSizeSettingParams(event.fontSize),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        statusTranslationFontSize: FormzSubmissionStatus.failure,
      )),
      (_) => emit(state.copyWith(
        statusTranslationFontSize: FormzSubmissionStatus.success,
        translationFontSize: event.fontSize,
      )),
    );
  }

  void _onGetArabicFontFamily(_GetArabicFontFamily event, emit) async {
    final result = await getArabicFontFamilySetting(NoParams());
    result.fold(
      (failure) {},
      (fontFamily) => emit(state.copyWith(
        statusArabicFontFamily: FormzSubmissionStatus.success,
        fontFamilyArabic: fontFamily ?? FontConst.lpmqIsepMisbah,
      )),
    );
  }

  void _onGetArabicFontSize(_GetArabicFontSize event, emit) async {
    final result = await getArabicFontSizeSetting(NoParams());
    result.fold(
      (failure) {},
      (fontSize) => emit(state.copyWith(
        statusArabicFontSize: FormzSubmissionStatus.success,
        arabicFontSize: fontSize ?? FontConst.defaultArabicFontSize,
      )),
    );
  }

  void _onGetLatinFontSize(_GetLatinFontSize event, emit) async {
    final result = await getLatinFontSizeSetting(NoParams());
    result.fold(
      (failure) {},
      (fontSize) => emit(state.copyWith(
        statusLatinFontSize: FormzSubmissionStatus.success,
        latinFontSize: fontSize ?? FontConst.defaultLatinFontSize,
      )),
    );
  }

  void _onGetTranslationFontSize(_GetTranslationFontSize event, emit) async {
    final result = await getTranslationFontSizeSetting(NoParams());
    result.fold(
      (failure) {},
      (fontSize) => emit(state.copyWith(
        statusTranslationFontSize: FormzSubmissionStatus.success,
        translationFontSize: fontSize ?? FontConst.defaultTranslationFontSize,
      )),
    );
  }
}
