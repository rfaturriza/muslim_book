import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quranku/features/quran/data/models/detail_surah_model.codegen.dart';
import 'package:quranku/features/quran/domain/entities/language.codegen.dart';

import 'surah_name.codegen.dart';
import 'verses.codegen.dart';

part 'detail_surah.codegen.freezed.dart';

@freezed
class DetailSurah with _$DetailSurah {
  const factory DetailSurah({
    bool? isBookmarked,
    int? number,
    int? sequence,
    int? numberOfVerses,
    SurahName? name,
    Language? revelation,
    Language? tafsir,
    PreBismillah? preBismillah,
    List<Verses>? verses,
  }) = _DetailSurah;

  const DetailSurah._();

  DataDetailSurahModel toModel() => DataDetailSurahModel(
        number: number,
        sequence: sequence,
        numberOfVerses: numberOfVerses,
        name: name?.toModel(),
        revelation: revelation?.toModel(),
        tafsir: tafsir?.toModel(),
        preBismillah: preBismillah?.toModel(),
        verses: verses?.map((e) => e.toModel()).toList(),
      );
}

@freezed
class PreBismillah with _$PreBismillah {
  const factory PreBismillah({
    VersesText? text,
  }) = _PreBismillah;

  const PreBismillah._();

  PreBismillahModel toModel() => PreBismillahModel(
        text: text?.toModel(),
      );
}
