import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/setting/domain/repositories/styling_setting_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

@injectable
class SetArabicFontFamilySetting
    extends UseCase<Unit?, SetArabicFontFamilySettingParams> {
  final StylingSettingRepository repository;

  SetArabicFontFamilySetting(this.repository);

  @override
  Future<Either<Failure, Unit?>> call(
      SetArabicFontFamilySettingParams params) async {
    return await repository.setArabicFontFamily(params.fontFamily);
  }
}

class SetArabicFontFamilySettingParams extends Equatable {
  final String fontFamily;

  const SetArabicFontFamilySettingParams(this.fontFamily);

  @override
  List<Object?> get props => [fontFamily];
}
