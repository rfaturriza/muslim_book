import 'package:freezed_annotation/freezed_annotation.dart';

part 'juz_bookmark.codegen.freezed.dart';

@freezed
class JuzBookmark with _$JuzBookmark {
  const factory JuzBookmark({
    required String name,
    required int number,
    required String description,
  }) = _JuzBookmark;
}
