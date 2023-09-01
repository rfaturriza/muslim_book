import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';

import '../../../../core/constants/asset_constants.dart';
import '../bloc/shalat/shalat_bloc.dart';
import '../mapper/helper_time_shalat.dart';

class ShalatInfoCard extends StatelessWidget {
  const ShalatInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        bloc: context.read<ShalatBloc>(),
        builder: (context, state) {
          final shalatName = HelperTimeShalat.getShalatNameByTime(
            state.scheduleByDay?.schedule,
          );
          final shalatTime = HelperTimeShalat.getShalatTimeByShalatName(
            state.scheduleByDay?.schedule,
            shalatName,
          );

          final place = state.geoLocation?.region?.isEmpty == true
              ? state.geoLocation?.city
              : state.geoLocation?.region;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
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
                ),
                Text(
                  place ?? '-',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
