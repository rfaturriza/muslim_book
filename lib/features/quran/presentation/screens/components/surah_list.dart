import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/components/search_box.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color.dart';
import 'package:quranku/features/quran/presentation/bloc/detailSurah/detail_surah_bloc.dart';
import 'package:quranku/features/quran/presentation/bloc/surah/surah_bloc.dart';
import 'package:quranku/features/quran/presentation/screens/components/number_pin.dart';

import '../../../../../core/utils/extension/string_ext.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../injection.dart';
import '../../../domain/entities/surah.codegen.dart';
import '../detail_surah_screen.dart';

class SurahList extends StatelessWidget {
  const SurahList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final surahBloc = context.read<SurahBloc>();
    return BlocBuilder<SurahBloc, SurahState>(
      bloc: surahBloc,
      builder: (context, state) {
        final listSurah = state is SurahLoadedState ? state.listSurah : null;
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const Divider(color: Colors.transparent);
            }
            return Divider(color: secondaryColor.shade500,thickness: 0.1);
          },
          itemCount: () {
            if (state is SurahLoadingState) {
              return 2;
            } else if (state is SurahLoadedState) {
              if (listSurah == null || listSurah.isEmpty) {
                return 2;
              }
              return (listSurah.length) + 1;
            } else if (state is SurahErrorState) {
              return 2;
            } else {
              return 1;
            }
          }(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: SearchBox(
                  initialValue: surahBloc.state.query ?? emptyString,
                  hintText: LocaleKeys.search.tr(),
                  onChanged: (val) {
                    surahBloc.add(SurahFetchSearchEvent(query: val));
                  },
                  onSubmitted: () {
                    context.dismissKeyboard();
                  },
                ),
              );
            }

            return BlocBuilder<SurahBloc, SurahState>(
              bloc: surahBloc,
              builder: (context, state) {
                if (state is SurahLoadingState) {
                  return const LinearProgressIndicator();
                } else if (state is SurahErrorState) {
                  return Center(
                    child: Text(state.message ?? emptyString),
                  );
                }
                if (listSurah == null || listSurah.isEmpty) {
                  return Center(
                    child: Text(
                      LocaleKeys.noData.tr(),
                      style: context.textTheme.headlineMedium,
                    ),
                  );
                }

                final surahData = listSurah[index - 1];
                return ListTile(
                  onTap: () => _onTapSurah(context, surahData),
                  leading: NumberPin(
                    number: surahData.number?.toString() ?? emptyString,
                  ),
                  title: Text(
                    surahData.name?.transliteration?.id ?? emptyString,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${surahData.revelation?.id ?? emptyString} | ${surahData.numberOfVerses} Ayat',
                    style: context.textTheme.bodyMedium,
                  ),
                  trailing: Text(
                    surahData.name?.short ?? emptyString,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: defaultColor.shade50,
                      fontFamily: FontConst.decoTypeThuluthII,
                      fontSize: 25,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _onTapSurah(BuildContext context, Surah? surah) {
    final locale = context.locale;
    final isIndonesia = locale == const Locale('id');
    final isEnglish = locale == const Locale('en');
    final surahName = (){
      if (isEnglish) {
        return surah?.name?.transliteration?.en;
      } else if (isIndonesia) {
        return surah?.name?.transliteration?.id;
      } else {
        return surah?.name?.short;
      }
    }();
    context.navigateTo(
      BlocProvider<SurahDetailBloc>(
        create: (_) => sl<SurahDetailBloc>()
          ..add(
            SurahDetailFetchEvent(surahNumber: surah?.number),
          ),
        child: DetailSurahScreen(
          surahName: surahName,
        ),
      ),
    );
  }
}
