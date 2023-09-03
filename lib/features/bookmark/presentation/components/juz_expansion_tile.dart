import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../quran/presentation/screens/components/list_tile_juz.dart';
import '../../domain/entities/juz_bookmark.codegen.dart';
import '../bloc/bookmark/bookmark_bloc.dart';

class JuzExpansionTile extends StatelessWidget {
  final bool isExpanded;
  final List<JuzBookmark> listJuz;
  final Function(JuzBookmark) onTapJuz;

  const JuzExpansionTile({
    super.key,
    this.isExpanded = false,
    required this.listJuz,
    required this.onTapJuz,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: secondaryColor.shade500,
      collapsedBackgroundColor: secondaryColor.shade500,
      initiallyExpanded: isExpanded,
      trailing: isExpanded
          ? Icon(
              Icons.expand_circle_down,
              color: defaultColor.shade300,
            )
          : RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.expand_circle_down_outlined,
                color: defaultColor.shade300,
              ),
            ),
      onExpansionChanged: (value) {
        context.read<BookmarkBloc>().add(
              BookmarkEvent.onChangedExpansionPanel(
                index: BookmarkPanelConstant.juz,
                isExpanded: value,
              ),
            );
      },
      title: Text(
        LocaleKeys.juz.tr(),
        style: context.textTheme.titleMedium?.copyWith(
          color: defaultColor.shade300,
        ),
      ),
      children: [
        ...listJuz.map(
          (e) => ListTileJuz(
            onTapJuz: () => onTapJuz(e),
            number: e.number.toString(),
            name: e.name,
            backgroundColor: context.theme.colorScheme.background,
            description: e.description,
          ),
        ),
      ],
    );
  }
}
