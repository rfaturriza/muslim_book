
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
  });
}