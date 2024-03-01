import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app.dart';
import 'core/constants/admob_constants.dart';
import 'core/utils/bloc_observe.dart';
import 'core/utils/firebase_cloud_message.dart';
import 'core/utils/local_notification.dart';
import 'firebase_options.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await configureDependencies();
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: kDebugMode ? AdMobConst.testDevice : [],
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeFCM();
  configureFCMListeners();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await sl<LocalNotification>().init();
  timeago.setLocaleMessages('id', timeago.IdMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('id'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const App(),
    ),
  );
}
