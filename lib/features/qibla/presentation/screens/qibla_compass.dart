import 'dart:math' show pi;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/constants/asset_constants.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/core/utils/extension/extension.dart';
import 'package:quranku/features/qibla/presentation/bloc/qibla_bloc.dart';
import 'package:quranku/features/quran/presentation/screens/components/app_bar_detail_screen.dart';

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
        extendBodyBehindAppBar: true,
        appBar: AppBarDetailScreen(title: LocaleKeys.qibla.tr()),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<QiblaBloc, QiblaState>(
              builder: (context, state) {
                final locationStatusResult = state.locationStatusResult;
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                }
                if (locationStatusResult?.isRight() == true) {
                  final locationStatus = locationStatusResult?.asRight();
                  if (locationStatus?.status.isGranted == true) {
                    return const QiblaCompassWidget();
                  } else {
                    return ErrorScreen(
                      message: LocaleKeys.errorLocationDenied.tr(),
                    );
                  }
                } else if (locationStatusResult?.isLeft() == true) {
                  return ErrorScreen(
                    message: LocaleKeys.errorLocationDisabled.tr(),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class QiblaCompassWidget extends StatefulWidget {
  const QiblaCompassWidget({super.key});

  @override
  State<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends State<QiblaCompassWidget> {
  void showCalibrationCompassDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              children: [
                Image.asset(AssetConst.compassCalibrationGif),
                const VSpacer(),
                Text(
                  LocaleKeys.calibrationCompass.tr(),
                  textAlign: TextAlign.center,
                ),
                const VSpacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCalibrationCompassDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QiblaBloc, QiblaState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }
        final direction = state.qiblaDirectionResult?.asRight();
        var angle = ((direction?.qiblah ?? 0) * (pi / 180) * -1) / (2 * pi);

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SvgPicture.asset(AssetConst.compassSvg),
            AnimatedRotation(
              turns: angle,
              duration: const Duration(milliseconds: 200),
              child: SvgPicture.asset(AssetConst.needleSvg),
            ),
            const VSpacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                LocaleKeys.instructionQibla.tr(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
