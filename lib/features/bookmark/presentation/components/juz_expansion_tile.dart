import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
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
      backgroundColor: context.theme.colorScheme.surface,
      collapsedBackgroundColor: context.theme.colorScheme.surfaceContainerHighest,
      initiallyExpanded: isExpanded,
      trailing: isExpanded
          ? Icon(
              Icons.expand_circle_down,
              color: context.theme.colorScheme.onSurfaceVariant,
            )
          : RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.expand_circle_down_outlined,
                color: context.theme.colorScheme.onSurfaceVariant,
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
          color: context.theme.colorScheme.onSurfaceVariant,
        ),
      ),
      children: [
        ...listJuz.map(
          (e) => ListTileJuz(
            onTapJuz: () => onTapJuz(e),
            number: e.number.toString(),
            name: e.name,
            backgroundColor: context.theme.colorScheme.surface,
            description: e.description,
          ),
        ),
      ],
    );
  }
}
