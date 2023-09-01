import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/quran/presentation/bloc/detailJuz/detail_juz_bloc.dart';
import 'package:quranku/features/quran/presentation/bloc/juz/juz_cubit.dart';
import 'package:quranku/features/quran/presentation/screens/constant.dart';
import 'package:quranku/features/quran/presentation/screens/detail_juz_screen.dart';

import '../../../../../core/components/search_box.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../injection.dart';

class JuzList extends StatelessWidget {
  const JuzList({Key? key}) : super(key: key);

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
            return const Divider();
          },
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: SearchBox(
                  initialValue: state.query ?? emptyString,
                  hintText: LocaleKeys.search.tr(),
                  onChanged: (val) {
                    juzBloc.searchJuz(val);
                  },
                  onSubmitted: () {
                    context.dismissKeyboard();
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
                return ListTile(
                  onTap: () => _onTapJuz(context, juz),
                  leading: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/number.svg'),
                      Text(
                        juz?.number.toString() ?? emptyString,
                        style: context.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  title: Text(
                    juz?.name ?? emptyString,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    juz?.description ?? emptyString,
                    style: context.textTheme.bodyMedium,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _onTapJuz(BuildContext context, JuzConstant? juz) {
    context.navigateTo(
      BlocProvider<JuzDetailBloc>(
        create: (_) => sl<JuzDetailBloc>()
          ..add(
            JuzDetailFetchEvent(juzNumber: juz?.number ?? 0),
          ),
        child: DetailJuzScreen(juzName: juz?.name ?? emptyString),
      ),
    );
  }
}
