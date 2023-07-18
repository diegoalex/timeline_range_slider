import 'package:flutter/material.dart';

const minutesInHour = 60;

class Helpers {
  static TimeOfDay convertToTimeOfDay(double seconds) {
    final secs = seconds.round();

    final hrs = secs ~/ minutesInHour;
    final mins = secs % minutesInHour;
    return TimeOfDay(hour: hrs, minute: mins);
  }

  static String addLeadingZeroIfNeeded(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }
}

extension TimeOfDayExt on TimeOfDay {
  /// get total time in minutes
  int get totalRangeTime => (hour * minutesInHour) + minute;

  // Ported from org.threeten.bp;
  TimeOfDay plusMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int mofd = hour * 60 + minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ minutesInHour;
        int newMinute = newMofd % minutesInHour;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }
}
