import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/kajian/presentation/screens/kajianhub_screen.dart';

import '../../../../core/components/spacer.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/utils/themes/color_schemes_material.dart';
import '../../../../generated/locale_keys.g.dart';

class KajianHubCard extends StatelessWidget {
  const KajianHubCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigateTo(const KajianHubScreen());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? MaterialTheme.darkScheme().surfaceContainer
              : MaterialTheme.lightScheme().surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: _KajianHubLogo(),
                    ),
                    HSpacer(width: 10),
                    Flexible(
                      flex: 5,
                      child: _RecitationInfo(
                        masjidName: 'Masjid Al-Ikhlas Panjang Sekaliiiiii',
                        ustadzName: 'Ustadz Abdul Somad Panjanggg',
                        time: '19.00 - 21.00',
                        prayerTime: 'Maghrib',
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: TagNavIcon(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KajianHubLogo extends StatelessWidget {
  const _KajianHubLogo();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.theme.brightness != Brightness.dark;
    return Image.asset(
      isDarkMode ? AssetConst.kajianHubLogoDark : AssetConst.kajianHubLogoLight,
      width: 70,
    );
  }
}

class _RecitationInfo extends StatelessWidget {
  final String masjidName;
  final String ustadzName;
  final String time;
  final String prayerTime;

  const _RecitationInfo({
    required this.masjidName,
    required this.ustadzName,
    required this.time,
    required this.prayerTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          masjidName,
          style: context.theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const VSpacer(height: 2),
        Text(
          ustadzName,
          style: context.theme.textTheme.titleSmall,
          overflow: TextOverflow.ellipsis,
        ),
        const VSpacer(height: 2),
        RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: time,
                style: context.theme.textTheme.titleSmall,
              ),
              TextSpan(
                text: ' | ',
                style: context.theme.textTheme.titleSmall,
              ),
              TextSpan(
                text: prayerTime,
                style: context.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TagNavIcon extends StatelessWidget {
  const TagNavIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: ShapeDecoration(
            color: context.theme.colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            LocaleKeys.nearby.tr(),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        Icon(
          Icons.navigate_next,
          color: context.theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ],
    );
  }
}
