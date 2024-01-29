import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetTranslationFontSizeSetting
    extends UseCase<Unit?, SetTranslationFontSizeSettingParams> {
  final StylingSettingRepository repository;

  SetTranslationFontSizeSetting(this.repository);

  @override
  Future<Either<Failure, Unit?>> call(
      SetTranslationFontSizeSettingParams params) async {
    return await repository.setTranslationFontSize(params.fontSize);
  }
}

class SetTranslationFontSizeSettingParams extends Equatable {
  final double fontSize;

  const SetTranslationFontSizeSettingParams(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}
