import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/quran/presentation/screens/components/verses_list.dart';

import '../../../../core/components/loading_screen.dart';
import '../bloc/detailJuz/detail_juz_bloc.dart';
import 'components/app_bar_detail_screen.dart';

class DetailJuzScreen extends StatelessWidget {
  final String? juzName;

  const DetailJuzScreen({Key? key, this.juzName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBarDetailScreen(title: juzName ?? emptyString),
          ];
        },
        body: BlocBuilder<JuzDetailBloc, JuzDetailState>(
          builder: (context, state) {
            if (state is JuzDetailLoadingState) {
              return const LoadingScreen();
            } else if (state is JuzDetailLoadedState) {
              final ayahs = state.detailJuz?.verses;

              return VersesList(listVerses: ayahs ?? []);
            } else if (state is JuzErrorState) {
              return Center(child: Text('${state.message}'));
            }

            return Container();
          },
        ),
      ),
    );
  }
}
