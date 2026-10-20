import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/models/day_time_model.dart';

class DateTimeFormatHelpers{
  static String formatDateTime(DateTime dateTime){
    return DateFormat('MMM d, yyyy').format(dateTime.toLocal());
  }

  static String formatTime(TimeOfDay time){
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${time.period.name.toUpperCase()}';
  }

  static String formatGuestTime(DayTimeModel time){
    String startFormattedTime = formatTime(time.time!);
    String endFormattedTime = formatTime(time.endTime!);
    return '$startFormattedTime - $endFormattedTime';
  }

  static String timeOfDayToString(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String formattedTimeFromString(String timeString) {
    final parts = timeString.split(':');
    TimeOfDay time = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
    return formatTime(time);
  }

  static String getCommunityDateTime(DateTime eventDate, TimeOfDay eventTime) {
    DateFormat dateFormat = DateFormat("MMM dd");
    return '${dateFormat.format(eventDate.toLocal())}, ${formatTime(eventTime)}';
  }

  static bool isDateInRange(DateTime date, {DateTime? from, DateTime? to}) {
    final day = DateTime(date.year, date.month, date.day);
    if (from != null && day.isBefore(DateTime(from.year, from.month, from.day))) return false;
    if (to != null && day.isAfter(DateTime(to.year, to.month, to.day))) return false;
    return true;
  }
}
