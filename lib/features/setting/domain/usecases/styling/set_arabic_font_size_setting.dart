import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetArabicFontSizeSetting
    extends UseCase<Unit?, SetArabicFontSizeSettingParams> {
  final StylingSettingRepository repository;

  SetArabicFontSizeSetting(this.repository);

  @override
  Future<Either<Failure, Unit?>> call(
      SetArabicFontSizeSettingParams params) async {
    return await repository.setArabicFontSize(params.fontSize);
  }
}

class SetArabicFontSizeSettingParams extends Equatable {
  final double fontSize;

  const SetArabicFontSizeSettingParams(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}
