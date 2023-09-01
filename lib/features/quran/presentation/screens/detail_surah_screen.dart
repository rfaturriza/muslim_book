import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/components/loading_screen.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/quran/presentation/screens/components/app_bar_detail_screen.dart';
import 'package:quranku/features/quran/presentation/screens/components/verses_list.dart';

import '../bloc/detailSurah/detail_surah_bloc.dart';

class DetailSurahScreen extends StatelessWidget {
  final String? surahName;

  const DetailSurahScreen({Key? key, this.surahName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBarDetailScreen(title: surahName ?? emptyString),
          ];
        },
        body: BlocBuilder<SurahDetailBloc, SurahDetailState>(
          builder: (context, state) {
            if (state is SurahDetailLoadingState) {
              return const LoadingScreen();
            } else if (state is SurahDetailLoadedState) {
              final ayahs = state.detailSurah?.verses;

              return VersesList(
                listVerses: ayahs ?? [],
                preBismillah: state.detailSurah?.preBismillah?.text?.arab,
              );
            } else if (state is SurahDetailErrorState) {
              return Center(child: Text('${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
