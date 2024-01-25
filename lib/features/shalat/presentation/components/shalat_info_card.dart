import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quranku/core/components/dialog.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/core/utils/extension/extension.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/setting/presentation/bloc/setting/language_setting_bloc.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/constants/asset_constants.dart';
import '../bloc/shalat/shalat_bloc.dart';
import '../helper/helper_time_shalat.dart';

class ShalatInfoCard extends StatelessWidget {
  const ShalatInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final shalatBloc = context.read<ShalatBloc>();
    return BlocListener<ShalatBloc, ShalatState>(
      listener: (context, state) {
        if (state.locationStatus?.status.isNotGranted == true) {
          AppDialog.showPermissionDialog(
            context,
            content: LocaleKeys.permissionMessageLocation.tr(),
            onOk: () async {
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
          );
        }
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: CachedNetworkImageProvider(
                  AssetConst.backgroundShalatTimeCardNetwork,
                ),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.85),
                  Colors.black.withOpacity(0.2),
                ], // Customize your gradient colors
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: BlocBuilder<LanguageSettingBloc, LanguageSettingState>(
              buildWhen: (p, c) => p.languagePrayerTime != c.languagePrayerTime,
              builder: (context, languageSettingState) {
                return BlocBuilder<ShalatBloc, ShalatState>(
                  builder: (context, state) {
                    final shalat = () {
                      if (state.scheduleByDay?.isRight() == true) {
                        return HelperTimeShalat.getShalatNameByTime(
                          state.scheduleByDay?.asRight()?.schedule,
                          languageSettingState.languagePrayerTime,
                        );
                      }
                      return emptyString;
                    }();

                    final shalatTime = () {
                      if (state.scheduleByDay?.isRight() == true) {
                        return HelperTimeShalat.getShalatTimeByShalatName(
                          state.scheduleByDay?.asRight()?.schedule,
                          shalat,
                          languageSettingState.languagePrayerTime,
                        );
                      }
                      return emptyString;
                    }();

                    final place = state.geoLocation?.place ?? '-';
                    if (state.isLoading) {
                      return const Center(child: LinearProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 17.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (state.scheduleByDay?.isRight() == true) ...[
                                  Text(
                                    shalat.capitalize(),
                                    style:
                                        context.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    shalatTime ?? '-',
                                    style: context.textTheme.titleSmall,
                                  ),
                                ],
                                if (state.scheduleByDay?.isLeft() == true) ...[
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        context.read<ShalatBloc>().add(
                                              const ShalatEvent
                                                  .getShalatScheduleByDayEvent(),
                                            );
                                      },
                                      icon: const Icon(Icons.refresh),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (state.scheduleByDay?.isLeft() == true) ...[
                                  Text(
                                    state.scheduleByDay?.asLeft().message ??
                                        emptyString,
                                    style:
                                        context.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                                if (state.scheduleByDay?.isRight() == true) ...[
                                  Text(
                                    place,
                                    style: context.textTheme.titleSmall,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.clip,
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
