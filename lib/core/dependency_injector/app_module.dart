import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/network/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  @injectable
  Dio get dioConfig => NetworkConfig.getDio();

  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
