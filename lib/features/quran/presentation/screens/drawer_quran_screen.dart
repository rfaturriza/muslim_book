import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/components/button_drawer.dart';
import '../../../../core/components/spacer.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../payment/presentation/screens/donation_screen.dart';

class DrawerQuranScreen extends StatefulWidget {
  const DrawerQuranScreen({super.key});

  @override
  State<DrawerQuranScreen> createState() => DrawerQuranScreenState();
}

class DrawerQuranScreenState extends State<DrawerQuranScreen> {
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
    return Drawer(
      backgroundColor: context.theme.colorScheme.background,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.appName.tr(),
                          style: context.textTheme.titleLarge?.apply(
                            color: defaultColor.shade50,
                          ),
                        ),
                        Text(
                          LocaleKeys.version.tr(args: [_packageInfo.version]),
                          style: context.textTheme.bodyMedium?.apply(
                            color: defaultColor.shade50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                final Uri url =
                    Uri.parse('https://github.com/rfaturriza/muslim_book');
                try {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              icon: Icons.sentiment_satisfied_alt_rounded,
              title: LocaleKeys.muslimBookIsOpenSource.tr(),
              subtitle: "https://github.com/rfaturriza/muslim_book",
            ),
            const VSpacer(),
          ],
        ),
      ),
    );
  }
}
