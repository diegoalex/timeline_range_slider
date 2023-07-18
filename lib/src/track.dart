import 'package:flutter/material.dart';
import 'package:timeline_range_slider/src/helpers.dart';

/// A range consisting of starting [TimeOfDay] and ending [TimeOfDay].
class Track implements Comparable<Track> {
  /// The initial/starting value of the [Track] range.
  final TimeOfDay start;

  /// The final/ending value of the [Track] range.
  final TimeOfDay end;

  /// If `true` then this [Track] range is available for booking.
  /// Defaults to `false`.
  final bool isAvailable;

  Track(
    this.start,
    this.end, {
    this.isAvailable = false,
  }) : assert(
          (start.totalRangeTime == 0 && start.totalRangeTime == 0) ||
              (start.totalRangeTime < end.totalRangeTime),
          'Starting time must not be later than the ending time!',
        );

  @override
  int compareTo(Track other) {
    final otherStart = other.start.totalRangeTime;
    if (start.totalRangeTime == otherStart) {
      return 0;
    } else if (start.totalRangeTime < otherStart) {
      return -1;
    } else {
      return 1;
    }
  }

  @override
  String toString() =>
      'BookingValues{start: $start, end: $end, isAvailable: $isAvailable}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Track &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
