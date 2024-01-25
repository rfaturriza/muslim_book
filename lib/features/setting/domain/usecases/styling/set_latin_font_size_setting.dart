import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetLatinFontSizeSetting
    extends UseCase<Unit?, SetLatinFontSizeSettingParams> {
  final StylingSettingRepository repository;

  SetLatinFontSizeSetting(this.repository);

  @override
  Future<Either<Failure, Unit?>> call(
      SetLatinFontSizeSettingParams params) async {
    return await repository.setLatinFontSize(params.fontSize);
  }
}

class SetLatinFontSizeSettingParams extends Equatable {
  final double fontSize;

  const SetLatinFontSizeSettingParams(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}
