import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quranku/core/components/error_screen.dart';
import 'package:quranku/core/components/search_box.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/extension.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/components/spacer.dart';
import '../../../../core/utils/pair.dart';
import '../../domain/entities/prayer_kajian.codegen.dart';
import '../bloc/prayerSchedule/prayer_schedule_bloc.dart';
import '../components/item_bottom_sheet.dart';
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
        BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
          buildWhen: (previous, current) {
            return previous.search != current.search;
          },
          builder: (context, state) {
            return SearchBox(
              isDense: true,
              initialValue: state.search ?? emptyString,
              hintText: LocaleKeys.searchRamadhanHint.tr(),
              onClear: () {
                context.read<PrayerScheduleBloc>().add(
                      PrayerScheduleEvent.fetchRamadhanSchedules(
                        locale: context.locale,
                        pageNumber: 1,
                        search: emptyString,
                      ),
                    );
              },
              onSubmitted: (value) {
                context.read<PrayerScheduleBloc>().add(
                      PrayerScheduleEvent.fetchRamadhanSchedules(
                        locale: context.locale,
                        pageNumber: 1,
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
          child: BlocConsumer<PrayerScheduleBloc, PrayerScheduleState>(
            listenWhen: (previous, current) {
              return previous.status != current.status &&
                  current.status.isFailure &&
                  current.ramadhanSchedules.isNotEmpty;
            },
            listener: (context, state) {
              if (state.status.isFailure &&
                  state.ramadhanSchedules.isNotEmpty) {
                context.showErrorToast(
                  LocaleKeys.errorGetRamadhanSchedule.tr(),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state.status.isInProgress;
              if (state.status.isFailure && state.ramadhanSchedules.isEmpty) {
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
              if (state.ramadhanSchedules.isEmpty && !isLoading) {
                return ErrorScreen(
                  message: LocaleKeys.searchRamadhanEmpty.tr(),
                );
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent &&
                      !isLoading &&
                      state.ramadhanSchedules.isNotEmpty) {
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
                    if (isLoading && index == state.ramadhanSchedules.length) {
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
                  BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
                    buildWhen: (previous, current) =>
                        previous.filter.isNearby != current.filter.isNearby,
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: _filterChip(
                          context: context,
                          label: LocaleKeys.nearby.tr(),
                          selected: state.filter.isNearby,
                          onSelected: () {
                            context.read<PrayerScheduleBloc>().add(
                                  const PrayerScheduleEvent.toggleNearby(),
                                );
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
                    buildWhen: (previous, current) =>
                        previous.filter != current.filter,
                    builder: (context, state) {
                      return Row(
                        children: [
                          if (state.filter.prayDate != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.prayDate
                                      ?.ddMMMMyyyy(context.locale) ??
                                  emptyString,
                              onSelected: () {
                                context.read<PrayerScheduleBloc>().add(
                                      const PrayerScheduleEvent
                                          .onChangeFilterPrayDate(
                                        null,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.studyLocationProvinceId != null) ...[
                            _filterChip(
                              context: context,
                              label:
                                  state.filter.studyLocationProvinceId!.first,
                              onSelected: () {
                                context.read<PrayerScheduleBloc>().add(
                                      const PrayerScheduleEvent
                                          .onChangeFilterProvince(
                                        null,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.studyLocationCityId != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.studyLocationCityId!.first,
                              onSelected: () {
                                context.read<PrayerScheduleBloc>().add(
                                      const PrayerScheduleEvent
                                          .onChangeFilterCity(
                                        null,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.locationId != null) ...[
                            _filterChip(
                              context: context,
                              label: state.filter.locationId!.first,
                              onSelected: () {
                                context.read<PrayerScheduleBloc>().add(
                                      const PrayerScheduleEvent
                                          .onChangeFilterMosque(
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
                              onSelected: () {
                                context.read<PrayerScheduleBloc>().add(
                                      const PrayerScheduleEvent
                                          .onChangeFilterSubtype(
                                        null,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.imam?.isNotEmpty == true) ...[
                            _filterChip(
                              context: context,
                              label:
                                  '${LocaleKeys.imam.tr()}: ${state.filter.imam}',
                              onSelected: () {
                                context.read<PrayerScheduleBloc>().add(
                                      const PrayerScheduleEvent
                                          .onChangeFilterImam(
                                        null,
                                      ),
                                    );
                              },
                            ),
                          ],
                          if (state.filter.khatib?.isNotEmpty == true) ...[
                            _filterChip(
                              context: context,
                              label:
                                  '${LocaleKeys.khatib.tr()}: ${state.filter.khatib}',
                              onSelected: () {
                                context.read<PrayerScheduleBloc>().add(
                                      const PrayerScheduleEvent
                                          .onChangeFilterKhatib(
                                        null,
                                      ),
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
                final filterBefore =
                    context.read<PrayerScheduleBloc>().state.filter;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  enableDrag: true,
                  builder: (_) => BlocProvider.value(
                    value: context.read<PrayerScheduleBloc>()
                      ..add(
                        const PrayerScheduleEvent.fetchProvinces(),
                      )
                      ..add(
                        const PrayerScheduleEvent.fetchCities(),
                      )
                      ..add(
                        const PrayerScheduleEvent.fetchMosques(),
                      ),
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.7,
                      minChildSize: 0.5,
                      maxChildSize: 0.9,
                      expand: false,
                      builder: (context, scrollController) {
                        return _PrayerScheduleBottomSheetFilter(
                          scrollController: scrollController,
                        );
                      },
                    ),
                  ),
                ).whenComplete(() {
                  final filterAfter =
                      context.read<PrayerScheduleBloc>().state.filter;
                  if (filterBefore != filterAfter) {
                    context.read<PrayerScheduleBloc>().add(
                          PrayerScheduleEvent.fetchRamadhanSchedules(
                            locale: context.locale,
                            pageNumber: 1,
                          ),
                        );
                  }
                });
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
    bool selected = true,
    required void Function() onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (bool value) {
          onSelected();
          context.read<PrayerScheduleBloc>().add(
                PrayerScheduleEvent.fetchRamadhanSchedules(
                  locale: context.locale,
                  pageNumber: 1,
                ),
              );
        },
      ),
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
    final scheduledDate = DateTime.parse(date).toEEEEddMMMMyyyy(context.locale);
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
                            text: '${LocaleKeys.imam.tr()}: ',
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
                            text: '${LocaleKeys.khatib.tr()}: ',
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
                          text: scheduledDate ?? emptyString,
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

class _PrayerScheduleBottomSheetFilter extends StatelessWidget {
  final ScrollController scrollController;

  const _PrayerScheduleBottomSheetFilter({
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return SafeArea(
      minimum: EdgeInsets.only(bottom: viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        LocaleKeys.filter.tr(),
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: context
                          .watch<PrayerScheduleBloc>()
                          .state
                          .filter
                          .isNotEmpty(),
                      child: TextButton(
                        onPressed: () {
                          context.read<PrayerScheduleBloc>().add(
                                const PrayerScheduleEvent.resetFilter(),
                              );
                          context.read<PrayerScheduleBloc>().add(
                                PrayerScheduleEvent.fetchRamadhanSchedules(
                                  locale: context.locale,
                                  pageNumber: 1,
                                ),
                              );
                          Navigator.pop(context);
                        },
                        child: Text(
                          LocaleKeys.reset.tr(),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const _PrayerDatePickerSection(),
                const VSpacer(height: 10),
                const _ProvinceFilterSection(),
                const VSpacer(height: 10),
                const _CityFilterSection(),
                const VSpacer(height: 10),
                const _MosqueFilterSection(),
                const VSpacer(height: 10),
                const _PrayerFilterSection(),
                const VSpacer(height: 10),
                const _SearchImamSection(),
                const VSpacer(height: 10),
                const _SearchKhatibSection(),
                const VSpacer(height: 10),
              ],
            ),
          ),
          Container(
            color: context.theme.colorScheme.surface,
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: context.theme.colorScheme.onPrimary,
                foregroundColor: context.theme.colorScheme.primary,
              ),
              onPressed: () {
                context.read<PrayerScheduleBloc>().add(
                      PrayerScheduleEvent.fetchRamadhanSchedules(
                        locale: context.locale,
                        pageNumber: 1,
                      ),
                    );
                Navigator.pop(context);
              },
              child: Text(LocaleKeys.apply.tr()),
            ),
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
    return BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
      buildWhen: (previous, current) {
        return previous.provinces != current.provinces ||
            previous.filter.studyLocationProvinceId !=
                current.filter.studyLocationProvinceId ||
            previous.provincesStatus != current.provincesStatus;
      },
      builder: (context, state) {
        if (state.provincesStatus.isFailure) {
          return ErrorScreen(
            message: LocaleKeys.errorGetProvince.tr(),
            onRefresh: () {
              context.read<PrayerScheduleBloc>().add(
                    const PrayerScheduleEvent.fetchProvinces(),
                  );
            },
          );
        }
        return ItemOnBottomSheet(
          title: LocaleKeys.province.tr(),
          selected: state.filter.studyLocationProvinceId,
          isMultipleSelect: false,
          isLoading: state.provincesStatus.isInProgress,
          items: state.provinces
              .map((e) => Pair(e.name, e.id.toString()))
              .toList(),
          onSelected: (value) {
            context.read<PrayerScheduleBloc>().add(
                  PrayerScheduleEvent.onChangeFilterProvince(
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
    return BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
      buildWhen: (previous, current) {
        return previous.cities != current.cities ||
            previous.filter.studyLocationCityId !=
                current.filter.studyLocationCityId ||
            previous.citiesStatus != current.citiesStatus ||
            previous.filter.studyLocationProvinceId !=
                current.filter.studyLocationProvinceId;
      },
      builder: (context, state) {
        if (state.citiesStatus.isFailure) {
          return ErrorScreen(
            message: LocaleKeys.errorGetCity.tr(),
            onRefresh: () {
              context.read<PrayerScheduleBloc>().add(
                    const PrayerScheduleEvent.fetchCities(),
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
        return ItemOnBottomSheet(
          title: LocaleKeys.city.tr(),
          selected: state.filter.studyLocationCityId,
          isMultipleSelect: false,
          isLoading: state.citiesStatus.isInProgress,
          items: items,
          onSelected: (value) {
            context.read<PrayerScheduleBloc>().add(
                  PrayerScheduleEvent.onChangeFilterCity(
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
    return BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
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
        if (state.mosquesStatus == FormzSubmissionStatus.failure) {
          return ErrorScreen(
            message: LocaleKeys.errorGetMosque.tr(),
            onRefresh: () {
              context.read<PrayerScheduleBloc>().add(
                    const PrayerScheduleEvent.fetchMosques(),
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
        return ItemOnBottomSheet(
          title: LocaleKeys.mosque.tr(),
          isMultipleSelect: false,
          countShow: 3,
          selected: state.filter.locationId,
          isLoading: state.mosquesStatus.isInProgress,
          items: items,
          onSelected: (value) {
            context.read<PrayerScheduleBloc>().add(
                  PrayerScheduleEvent.onChangeFilterMosque(
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
    return BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
      buildWhen: (previous, current) {
        return previous.filter.prayerSchedule != current.filter.prayerSchedule;
      },
      builder: (context, state) {
        return ItemOnBottomSheet(
          title: LocaleKeys.prayerSchedule.tr(),
          isShowAllButton: false,
          selected: state.filter.prayerSchedule,
          items: PrayerKajian.prayersRamadhan()
              .map((e) => Pair(e.name, e.id))
              .toList(),
          onSelected: (value) {
            context.read<PrayerScheduleBloc>().add(
                  PrayerScheduleEvent.onChangeFilterSubtype(
                    value,
                  ),
                );
          },
        );
      },
    );
  }
}

class _PrayerDatePickerSection extends StatelessWidget {
  const _PrayerDatePickerSection();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PrayerScheduleBloc>();
    return BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
      buildWhen: (previous, current) {
        return previous.filter.prayDate != current.filter.prayDate;
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                LocaleKeys.prayDateSchedule.tr(),
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const VSpacer(height: 8),
            GestureDetector(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: state.filter.prayDate ?? DateTime.now(),
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 365 * 5)),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                );
                if (selectedDate != null) {
                  bloc.add(
                    PrayerScheduleEvent.onChangeFilterPrayDate(
                      selectedDate,
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: context.theme.colorScheme.onSurface,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      color: context.theme.colorScheme.onSurface,
                    ),
                    const HSpacer(width: 5),
                    Expanded(
                      child: Text(
                        state.filter.prayDate?.ddMMMMyyyy(context.locale) ??
                            LocaleKeys.selectDate.tr(),
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    state.filter.prayDate != null
                        ? InkWell(
                            onTap: () {
                              context.read<PrayerScheduleBloc>().add(
                                    const PrayerScheduleEvent
                                        .onChangeFilterPrayDate(
                                      null,
                                    ),
                                  );
                            },
                            child: const Icon(Icons.close),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SearchImamSection extends StatelessWidget {
  const _SearchImamSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
      buildWhen: (previous, current) {
        return previous.filter.imam != current.filter.imam;
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                LocaleKeys.imam.tr(),
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const VSpacer(height: 8),
            SearchBox(
              isDense: true,
              borderRadius: BorderRadius.circular(4),
              padding: EdgeInsets.zero,
              border: Border.all(
                color: context.theme.colorScheme.onSurface,
                width: 0.5,
              ),
              initialValue: state.filter.imam ?? '',
              hintText: LocaleKeys.searchImamHint.tr(),
              onClear: () {
                context.read<PrayerScheduleBloc>().add(
                      const PrayerScheduleEvent.onChangeFilterImam(
                        null,
                      ),
                    );
              },
              onChanged: (value) {
                context.read<PrayerScheduleBloc>().add(
                      PrayerScheduleEvent.onChangeFilterImam(
                        value,
                      ),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}

class _SearchKhatibSection extends StatelessWidget {
  const _SearchKhatibSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerScheduleBloc, PrayerScheduleState>(
      buildWhen: (previous, current) {
        return previous.filter.khatib != current.filter.khatib;
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.khatib.tr(),
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const VSpacer(height: 5),
            SearchBox(
              isDense: true,
              borderRadius: BorderRadius.circular(4),
              padding: EdgeInsets.zero,
              border: Border.all(
                color: context.theme.colorScheme.onSurface,
                width: 0.5,
              ),
              initialValue: state.filter.khatib ?? '',
              hintText: LocaleKeys.searchKhatibHint.tr(),
              onClear: () {
                context.read<PrayerScheduleBloc>().add(
                      const PrayerScheduleEvent.onChangeFilterKhatib(
                        null,
                      ),
                    );
              },
              onChanged: (value) {
                context.read<PrayerScheduleBloc>().add(
                      PrayerScheduleEvent.onChangeFilterKhatib(
                        value,
                      ),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
