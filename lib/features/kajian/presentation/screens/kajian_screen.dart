import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quranku/core/components/search_box.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/kajian/domain/entities/day_kajian.codegen.dart';
import 'package:quranku/features/kajian/domain/entities/prayer_kajian.codegen.dart';
import 'package:quranku/features/kajian/presentation/components/label_tag.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/components/error_screen.dart';
import '../../../../core/components/spacer.dart';
import '../../../../core/utils/pair.dart';
import '../../../../core/utils/themes/color_schemes_material.dart';
import '../../domain/entities/kajian_schedule.codegen.dart';
import '../../domain/entities/week_kajian.codegen.dart';
import '../bloc/kajian/kajian_bloc.dart';
import '../components/mosque_image_container.dart';
import '../components/schedule_icon_text.dart';
import 'kajian_detail_screen.dart';

class KajianScreen extends StatelessWidget {
  const KajianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpacer(height: 10),
        BlocBuilder<KajianBloc, KajianState>(
          buildWhen: (previous, current) => previous.search != current.search,
          builder: (context, state) {
            return SearchBox(
              isDense: true,
              initialValue: state.search,
              hintText: LocaleKeys.searchKajianHint.tr(),
              onChanged: (value) {
                context.read<KajianBloc>().add(
                      KajianEvent.fetchKajian(
                        pageNumber: 1,
                        locale: context.locale,
                        search: value,
                      ),
                    );
              },
            );
          },
        ),
        const VSpacer(height: 10),
        const _FilterRowSection(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              context.read<KajianBloc>().add(
                    KajianEvent.fetchKajian(
                      locale: context.locale,
                      pageNumber: 1,
                    ),
                  );
              return Future.delayed(const Duration(milliseconds: 500));
            },
            child: BlocBuilder<KajianBloc, KajianState>(
              builder: (context, state) {
                final isLoading =
                    state.status == FormzSubmissionStatus.inProgress;
                if (state.status == FormzSubmissionStatus.failure) {
                  return ErrorScreen(
                    message: LocaleKeys.errorGetKajian.tr(),
                    onRefresh: () {
                      context.read<KajianBloc>().add(
                            KajianEvent.fetchKajian(
                              locale: context.locale,
                              pageNumber: 1,
                            ),
                          );
                    },
                  );
                }
                if (state.kajianResult.isEmpty && !isLoading) {
                  return ErrorScreen(
                    message: LocaleKeys.searchKajianEmpty.tr(),
                  );
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                            scrollNotification.metrics.maxScrollExtent &&
                        state.status != FormzSubmissionStatus.inProgress) {
                      context.read<KajianBloc>().add(
                            KajianEvent.fetchKajian(
                              locale: context.locale,
                              pageNumber: state.currentPage + 1,
                            ),
                          );
                    }
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: isLoading
                        ? state.kajianResult.length + 1
                        : state.kajianResult.length,
                    itemBuilder: (context, index) {
                      if (isLoading && index == state.kajianResult.length) {
                        return const Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                      return _KajianTile(
                        kajian: state.kajianResult.elementAt(index),
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

class _FilterRowSection extends StatelessWidget {
  const _FilterRowSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  BlocBuilder<KajianBloc, KajianState>(
                    buildWhen: (previous, current) =>
                        previous.isNearby != current.isNearby,
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: FilterChip(
                          label: Text(LocaleKeys.nearby.tr()),
                          selected: state.isNearby,
                          selectedColor:
                              context.theme.colorScheme.secondaryContainer,
                          showCheckmark: false,
                          onSelected: (bool value) {
                            context.read<KajianBloc>().add(
                                  const KajianEvent.toggleNearby(),
                                );
                            context.read<KajianBloc>().add(
                                  KajianEvent.fetchKajian(
                                    locale: context.locale,
                                    pageNumber: 1,
                                  ),
                                );
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<KajianBloc, KajianState>(
                    buildWhen: (previous, current) =>
                        previous.filter != current.filter,
                    builder: (context, state) {
                      return Row(
                        children: [
                          if (state.filter.studyLocationProvinceId != null) ...[
                            _filterChip(
                              context: context,
                              label:
                                  state.filter.studyLocationProvinceId!.first,
                              selected: true,
                              onSelected: () {
                                context.read<KajianBloc>().add(
                                      const KajianEvent.onChangeFilterProvince(
                                          null),
                                    );
                                context.read<KajianBloc>().add(
                                      KajianEvent.fetchKajian(
                                        locale: context.locale,
                                        pageNumber: 1,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.studyLocationCityId != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.studyLocationCityId!.first,
                              selected: true,
                              onSelected: () {
                                context.read<KajianBloc>().add(
                                      const KajianEvent.onChangeFilterCity(
                                          null),
                                    );
                                context.read<KajianBloc>().add(
                                      KajianEvent.fetchKajian(
                                        locale: context.locale,
                                        pageNumber: 1,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.locationId != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.locationId!.first,
                              selected: true,
                              onSelected: () {
                                context.read<KajianBloc>().add(
                                      const KajianEvent.onChangeFilterMosque(
                                        null,
                                      ),
                                    );
                                context.read<KajianBloc>().add(
                                      KajianEvent.fetchKajian(
                                        locale: context.locale,
                                        pageNumber: 1,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.dailySchedulesDayId != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.dailySchedulesDayId!.first,
                              selected: true,
                              onSelected: () {
                                context.read<KajianBloc>().add(
                                      const KajianEvent
                                          .onChangeDailySchedulesDayId(
                                        null,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.weeklySchedulesWeekId != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.weeklySchedulesWeekId!.first,
                              selected: true,
                              onSelected: () {
                                context.read<KajianBloc>().add(
                                      const KajianEvent
                                          .onChangeWeeklySchedulesWeekId(
                                        null,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.prayerSchedule != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.prayerSchedule!.first,
                              selected: true,
                              onSelected: () {
                                context.read<KajianBloc>().add(
                                      const KajianEvent.onChangePrayerSchedule(
                                        null,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.themesThemeId != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.themesThemeId!.first,
                              selected: true,
                              onSelected: () {
                                context.read<KajianBloc>().add(
                                      const KajianEvent.onChangeFilterTheme(
                                          null),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.ustadzUstadzId != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.ustadzUstadzId!.first,
                              selected: true,
                              onSelected: () {
                                context.read<KajianBloc>().add(
                                      const KajianEvent.onChangeFilterUstadz(
                                          null),
                                    );
                              },
                            ),
                          ],
                        ],
                      );
                    },
                  ),
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
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  enableDrag: true,
                  builder: (_) => BlocProvider.value(
                    value: context.read<KajianBloc>()
                      ..add(
                        const KajianEvent.fetchKajianThemes(),
                      )
                      ..add(
                        const KajianEvent.fetchProvinces(),
                      )
                      ..add(
                        const KajianEvent.fetchCities(),
                      )
                      ..add(
                        const KajianEvent.fetchMosques(),
                      )
                      ..add(
                        const KajianEvent.fetchUstadz(),
                      ),
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      minChildSize: 0.5,
                      maxChildSize: 0.9,
                      expand: false,
                      builder: (context, scrollController) {
                        return _KajianBottomSheetFilter(
                          scrollController: scrollController,
                        );
                      },
                    ),
                  ),
                ).whenComplete(() => context.read<KajianBloc>().add(
                      KajianEvent.fetchKajian(
                        locale: context.locale,
                        pageNumber: 1,
                      ),
                    ));
              },
              child: const Icon(
                Icons.settings_input_composite_outlined,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip({
    required BuildContext context,
    required String label,
    required bool selected,
    required void Function() onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FilterChip(
        label: Text(label),
        selected: true,
        showCheckmark: false,
        onSelected: (bool value) {
          onSelected();
          context.read<KajianBloc>().add(
                KajianEvent.fetchKajian(
                  locale: context.locale,
                  pageNumber: 1,
                ),
              );
        },
      ),
    );
  }
}

class _KajianTile extends StatelessWidget {
  final DataKajianSchedule kajian;

  const _KajianTile({
    required this.kajian,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = kajian.studyLocation.pictureUrl;
    final prayerName = kajian.prayerSchedule;
    final title = kajian.title;
    final ustadz =
        kajian.ustadz.isNotEmpty ? kajian.ustadz.first.name : emptyString;
    final time = '${kajian.timeStart} - ${kajian.timeEnd}';
    final place = kajian.studyLocation.name;
    final schedule = kajian.dailySchedules.isNotEmpty
        ? kajian.dailySchedules.first.dayLabel
        : emptyString;
    final Pair<Color, Color> prayerColor = () {
      switch (prayerName.toLowerCase()) {
        case 'subuh':
          return Pair(
            context.theme.colorScheme.tertiaryContainer,
            context.theme.colorScheme.onTertiaryContainer,
          );
        case 'dzuhur':
          return Pair(
            context.theme.colorScheme.tertiary,
            context.theme.colorScheme.onTertiary,
          );
        case 'ashar':
          return Pair(
            context.theme.colorScheme.error,
            context.theme.colorScheme.onError,
          );
        case 'maghrib':
          return Pair(
            context.theme.colorScheme.primaryContainer,
            context.theme.colorScheme.onPrimaryContainer,
          );
        case 'isya':
          return Pair(
            context.theme.colorScheme.secondaryContainer,
            context.theme.colorScheme.onSecondaryContainer,
          );
        default:
          return Pair(
            context.theme.colorScheme.tertiaryContainer,
            context.theme.colorScheme.onTertiaryContainer,
          );
      }
    }();
    return GestureDetector(
      onTap: () {
        context.navigateTo(KajianDetailScreen(
          kajian: kajian,
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? MaterialTheme.darkScheme().surfaceContainer
              : MaterialTheme.lightScheme().surfaceContainer,
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
                            title: prayerName.capitalize(),
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
                          Text(
                            ustadz,
                            style: context.textTheme.bodySmall,
                          ),
                          const VSpacer(height: 2),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ScheduleIconText(
                                  icon: Icons.date_range_outlined,
                                  text: schedule,
                                ),
                              ),
                              const HSpacer(width: 5),
                              Expanded(
                                flex: 2,
                                child: ScheduleIconText(
                                  icon: Icons.access_time,
                                  text: time,
                                ),
                              ),
                            ],
                          ),
                          const VSpacer(height: 2),
                          ScheduleIconText(
                            icon: Icons.place_outlined,
                            text: place,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.navigate_next,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KajianBottomSheetFilter extends StatelessWidget {
  final ScrollController scrollController;

  const _KajianBottomSheetFilter({
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _ProvinceFilterSection(),
                VSpacer(height: 10),
                _CityFilterSection(),
                VSpacer(height: 10),
                _MosqueFilterSection(),
                VSpacer(height: 10),
                _DayFilterSection(),
                VSpacer(height: 10),
                _WeekFilterSection(),
                VSpacer(height: 10),
                _PrayerFilterSection(),
                VSpacer(height: 10),
                _ThemeFilterSection(),
                VSpacer(height: 10),
                _UstadzFilterSection(),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: context.theme.colorScheme.onPrimary,
              foregroundColor: context.theme.colorScheme.primary,
            ),
            onPressed: () {
              context.read<KajianBloc>().add(
                    KajianEvent.fetchKajian(
                      locale: context.locale,
                      pageNumber: 1,
                    ),
                  );
              Navigator.pop(context);
            },
            child: Text(LocaleKeys.apply.tr()),
          ),
        ],
      ),
    );
  }
}

class _ProvinceFilterSection extends StatelessWidget {
  const _ProvinceFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KajianBloc, KajianState>(
      buildWhen: (previous, current) {
        return previous.provinces != current.provinces ||
            previous.filter.studyLocationProvinceId !=
                current.filter.studyLocationProvinceId ||
            previous.provincesStatus != current.provincesStatus;
      },
      builder: (context, state) {
        if (state.provincesStatus == FormzSubmissionStatus.inProgress) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        } else if (state.provincesStatus == FormzSubmissionStatus.failure) {
          return ErrorScreen(
            message: LocaleKeys.errorGetProvince.tr(),
            onRefresh: () {
              context.read<KajianBloc>().add(
                    const KajianEvent.fetchProvinces(),
                  );
            },
          );
        }
        return _ItemOnBottomSheet(
          title: LocaleKeys.province.tr(),
          selected: state.filter.studyLocationProvinceId,
          isMultipleSelect: false,
          items: state.provinces
              .map((e) => Pair(e.name, e.id.toString()))
              .toList(),
          onSelected: (value) {
            context.read<KajianBloc>().add(
                  KajianEvent.onChangeFilterProvince(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _CityFilterSection extends StatelessWidget {
  const _CityFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KajianBloc, KajianState>(
      buildWhen: (previous, current) {
        return previous.cities != current.cities ||
            previous.filter.studyLocationCityId !=
                current.filter.studyLocationCityId ||
            previous.citiesStatus != current.citiesStatus ||
            previous.filter.studyLocationProvinceId !=
                current.filter.studyLocationProvinceId;
      },
      builder: (context, state) {
        if (state.citiesStatus == FormzSubmissionStatus.inProgress) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        } else if (state.citiesStatus == FormzSubmissionStatus.failure) {
          return ErrorScreen(
            message: LocaleKeys.errorGetCity.tr(),
            onRefresh: () {
              context.read<KajianBloc>().add(
                    const KajianEvent.fetchCities(),
                  );
            },
          );
        }
        final selectedProvinceId = state.filter.studyLocationProvinceId;
        var items =
            state.cities.map((e) => Pair(e.name, e.id.toString())).toList();
        if (selectedProvinceId != null) {
          items = items
              .where((e) => e.second.startsWith(selectedProvinceId.second))
              .toList();
        }
        return _ItemOnBottomSheet(
          title: LocaleKeys.city.tr(),
          selected: state.filter.studyLocationCityId,
          isMultipleSelect: false,
          items: items,
          onSelected: (value) {
            context.read<KajianBloc>().add(
                  KajianEvent.onChangeFilterCity(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _MosqueFilterSection extends StatelessWidget {
  const _MosqueFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KajianBloc, KajianState>(
      buildWhen: (previous, current) {
        return previous.mosques != current.mosques ||
            previous.filter.locationId != current.filter.locationId ||
            previous.mosquesStatus != current.mosquesStatus ||
            previous.filter.studyLocationCityId !=
                current.filter.studyLocationCityId ||
            previous.filter.studyLocationProvinceId !=
                current.filter.studyLocationProvinceId;
      },
      builder: (context, state) {
        if (state.mosquesStatus == FormzSubmissionStatus.inProgress) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        } else if (state.mosquesStatus == FormzSubmissionStatus.failure) {
          return ErrorScreen(
            message: LocaleKeys.errorGetMosque.tr(),
            onRefresh: () {
              context.read<KajianBloc>().add(
                    const KajianEvent.fetchMosques(),
                  );
            },
          );
        }
        var items = state.mosques
            .map((e) => Pair(e.name.orEmpty(), e.id.toString()))
            .toList();
        final selectedProvinceId = state.filter.studyLocationProvinceId;
        if (selectedProvinceId != null) {
          items = state.mosques
              .where(
                  (e) => e.province?.id.toString() == selectedProvinceId.second)
              .map((e) => Pair(e.name.orEmpty(), e.id.toString()))
              .toList();
        }
        final selectedCityId = state.filter.studyLocationCityId;
        if (selectedCityId != null) {
          items = state.mosques
              .where((e) => e.city?.id.toString() == selectedCityId.second)
              .map((e) => Pair(e.name.orEmpty(), e.id.toString()))
              .toList();
        }
        return _ItemOnBottomSheet(
          title: LocaleKeys.mosque.tr(),
          isMultipleSelect: false,
          countShow: 3,
          selected: state.filter.locationId,
          items: items,
          onSelected: (value) {
            context.read<KajianBloc>().add(
                  KajianEvent.onChangeFilterMosque(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _DayFilterSection extends StatelessWidget {
  const _DayFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KajianBloc, KajianState>(
      buildWhen: (previous, current) {
        return previous.filter.dailySchedulesDayId !=
            current.filter.dailySchedulesDayId;
      },
      builder: (context, state) {
        return _ItemOnBottomSheet(
          title: LocaleKeys.day.tr(),
          isShowAllButton: false,
          selected: state.filter.dailySchedulesDayId,
          items: DayKajian.days.map((e) => Pair(e.name, e.id)).toList(),
          onSelected: (value) {
            context.read<KajianBloc>().add(
                  KajianEvent.onChangeDailySchedulesDayId(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _WeekFilterSection extends StatelessWidget {
  const _WeekFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KajianBloc, KajianState>(
      buildWhen: (previous, current) {
        return previous.filter.weeklySchedulesWeekId !=
            current.filter.weeklySchedulesWeekId;
      },
      builder: (context, state) {
        return _ItemOnBottomSheet(
          title: LocaleKeys.week.tr(),
          isShowAllButton: false,
          selected: state.filter.weeklySchedulesWeekId,
          items: WeekKajian.weeks.map((e) => Pair(e.name, e.id)).toList(),
          onSelected: (value) {
            context.read<KajianBloc>().add(
                  KajianEvent.onChangeWeeklySchedulesWeekId(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _PrayerFilterSection extends StatelessWidget {
  const _PrayerFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KajianBloc, KajianState>(
      buildWhen: (previous, current) {
        return previous.filter.prayerSchedule != current.filter.prayerSchedule;
      },
      builder: (context, state) {
        return _ItemOnBottomSheet(
          title: LocaleKeys.prayerSchedule.tr(),
          isShowAllButton: false,
          selected: state.filter.prayerSchedule,
          items: PrayerKajian.prayersByLocale(context.locale)
              .map((e) => Pair(e.name, e.id))
              .toList(),
          onSelected: (value) {
            context.read<KajianBloc>().add(
                  KajianEvent.onChangePrayerSchedule(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _ThemeFilterSection extends StatelessWidget {
  const _ThemeFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KajianBloc, KajianState>(
      buildWhen: (previous, current) {
        return previous.kajianThemes != current.kajianThemes ||
            previous.filter.themesThemeId != current.filter.themesThemeId ||
            previous.kajianThemesStatus != current.kajianThemesStatus;
      },
      builder: (context, state) {
        if (state.kajianThemesStatus == FormzSubmissionStatus.inProgress) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        } else if (state.kajianThemesStatus == FormzSubmissionStatus.failure) {
          return ErrorScreen(
            message: LocaleKeys.errorGetKajianTheme.tr(),
            onRefresh: () {
              context.read<KajianBloc>().add(
                    const KajianEvent.fetchKajianThemes(),
                  );
            },
          );
        }
        return _ItemOnBottomSheet(
          title: LocaleKeys.theme.tr(),
          selected: state.filter.themesThemeId,
          items:
              state.kajianThemes.map((e) => Pair(e.theme, e.themeId)).toList(),
          onSelected: (value) {
            context.read<KajianBloc>().add(
                  KajianEvent.onChangeFilterTheme(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _UstadzFilterSection extends StatelessWidget {
  const _UstadzFilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KajianBloc, KajianState>(
      buildWhen: (previous, current) {
        return previous.ustadz != current.ustadz ||
            previous.filter.ustadzUstadzId != current.filter.ustadzUstadzId ||
            previous.ustadzStatus != current.ustadzStatus;
      },
      builder: (context, state) {
        if (state.ustadzStatus == FormzSubmissionStatus.inProgress) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        } else if (state.ustadzStatus == FormzSubmissionStatus.failure) {
          return ErrorScreen(
            message: LocaleKeys.errorGetUstadz.tr(),
            onRefresh: () {
              context.read<KajianBloc>().add(
                    const KajianEvent.fetchUstadz(),
                  );
            },
          );
        }
        return _ItemOnBottomSheet(
          title: LocaleKeys.ustadz.tr(),
          countShow: 3,
          selected: state.filter.ustadzUstadzId,
          items:
              state.ustadz.map((e) => Pair(e.name, e.id.toString())).toList(),
          onSelected: (value) {
            context.read<KajianBloc>().add(
                  KajianEvent.onChangeFilterUstadz(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _ItemOnBottomSheet extends StatelessWidget {
  final String title;

  /// List of items with the
  /// First value as the display name
  /// Second value as ID
  final List<Pair<String, String>> items;
  final Pair<String, String>? selected;
  final Function(Pair<String, String>?) onSelected;
  final int? countShow;
  final bool isShowAllButton;
  final bool isMultipleSelect;

  const _ItemOnBottomSheet({
    required this.title,
    required this.items,
    required this.selected,
    required this.onSelected,
    this.countShow,
    this.isShowAllButton = true,
    this.isMultipleSelect = true,
  });

  @override
  Widget build(BuildContext context) {
    final showItems = items.take(countShow ?? 5).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isShowAllButton) ...[
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    enableDrag: true,
                    isScrollControlled: true,
                    builder: (_) => DraggableScrollableSheet(
                      initialChildSize: 0.7,
                      minChildSize: 0.7,
                      maxChildSize: 0.9,
                      expand: false,
                      builder: (context, scrollController) {
                        return _SearchItemBottomSheet(
                          title: title,
                          items: items,
                          selected: selected,
                          onSelected: onSelected,
                          scrollController: scrollController,
                          isMultipleSelect: isMultipleSelect,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  LocaleKeys.seeAll.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.primary,
                  ),
                ),
              ),
            ]
          ],
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: isShowAllButton
              ? showItems.map((e) => _buildItem(context, e)).toList()
              : items.map((e) => _buildItem(context, e)).toList(),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, Pair<String, String> item) {
    return FilterChip(
      label: Text(item.first),
      backgroundColor: context.theme.colorScheme.surfaceContainer,
      selectedColor: context.theme.colorScheme.primaryContainer,
      elevation: 0,
      side: BorderSide(
        color: context.theme.colorScheme.onSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      showCheckmark: false,
      selected: selected?.second.split('|').contains(item.second) ?? false,
      onSelected: (value) {
        onSelected(item);
      },
    );
  }
}

class _SearchItemBottomSheet extends StatefulWidget {
  final String title;
  final bool isMultipleSelect;

  /// List of items with the
  /// First value as the display NAME
  /// Second value as ID
  final List<Pair<String, String>> items;
  final Pair<String, String>? selected;
  final Function(Pair<String, String>?) onSelected;
  final ScrollController scrollController;

  const _SearchItemBottomSheet({
    required this.title,
    required this.items,
    required this.selected,
    required this.onSelected,
    required this.scrollController,
    this.isMultipleSelect = true,
  });

  @override
  State<_SearchItemBottomSheet> createState() => _SearchItemBottomSheetState();
}

class _SearchItemBottomSheetState extends State<_SearchItemBottomSheet> {
  late List<Pair<String, String>> _filteredItems;
  final _selectedItems = ValueNotifier(<Pair<String, String>>[]);

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    for (final item in widget.selected?.second.split('|') ?? []) {
      _selectedItems.value.add(
        Pair(
          widget.items.firstWhere((e) => e.second == item).first,
          item,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _filteredItems = widget.items;
                    _selectedItems.value.clear();
                  });
                  widget.onSelected(null);
                },
                child: Text(
                  LocaleKeys.reset.tr(),
                ),
              )
            ],
          ),
          SearchBox(
            isDense: true,
            initialValue: '',
            hintText: LocaleKeys.search.tr(),
            onChanged: (value) {
              setState(() {
                _filteredItems = widget.items
                    .where((element) => element.first
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            },
          ),
          const VSpacer(height: 10),
          ValueListenableBuilder(
              valueListenable: _selectedItems,
              builder: (context, value, child) {
                return Expanded(
                  child: ListView.separated(
                    controller: widget.scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ListTile(
                        title: Text(
                          item.first,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selected: _selectedItems.value
                            .where((e) => e.second == item.second)
                            .isNotEmpty,
                        selectedTileColor:
                            context.theme.colorScheme.primaryContainer,
                        onTap: () {
                          if (!widget.isMultipleSelect) {
                            widget.onSelected(item);
                            Navigator.pop(context);
                            return;
                          }
                          setState(() {
                            if (_selectedItems.value
                                .where((e) => e.second == item.second)
                                .isNotEmpty) {
                              _selectedItems.value.removeWhere(
                                (e) => e.second == item.second,
                              );
                            } else {
                              _selectedItems.value.add(item);
                            }
                          });
                          widget.onSelected(
                            _selectedItems.value.isEmpty
                                ? null
                                : Pair(
                                    _selectedItems.value
                                        .map((e) => e.first)
                                        .toSet()
                                        .join('|'),
                                    _selectedItems.value
                                        .map((e) => e.second)
                                        .toSet()
                                        .join('|'),
                                  ),
                          );
                          // setState(
                          //   () {
                          //     if (_selectedIdItems.contains(item.second)) {
                          //       _selectedIdItems.remove(item.second);
                          //       _selectedNameItems.remove(item.first);
                          //     } else {
                          //       _selectedIdItems.add(item.second);
                          //       _selectedNameItems.add(item.first);
                          //     }
                          //   },
                          // );
                          //
                          // print("selectedIdItems: $_selectedIdItems");
                          // print("selectedNameItems: $_selectedNameItems");
                          // widget.onSelected(
                          //   _selectedIdItems.isEmpty
                          //       ? null
                          //       : Pair(
                          //           _selectedNameItems.toSet().join('|'),
                          //           _selectedIdItems.toSet().join('|'),
                          //         ),
                          // );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
