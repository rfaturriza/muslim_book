import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quranku/core/components/error_screen.dart';
import 'package:quranku/core/components/search_box.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/components/spacer.dart';
import '../../../../core/utils/pair.dart';
import '../bloc/prayerSchedule/prayer_schedule_bloc.dart';
import '../components/label_tag.dart';
import '../components/mosque_image_container.dart';
import '../components/schedule_icon_text.dart';

class RamadhanScreen extends StatelessWidget {
  const RamadhanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpacer(height: 10),
        SearchBox(
          isDense: true,
          initialValue: '',
          hintText: LocaleKeys.searchRamadhanHint.tr(),
          onChanged: (value) {},
          onSubmitted: () {},
        ),
        const VSpacer(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
                        buildWhen: (previous, current) =>
                        previous.isNearby != current.isNearby,
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              context.read<PrayerScheduleBloc>().add(
                                const PrayerScheduleEvent.toggleNearby(),
                              );
                              context.read<PrayerScheduleBloc>().add(
                                PrayerScheduleEvent.fetchRamadhanSchedules(
                                  locale: context.locale,
                                  pageNumber: 1,
                                ),
                              );
                            },
                            child: Chip(
                              label: Text(LocaleKeys.nearby.tr()),
                              backgroundColor: state.isNearby
                                  ? context.theme.colorScheme.secondaryContainer
                                  : null,
                            ),
                          );
                        },
                      ),
                      const HSpacer(width: 5),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: context.theme.colorScheme.tertiary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: context.theme.colorScheme.tertiary,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.settings_input_composite_outlined,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              context.read<PrayerScheduleBloc>().add(
                    PrayerScheduleEvent.fetchRamadhanSchedules(
                      locale: context.locale,
                      pageNumber: 1,
                    ),
                  );
              return Future.delayed(const Duration(seconds: 500));
            },
            child: BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
              builder: (context, state) {
                final isLoading =
                    state.status == FormzSubmissionStatus.inProgress;
                if (state.status == FormzSubmissionStatus.failure) {
                  return ErrorScreen(
                    message: LocaleKeys.errorGetRamadhanSchedule.tr(),
                    onRefresh: () {
                      context.read<PrayerScheduleBloc>().add(
                            PrayerScheduleEvent.fetchRamadhanSchedules(
                              locale: context.locale,
                              pageNumber: 1,
                            ),
                          );
                    },
                  );
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                            scrollNotification.metrics.maxScrollExtent &&
                        state.status != FormzSubmissionStatus.inProgress) {
                      context.read<PrayerScheduleBloc>().add(
                            PrayerScheduleEvent.fetchRamadhanSchedules(
                              locale: context.locale,
                              pageNumber: state.currentPage + 1,
                            ),
                          );
                    }
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: isLoading
                        ? state.ramadhanSchedules.length + 1
                        : state.ramadhanSchedules.length,
                    itemBuilder: (context, index) {
                      if (isLoading &&
                          index == state.ramadhanSchedules.length) {
                        return const Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                      final schedule = state.ramadhanSchedules[index];
                      return _RamadhanTile(
                        imageUrl:
                            schedule.studyLocation?.pictureUrl ?? emptyString,
                        prayerName: schedule.subtypeLabel ?? emptyString,
                        title: schedule.studyLocation?.name ?? emptyString,
                        imam: schedule.imam ?? emptyString,
                        khatib: schedule.khatib ?? emptyString,
                        date: schedule.prayDate ?? emptyString,
                        place: schedule.studyLocation?.address ?? emptyString,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _RamadhanTile extends StatelessWidget {
  final String imageUrl;
  final String prayerName;
  final String title;
  final String imam;
  final String khatib;
  final String date;
  final String place;

  const _RamadhanTile({
    required this.imageUrl,
    required this.prayerName,
    required this.title,
    required this.imam,
    required this.khatib,
    required this.date,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final Pair<Color, Color> prayerColor = () {
      switch (prayerName.toLowerCase()) {
        case 'subuh':
          return Pair(
            context.theme.colorScheme.tertiaryContainer,
            context.theme.colorScheme.onTertiaryContainer,
          );
        case 'terawih':
          return Pair(
            context.theme.colorScheme.secondaryContainer,
            context.theme.colorScheme.onSecondaryContainer,
          );
        default:
          return Pair(
            context.theme.colorScheme.primaryContainer,
            context.theme.colorScheme.onPrimaryContainer,
          );
      }
    }();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: ShapeDecoration(
        color: context.theme.colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MosqueImageContainer(
            imageUrl: imageUrl,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelTag(
                          title: prayerName,
                          backgroundColor: prayerColor.first,
                          foregroundColor: prayerColor.second,
                        ),
                        Text(
                          title,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const VSpacer(height: 2),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Imam: ',
                            style: context.textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: imam,
                            style: context.textTheme.bodySmall,
                          ),
                        ])),
                        const VSpacer(height: 2),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Khatib: ',
                            style: context.textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: khatib,
                            style: context.textTheme.bodySmall,
                          ),
                        ])),
                        const VSpacer(height: 2),
                        ScheduleIconText(
                          icon: Icons.date_range_outlined,
                          text: date,
                        ),
                        const VSpacer(height: 2),
                        ScheduleIconText(
                          icon: Icons.place_outlined,
                          text: place,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
