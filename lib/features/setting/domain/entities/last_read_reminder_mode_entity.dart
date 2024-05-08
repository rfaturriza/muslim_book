import 'package:easy_localization/easy_localization.dart';
import 'package:quranku/generated/locale_keys.g.dart';

enum LastReadReminderModes {
  autoSave,
  on,
  off;

  String toTitle() {
    switch (this) {
      case LastReadReminderModes.autoSave:
        return LocaleKeys.lastReadingReminderMode_auto.tr();
      case LastReadReminderModes.off:
        return LocaleKeys.lastReadingReminderMode_off.tr();
      case LastReadReminderModes.on:
        return LocaleKeys.lastReadingReminderMode_warnMe.tr();
      default:
        return '';
    }
  }

  String toDescription() {
    switch (this) {
      case LastReadReminderModes.autoSave:
        return LocaleKeys.lastReadingReminderModeDescription_auto.tr();
      case LastReadReminderModes.off:
        return LocaleKeys.lastReadingReminderModeDescription_off.tr();
      case LastReadReminderModes.on:
        return LocaleKeys.lastReadingReminderModeDescription_warnMe.tr();
      default:
        return '';
    }
  }
}
