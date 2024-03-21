import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/constants/asset_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/kajian/presentation/bloc/prayerSchedule/prayer_schedule_bloc.dart';
import 'package:quranku/features/kajian/presentation/screens/ramadhan_screen.dart';

import '../../../../injection.dart';
import '../bloc/kajian/kajian_bloc.dart';
import 'kajian_screen.dart';

class KajianHubScreen extends StatelessWidget {
  const KajianHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<KajianBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PrayerScheduleBloc>(),
        ),
      ],
      child: const KajianHubScaffold(),
    );
  }
}

class KajianHubScaffold extends StatefulWidget {
  const KajianHubScaffold({super.key});

  @override
  State<KajianHubScaffold> createState() => _KajianHubScaffoldState();
}

class _KajianHubScaffoldState extends State<KajianHubScaffold>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController controller;
  late bool isShowFloatingButton = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<KajianBloc>().add(
          KajianEvent.fetchKajian(
            locale: context.locale,
            pageNumber: 1,
          ),
        );
  }

  @override
  void initState() {
    controller = ScrollController();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        final index = tabController.index;
        if (index == 0) {
          context.read<KajianBloc>().add(
                KajianEvent.fetchKajian(
                  locale: context.locale,
                  pageNumber: 1,
                ),
              );
        } else {
          context.read<PrayerScheduleBloc>().add(
                PrayerScheduleEvent.fetchRamadhanSchedules(
                  locale: context.locale,
                  pageNumber: 1,
                ),
              );
        }
      }
    });
    controller.addListener(() {
      if (controller.position.pixels > 0) {
        if (!isShowFloatingButton) {
          setState(() {
            isShowFloatingButton = true;
          });
        }
      } else {
        if (isShowFloatingButton) {
          setState(() {
            isShowFloatingButton = false;
          });
        }
      }
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (tabController.index == 0) {
          context.read<KajianBloc>().add(
                KajianEvent.fetchKajian(
                  locale: context.locale,
                  pageNumber: context.read<KajianBloc>().state.currentPage + 1,
                ),
              );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabBar = TabBar(
      controller: tabController,
      tabs: const [
        Tab(text: 'Kajian'),
        Tab(text: 'Ramadhan'),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          context.isDarkMode
              ? AssetConst.kajianHubTextLogoLight
              : AssetConst.kajianHubTextLogoDark,
          width: 100,
        ),
      ),
      floatingActionButton: isShowFloatingButton
          ? FloatingActionButton(
              onPressed: () {
                controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: NestedScrollView(
            controller: controller,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: const SizedBox(),
                  backgroundColor: Colors.transparent,
                  expandedHeight: tabBar.preferredSize.height + 8,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: tabBar,
                  ),
                  collapsedHeight: tabBar.preferredSize.height + 8,
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                KajianScreen(),
                RamadhanScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
