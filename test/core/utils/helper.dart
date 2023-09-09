
import 'package:flutter_test/flutter_test.dart';
import 'package:quranku/core/utils/helper.dart';

void main() {
  group('getCityNameWithoutCountry', () {
    test('should return city name without country', () {
      // arrange
      const city = "Daerah Khusus Ibukota Jakarta";
      // act
      final result = getCityNameWithoutPrefix(city);
      // assert
      expect(result, "jakarta");
    });
    test('should return city name without country For Kota Tangerang Selatan', () {
      // arrange
      const city = "Kota Tangerang Selatan";
      // act
      final result = getCityNameWithoutPrefix(city);
      // assert
      expect(result, "tangerang selatan");
    });
  });
}