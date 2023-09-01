import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/language_model.codegen.dart';

part 'language.codegen.freezed.dart';

@freezed
class Language with _$Language {
  const factory Language({
    String? arab,
    String? en,
    String? id,
  }) = _Language;

  const Language._();

  LanguageModel toModel() => LanguageModel(
    arab: arab,
    id: id,
    en: en,
  );
}
