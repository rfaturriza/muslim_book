import 'package:easy_localization/easy_localization.dart';

import '../../domain/entities/schedule.codegen.dart';

class HelperTimeShalat {
  static List<String> shalatNameList = [
    'imsak',
    'subuh',
    'terbit',
    'dhuha',
    'dzuhur',
    'ashar',
    'maghrib',
    'isya'
  ];

  static String getShalatNameByTime(Schedule? schedule) {
    if (schedule == null) return '-';
    final String? timeImsak = schedule.imsak;
    final String? timeSubuh = schedule.subuh;
    final String? timeTerbit = schedule.syuruq;
    final String? timeDhuha = schedule.dhuha;
    final String? timeDzuhur = schedule.dzuhur;
    final String? timeAshar = schedule.ashar;
    final String? timeMaghrib = schedule.maghrib;
    final String? timeIsya = schedule.isya;

    final dateTimeNow = DateTime.now();
    DateTime parseTime(String? time) {
      if (time == null) {
        throw ArgumentError("Time cannot be null");
      }
      final hourAndMinute = (time.contains(' ')) ? time.split(' ')[0] : time;
      final splitTime = hourAndMinute.split(RegExp(r'[.:]'));
      final hour = int.parse(splitTime[0]);
      final minute = int.parse(splitTime[1]);
      final dateTimeNow = DateTime.now();
      final format = DateFormat('yyyy-MM-dd HH:mm');

      return format.parse(
        '${dateTimeNow.year}-${dateTimeNow.month.toString().padLeft(2, '0')}-${dateTimeNow.day.toString().padLeft(2, '0')} $hour:$minute',
      );
    }

    if (timeImsak != null && dateTimeNow.isBefore(parseTime(timeImsak))) {
      return shalatNameList[0];
    } else if (timeSubuh != null &&
        dateTimeNow.isBefore(parseTime(timeSubuh))) {
      return shalatNameList[1];
    } else if (timeTerbit != null &&
        dateTimeNow.isBefore(parseTime(timeTerbit))) {
      return shalatNameList[2];
    } else if (timeDhuha != null &&
        dateTimeNow.isBefore(parseTime(timeDhuha))) {
      return shalatNameList[3];
    } else if (timeDzuhur != null &&
        dateTimeNow.isBefore(parseTime(timeDzuhur))) {
      return shalatNameList[4];
    } else if (timeAshar != null &&
        dateTimeNow.isBefore(parseTime(timeAshar))) {
      return shalatNameList[5];
    } else if (timeMaghrib != null &&
        dateTimeNow.isBefore(parseTime(timeMaghrib))) {
      return shalatNameList[6];
    } else if (timeIsya != null && dateTimeNow.isBefore(parseTime(timeIsya))) {
      return shalatNameList[7];
    } else {
      return shalatNameList[0];
    }
  }

  static String? getShalatTimeByShalatName(Schedule? schedule, String shalatName) {
    if (schedule == null) return '-';
    switch (shalatName) {
      case 'imsak':
        return schedule.imsak;
      case 'subuh':
        return schedule.subuh;
      case 'terbit':
        return schedule.syuruq;
      case 'dhuha':
        return schedule.dhuha;
      case 'dzuhur':
        return schedule.dzuhur;
      case 'ashar':
        return schedule.ashar;
      case 'maghrib':
        return schedule.maghrib;
      case 'isya':
        return schedule.isya;
      default:
        return '-';
    }
  }
}
