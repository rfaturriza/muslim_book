import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quranku/core/constants/url_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/setting/presentation/screens/styling_setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/components/button_drawer.dart';
import '../../../../core/components/spacer.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../payment/presentation/screens/donation_screen.dart';
import '../../../setting/presentation/screens/language_setting_screen.dart';

class DrawerQuranScreen extends StatelessWidget {
  const DrawerQuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: const [
                  _Header(),
                  _ListItemMenu(),
                ],
              ),
            ),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AppInfo(),
        VSpacer(),
      ],
    );
  }
}

class _ListItemMenu extends StatelessWidget {
  const _ListItemMenu();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            LocaleKeys.setting.tr(),
            style: context.textTheme.titleSmall?.copyWith(
              color: secondaryColor.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ButtonDrawer(
          icon: Icons.language,
          title: LocaleKeys.language.tr(),
          onTap: () {
            context.navigateTo(const LanguageSettingScreen());
          },
          withDecoration: false,
        ),
        ButtonDrawer(
          icon: Icons.format_size,
          title: LocaleKeys.stylingView.tr(),
          onTap: () {
            context.navigateTo(const StylingSettingScreen());
          },
          withDecoration: false,
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonDrawer(
          onTap: () async {
            final inAppReview = InAppReview.instance;

            if (await inAppReview.isAvailable()) {
              inAppReview.requestReview();
            }
          },
          icon: Icons.rate_review_rounded,
          title: LocaleKeys.rateUs.tr(),
        ),
        const VSpacer(),
        ButtonDrawer(
          onTap: () {
            context.navigateTo(const DonationPaymentScreen());
          },
          icon: Icons.volunteer_activism,
          title: LocaleKeys.supportUs.tr(),
        ),
        const VSpacer(),
        ButtonDrawer(
          onTap: () async {
            try {
              await launchUrl(
                Uri.parse(UrlConst.urlGithub),
                mode: LaunchMode.externalApplication,
              );
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          icon: Icons.sentiment_satisfied_alt_rounded,
          title: LocaleKeys.muslimBookIsOpenSource.tr(
            args: [LocaleKeys.appName.tr()],
          ),
          subtitle: UrlConst.urlGithub,
        ),
        const VSpacer(),
      ],
    );
  }
}

class _AppInfo extends StatefulWidget {
  const _AppInfo();

  @override
  State<_AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<_AppInfo> {
  PackageInfo _packageInfo = PackageInfo(
    appName: '-',
    packageName: '-',
    version: '-',
    buildNumber: '-',
    buildSignature: '-',
    installerStore: '-',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _packageInfo.appName,
            style: context.textTheme.titleMedium?.copyWith(
              color: defaultColor.shade50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            LocaleKeys.version.tr(args: [_packageInfo.version]),
            style: context.textTheme.bodySmall?.apply(
              color: defaultColor.shade50,
            ),
          ),
        ],
      ),
    );
  }
}
