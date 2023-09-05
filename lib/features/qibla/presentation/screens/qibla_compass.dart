import 'dart:math' show pi;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quranku/core/constants/asset_constants.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/features/qibla/presentation/bloc/qibla_bloc.dart';

import '../../../../core/components/error_screen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../injection.dart';

class QiblaCompassScreen extends StatelessWidget {
  const QiblaCompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QiblaBloc>(),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<QiblaBloc, QiblaState>(
            builder: (context, state) {
              final locationStatus = state.locationStatusResult?.asRight();
              if (state.isLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              if (locationStatus?.enabled == true) {
                switch (locationStatus?.status) {
                  case LocationPermission.always:
                  case LocationPermission.whileInUse:
                    return const QiblaCompassWidget();

                  case LocationPermission.denied:
                    return ErrorScreen(
                      message: LocaleKeys.errorLocationDenied.tr(),
                    );
                  case LocationPermission.deniedForever:
                    return ErrorScreen(
                      message: LocaleKeys.errorLocationPermanentDenied.tr(),
                    );
                  default:
                    return Container();
                }
              } else {
                return ErrorScreen(
                  message: LocaleKeys.errorLocationDisabled.tr(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class QiblaCompassWidget extends StatelessWidget {
  const QiblaCompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var platformBrightness = Theme.of(context).brightness;
    return BlocBuilder<QiblaBloc, QiblaState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator.adaptive();
        }
        final qiblaDirection = state.qiblaDirectionResult?.asRight();
        var angle =
            ((qiblaDirection?.qiblah ?? 0) * (pi / 180) * -1) / (2 * pi);

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedRotation(
              turns: angle,
              duration: const Duration(milliseconds: 400),
              child: SvgPicture.asset(
                AssetConst.compassSvg,
                colorFilter: ColorFilter.mode(
                  platformBrightness == Brightness.dark
                      ? Colors.yellow
                      : Colors.orange,
                  BlendMode.srcIn,
                )
              ),
            ),
            SvgPicture.asset(AssetConst.kaabaSvg),
            SvgPicture.asset(
              AssetConst.needleSvg,
              colorFilter: ColorFilter.mode(
                platformBrightness == Brightness.dark
                    ? Colors.yellow
                    : Colors.orange,
                BlendMode.srcIn,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                LocaleKeys.instructionQibla.tr(),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    );
  }
}
