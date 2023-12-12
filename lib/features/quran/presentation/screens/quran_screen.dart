import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/bookmark/presentation/screen/bookmark_screen.dart';
import 'package:quranku/features/qibla/presentation/screens/qibla_compass.dart';
import 'package:quranku/features/quran/presentation/screens/components/background_gradient.dart';
import 'package:quranku/features/quran/presentation/screens/components/juz_list.dart';
import 'package:quranku/features/quran/presentation/screens/components/main_app_bar.dart';
import 'package:quranku/features/shalat/presentation/components/shalat_info_card.dart';

import '../../../../generated/locale_keys.g.dart';
import 'components/surah_list.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = MainAppBar(
      onPressedMenu: () {},
      onPressedQibla: () {
        context.navigateTo(
          const QiblaCompassScreen(),
        );
      },
    );
    final controller = ScrollController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: appbar,
      body: Stack(
        children: [
          const BackgroundGradient(isShowBottom: false),
          SafeArea(
            child: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                scrollBehavior: const ScrollBehavior().copyWith(
                  physics: const BouncingScrollPhysics(),
                ),
                controller: controller,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverPersistentHeader(
                      key: const ValueKey('appbar'),
                      pinned: true,
                      delegate: BarHeaderPersistentDelegate(appBar),
                    ),
                    const SliverAppBar(
                      backgroundColor: Colors.transparent,
                      expandedHeight: 100.0,
                      pinned: false,
                      flexibleSpace: ShalatInfoCard(),
                      collapsedHeight: 100.0,
                    ),
                    SliverPersistentHeader(
                      key: const ValueKey('tabbar'),
                      pinned: true,
                      delegate: BarHeaderPersistentDelegate(
                        TabBar(
                          tabs: [
                            Tab(text: LocaleKeys.surah.tr()),
                            Tab(text: LocaleKeys.juz.tr()),
                            Tab(text: LocaleKeys.bookmark.tr()),
                          ],
                          labelStyle: context.textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ];
                },
                body: const TabBarView(
                  children: [
                    SurahList(),
                    JuzList(),
                    BookmarkScreen(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarHeaderPersistentDelegate extends SliverPersistentHeaderDelegate {
  BarHeaderPersistentDelegate(this._bar);

  final dynamic _bar;

  @override
  double get minExtent {
    if (_bar is PreferredSizeWidget) {
      return (_bar as PreferredSizeWidget).preferredSize.height;
    } else {
      return 0;
    }
  }

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Color animatedColor({double? offset}) {
      if (shrinkOffset > 0 && shrinkOffset < maxExtent) {
        return context.theme.colorScheme.background
            .withOpacity((shrinkOffset / maxExtent));
      } else if (shrinkOffset > 0) {
        return context.theme.colorScheme.background;
      } else {
        return Colors.transparent;
      }
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            animatedColor(),
            animatedColor(offset: 0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: _bar,
    );
  }

  @override
  bool shouldRebuild(BarHeaderPersistentDelegate oldDelegate) {
    return false;
  }
}
