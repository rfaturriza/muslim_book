import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/quran/domain/entities/juz.codegen.dart';
import 'package:quranku/features/quran/presentation/bloc/detailJuz/detail_juz_bloc.dart';
import 'package:quranku/features/quran/presentation/bloc/juz/juz_cubit.dart';
import 'package:quranku/features/quran/presentation/screens/components/list_tile_juz.dart';
import 'package:quranku/features/quran/presentation/screens/detail_juz_screen.dart';

import '../../../../../core/components/search_box.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../injection.dart';
import '../../bloc/audioVerse/audio_verse_bloc.dart';

class JuzList extends StatelessWidget {
  const JuzList({super.key});

  @override
  Widget build(BuildContext context) {
    final juzBloc = context.read<JuzBloc>();

    return BlocBuilder<JuzBloc, JuzState>(
      bloc: juzBloc,
      builder: (context, state) {
        return ListView.separated(
          itemCount: () {
            if (state.isLoading) {
              return 2;
            } else if (state.listJuz != null) {
              return (state.listJuz?.length ?? 0) + 1;
            } else if (state.listJuz == null ||
                state.listJuz?.isEmpty == true) {
              return 2;
            } else {
              return 1;
            }
          }(),
          separatorBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const Divider(color: Colors.transparent);
            }
            return const Divider(thickness: 0.1);
          },
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: SearchBox(
                  isDense: true,
                  initialValue: state.query ?? emptyString,
                  hintText: LocaleKeys.search.tr(),
                  onChanged: (val) {
                    juzBloc.searchJuz(val);
                  },
                ),
              );
            }

            return BlocBuilder<JuzBloc, JuzState>(
              bloc: juzBloc,
              builder: (context, state) {
                if (state.isLoading) {
                  return const LinearProgressIndicator();
                }
                if (state.listJuz == null || state.listJuz?.isEmpty == true) {
                  return Center(
                    child: Text(
                      LocaleKeys.noData.tr(),
                      style: context.textTheme.headlineMedium,
                    ),
                  );
                }

                final juz = state.listJuz?[index - 1];
                return ListTileJuz(
                  onTapJuz: () => onTapJuz(context, juz),
                  number: juz?.number.toString() ?? emptyString,
                  name: juz?.name ?? emptyString,
                  description: juz?.description ?? emptyString,
                );
              },
            );
          },
        );
      },
    );
  }

  static void onTapJuz(BuildContext context, JuzConstant? juz,
      {int? jumpToVerse}) {
    context.navigateTo(
      MultiBlocProvider(
        providers: [
          BlocProvider<JuzDetailBloc>(
            create: (_) => sl<JuzDetailBloc>()
              ..add(FetchJuzDetailEvent(juzNumber: juz?.number ?? 0)),
          ),
          BlocProvider<AudioVerseBloc>(
            create: (context) => sl<AudioVerseBloc>(),
          ),
        ],
        child: DetailJuzScreen(juz: juz, jumpToVerse: jumpToVerse),
      ),
    );
  }
}
