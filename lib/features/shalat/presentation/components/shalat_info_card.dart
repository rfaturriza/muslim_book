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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: const CachedNetworkImageProvider(
              AssetConst.backgroundShalatTimeCardNetwork,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: BlocBuilder<ShalatBloc, ShalatState>(
          builder: (context, state) {
            final shalatName = HelperTimeShalat.getShalatNameByTime(
              state.scheduleByDay?.getOrElse(() => null)?.schedule,
            );
            final shalatTime = HelperTimeShalat.getShalatTimeByShalatName(
              state.scheduleByDay?.getOrElse(() => null)?.schedule,
              shalatName,
            );

            final place = state.geoLocation?.regions?.isEmpty == true
                ? state.geoLocation?.cities?.first
                : state.geoLocation?.regions?.first;
            if (state.isLoading) {
              return const Center(child: LinearProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      if (state.scheduleByDay?.isRight() == true) ...[
                        Text(
                          shalatName.capitalize(),
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          shalatTime ?? '-',
                          style: context.textTheme.titleMedium,
                        ),
                      ],
                      if (state.scheduleByDay?.isLeft() == true) ...[
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              context.read<ShalatBloc>().add(
                                    const GetShalatScheduleByDayEvent(),
                                  );
                            },
                            icon: const Icon(Icons.refresh),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (state.scheduleByDay?.isLeft() == true) ...[
                    Text(
                      state.scheduleByDay?.asLeft().message ?? emptyString,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  if (state.scheduleByDay?.isRight() == true) ...[
                    Text(
                      place ?? '-',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
