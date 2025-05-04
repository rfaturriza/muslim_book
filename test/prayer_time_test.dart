import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test prayer time', () {
    final coordinate = Coordinates(
      -6.3173563,
      106.7447118,
      validate: true,
    );
    for (var element in CalculationMethod.values) {
      final params = element.getParameters();
      for (var madhab in Madhab.values) {
        params.madhab = madhab;
        params.adjustments = PrayerAdjustments(
          fajr: 0,
          dhuhr: 0,
          asr: 0,
          maghrib: 20,
          isha: 0,
        );
        final prayerTimes = PrayerTimes.today(coordinate, params);
        debugPrint('Calculation Method: ${element.name}');
        debugPrint('Madhab: ${params.madhab.name}');
        debugPrint('Fajr: ${prayerTimes.fajr}');
        debugPrint('Dhuhr: ${prayerTimes.dhuhr}');
        debugPrint('Asr: ${prayerTimes.asr}');
        debugPrint('Maghrib: ${prayerTimes.maghrib}');
        debugPrint('Isha: ${prayerTimes.isha}');
        debugPrint('Sunrise: ${prayerTimes.sunrise}');
        debugPrint('');
      }
    }
  });
}
