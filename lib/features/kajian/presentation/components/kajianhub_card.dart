import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/extension.dart';
import 'package:quranku/features/kajian/presentation/bloc/kajian/kajian_bloc.dart';
import 'package:quranku/features/kajian/presentation/screens/kajianhub_screen.dart';

import '../../../../core/components/spacer.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/utils/pair.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../injection.dart';
import '../../../shalat/presentation/bloc/shalat/shalat_bloc.dart';
import 'label_tag.dart';
import 'mosque_image_container.dart';

class KajianHubCard extends StatelessWidget {
  final bool isNotAvailable;

  const KajianHubCard({
    super.key,
    this.isNotAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShalatBloc, ShalatState>(
      buildWhen: (previous, current) {
        return previous.locationStatus != current.locationStatus ||
            previous.geoLocation != current.geoLocation;
      },
      builder: (context, state) {
        final isLocationNotGranted =
            state.locationStatus?.status.isNotGranted == true;
        final isNotIndonesia =
            state.geoLocation?.country?.toLowerCase() != 'indonesia';
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.islamicStudiesInformationLabel.tr(),
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VSpacer(height: 10),
              InkWell(
                onTap: isLocationNotGranted || isNotIndonesia
                    ? null
                    : () {
                        context.navigateTo(const KajianHubScreen());
                      },
                child: Container(
                  decoration: ShapeDecoration(
                    color: context.theme.colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (isNotAvailable) ...[
                              Flexible(
                                flex: 7,
                                child: Center(
                                  child: Text(
                                    LocaleKeys.notAvailableInYourCountry.tr(),
                                    style: context.theme.textTheme.titleSmall,
                                  ),
                                ),
                              )
                            ],
                            if (!isNotAvailable) ...[
                              Flexible(
                                flex: 7,
                                child: BlocProvider<KajianBloc>(
                                  create: (context) => sl<KajianBloc>(),
                                  child: const _RecitationInfo(),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      const Flexible(
                        flex: 1,
                        child: TagNavIcon(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RecitationInfo extends StatelessWidget {
  const _RecitationInfo();

  @override
  Widget build(BuildContext context) {
    final shalatBloc = context.read<ShalatBloc>();
    return BlocListener<ShalatBloc, ShalatState>(
      listener: (context, state) {
        if (state.locationStatus?.status.isGranted == true) {
          context.read<KajianBloc>().add(
                KajianEvent.fetchNearbyKajian(
                  locale: context.locale,
                ),
              );
        }
      },
      child: BlocBuilder<ShalatBloc, ShalatState>(
        buildWhen: (p, c) => p.locationStatus != c.locationStatus,
        builder: (context, shalatState) {
          return BlocBuilder<KajianBloc, KajianState>(
            buildWhen: (previous, current) =>
                previous.statusRecommended != current.statusRecommended ||
                previous.recommendedKajian != current.recommendedKajian,
            builder: (context, state) {
              if (state.statusRecommended.isInProgress) {
                return const Center(child: LinearProgressIndicator());
              }
              if (shalatState.locationStatus?.status.isNotGranted == true) {
                return Center(
                  child: GestureDetector(
                    onTap: () async {
                      final p = await Geolocator.requestPermission();
                      shalatBloc.add(
                        ShalatEvent.onChangedLocationStatusEvent(
                          status: LocationStatus(
                            true,
                            p,
                          ),
                        ),
                      );
                    },
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: LocaleKeys.requestAccessLocation.tr(),
                            style: context.theme.textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: '\n',
                            style: context.theme.textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: LocaleKeys.tryAgain.tr(),
                            style: context.theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (state.statusRecommended.isFailure) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      context.read<KajianBloc>().add(
                            KajianEvent.fetchNearbyKajian(
                              locale: context.locale,
                            ),
                          );
                    },
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: LocaleKeys.errorGetKajian.tr(),
                            style: context.theme.textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: '\n',
                            style: context.theme.textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: LocaleKeys.tryAgain.tr(),
                            style: context.theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (state.statusRecommended.isSuccess &&
                  state.recommendedKajian == null) {
                return Center(
                  child: Text(
                    LocaleKeys.nearbyKajianEmptyToday.tr(),
                  ),
                );
              }
              final imageUrl =
                  state.recommendedKajian?.studyLocation.pictureUrl ??
                      AssetConst.mosqueDummyImageUrl;
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: MosqueImageContainer(
                      imageUrl: imageUrl,
                      height: 100,
                      width: double.infinity,
                    ),
                  ),
                  const HSpacer(width: 10),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              LabelTag(
                                title: LocaleKeys
                                    .islamicStudiesNearbyInformationLabel
                                    .tr(),
                                backgroundColor:
                                    context.theme.colorScheme.primary,
                                foregroundColor:
                                    context.theme.colorScheme.onPrimary,
                              ),
                              ...?state.recommendedKajian?.themes.map((e) {
                                final randomColors = [
                                  Pair(
                                    context.theme.colorScheme.secondary,
                                    context.theme.colorScheme.onSecondary,
                                  ),
                                  Pair(
                                    context.theme.colorScheme.tertiary,
                                    context.theme.colorScheme.onTertiary,
                                  ),
                                  Pair(
                                    context.theme.colorScheme.surface,
                                    context.theme.colorScheme.onSurface,
                                  ),
                                  Pair(
                                    context.theme.colorScheme.primaryContainer,
                                    context
                                        .theme.colorScheme.onPrimaryContainer,
                                  ),
                                  Pair(
                                    context
                                        .theme.colorScheme.secondaryContainer,
                                    context
                                        .theme.colorScheme.onSecondaryContainer,
                                  ),
                                  Pair(
                                    context.theme.colorScheme.tertiaryContainer,
                                    context
                                        .theme.colorScheme.onTertiaryContainer,
                                  ),
                                ];
                                randomColors.shuffle();
                                return LabelTag(
                                  title: e.theme,
                                  backgroundColor: randomColors.first.first,
                                  foregroundColor: randomColors.first.second,
                                );
                              }),
                            ],
                          ),
                        ),
                        const VSpacer(height: 2),
                        Text(
                          (state.recommendedKajian?.studyLocation.name ?? ''),
                          style: context.theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const VSpacer(height: 2),
                        Text(
                          state.recommendedKajian?.ustadz.isNotEmpty ?? false
                              ? state.recommendedKajian?.ustadz.first.name ?? ''
                              : '',
                          style: context.theme.textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const VSpacer(height: 2),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${state.recommendedKajian?.timeStart ?? ''} - ${state.recommendedKajian?.timeEnd ?? ''}',
                                style: context.theme.textTheme.titleSmall,
                              ),
                              TextSpan(
                                text: ' | ',
                                style: context.theme.textTheme.titleSmall,
                              ),
                              TextSpan(
                                text: state.recommendedKajian?.prayerSchedule ??
                                    '',
                                style: context.theme.textTheme.titleSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class TagNavIcon extends StatelessWidget {
  const TagNavIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.navigate_next,
      color: context.theme.colorScheme.onSurfaceVariant,
      size: 20,
    );
  }
}
