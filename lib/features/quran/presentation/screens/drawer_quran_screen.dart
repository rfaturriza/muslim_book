import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quranku/core/constants/url_constants.dart';
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
                          _packageInfo.appName,
                          style: context.textTheme.titleLarge?.copyWith(
                            color: defaultColor.shade50,
                            fontWeight: FontWeight.bold,
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
                args: [_packageInfo.appName],
              ),
              subtitle: UrlConst.urlGithub,
            ),
            const VSpacer(),
          ],
        ),
      ),
    );
  }
}
