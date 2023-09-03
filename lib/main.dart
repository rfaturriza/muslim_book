import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/utils/bloc_observe.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await configureDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('id'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('id'),
      saveLocale: true,
      child: const App(),
    ),
  );
}
