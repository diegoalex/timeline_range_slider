library timeline_range_slider;

import 'package:flutter/material.dart';
import 'package:timeline_range_slider/src/slider.dart';
import 'package:timeline_range_slider/src/track.dart';
export 'package:timeline_range_slider/src/track.dart';

const _defaultColorUnavailable = Color.fromARGB(255, 233, 231, 231);
const _defaultColorTrack = Color.fromARGB(255, 238, 240, 238);
const _defaultColorSelected = Color.fromARGB(186, 110, 221, 163);
const _defaultColorBlocked = Color.fromARGB(185, 221, 110, 110);

const _defaultLabelStyle = TextStyle(
  color: Colors.black87,
  fontSize: 9.0,
  fontWeight: FontWeight.w400,
);

/// A widget which allows you to easily select hour ranges.
///
/// Usage example:
/// ```
/// TimelineRangeSlider(
///      division: const TimeOfDay(hour: 0, minute: 15),
///      onChanged: (value) {
///        print(value);
///      },
///      slideHeight: 50,
///      displayHandles: true,
///      displayLabels: true,
///      step: const TimeOfDay(hour: 0, minute: 15),
///      selectedInterval: DateTimeRange(
///        start: DateTime(now.year, now.month, now.day, 10, 00),
///        end: DateTime(now.year, now.month, now.day, 12, 00),
///      ),
///      minTime: const TimeOfDay(hour: 7, minute: 0),
///      maxTime: const TimeOfDay(hour: 20, minute: 00),
///      disabledIntervals: <Track>[
///        Track(
///          const TimeOfDay(hour: 8, minute: 30),
///          const TimeOfDay(hour: 9, minute: 0),
///        ),
///        Track(
///          const TimeOfDay(hour: 13, minute: 0),
///          const TimeOfDay(hour: 15, minute: 30),
///        ),
///        Track(
///          const TimeOfDay(hour: 16, minute: 30),
///          const TimeOfDay(hour: 18, minute: 0),
///        ),
///      ],
///    )
/// ```
class TimelineRangeSlider extends LeafRenderObjectWidget {
  /// Color for displaying unavailable [Track] ranges.
  /// Defaults to dark grey color.
  final Color unavailableColor;

  /// Slider Background Color.
  /// Defaults to grey color.
  final Color backgroundColor;

  /// Color for displaying the current selected [Track] range.
  /// Defaults to green color.
  final Color selectedColor;

  /// Color for displaying the blocked [Track] ranges.
  /// Defaults to red color.
  final Color blockedColor;

  /// Whether should be displayed handles at the bounds of selected
  /// [Track] range. Defaults to true.
  final bool displayHandles;

  /// Whether should be displayed labels at bottom of the [TimelineRangeSlider] slider.
  /// Defaults to true.
  final bool displayLabels;

  /// How often should be displayed the divider.
  /// Defaults to each 30 min.
  final TimeOfDay step;

  /// Height of the slider.
  /// Defaults to 50.0.
  final double slideHeight;

  /// The [TextStyle] of the label.
  final TextStyle labelStyle;

  /// Selected Interval
  /// Inform start and end TimeOfDay
  final DateTimeRange selectedInterval;

  /// Minimun Interval to be selected
  /// Defaults to 1 hour
  final Duration minInterval;

  // Minimun Interval to be selected
  // Defaults to null
  final Duration? maxInterval;

  /// Initial/starting boundary of the left side of [TimelineRangeSlider].
  /// Defaults to 0h 0min.
  ///
  /// If both [minTime] and [maxTime] have values `hours` and `minutes` 0
  /// then the range of [TimelineRangeSlider] is 24 hours.
  ///
  /// Initial time must not be later than the [maxTime].
  final TimeOfDay minTime;

  /// Ending/final boundary of the left side of [TimelineRangeSlider].
  /// Defaults to 0h 0min.
  ///
  /// If both [minTime] and [maxTime] have values `hours` and `minutes` 0
  /// then the range of [TimelineRangeSlider] is 24 hours.
  ///
  /// Ending time must be later than the [minTime].
  final TimeOfDay maxTime;

  /// What [TimeOfDay] values can be iterated for each handle drag.
  /// Defaults to 30 minutes.
  ///
  /// For example - each handle drag will increases/decrease the
  /// current [TimeOfDay] by 2 hours:
  /// ```
  /// division: TimeOfDay(hour: 2, minute: 0),
  /// ```
  ///
  final TimeOfDay division;

  /// Triggered when the handle position changes.
  final ValueChanged<Track>? onChanged;

  /// List of [Track] which will fill the [TimelineRangeSlider] by the
  /// `isAvailable` property of [Track]. Not every range is needed to be
  /// filled - the rest of unfilled area will be filled with
  /// green [Track] values by default.
  ///
  /// [Track] must not overlap!
  final List<Track> disabledIntervals;

  /// Whether should be displayed handle area (development purposes) .
  final bool showHandleArea;

  const TimelineRangeSlider({
    Key? key,
    this.unavailableColor = _defaultColorUnavailable,
    this.backgroundColor = _defaultColorTrack,
    this.selectedColor = _defaultColorSelected,
    this.blockedColor = _defaultColorBlocked,
    this.displayHandles = true,
    this.displayLabels = true,
    this.labelStyle = _defaultLabelStyle,
    this.step = const TimeOfDay(hour: 0, minute: 30),
    this.slideHeight = 80.0,
    required this.selectedInterval,
    this.minInterval = const Duration(hours: 1),
    this.maxInterval,
    this.minTime = const TimeOfDay(hour: 0, minute: 0),
    this.maxTime = const TimeOfDay(hour: 0, minute: 0),
    this.division = const TimeOfDay(hour: 0, minute: 30),
    required this.onChanged,
    required this.disabledIntervals,
    this.showHandleArea = false,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTimelineRangeSlider(
      unavailableColor: unavailableColor,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      blockedColor: blockedColor,
      displayHandles: displayHandles,
      displayLabels: displayLabels,
      labelStyle: labelStyle,
      step: step,
      slideHeight: slideHeight,
      selectedInterval: selectedInterval,
      minInterval: minInterval,
      maxInterval: maxInterval,
      minTime: minTime,
      maxTime: maxTime,
      division: division,
      onChanged: onChanged,
      disabledIntervals: disabledIntervals,
      showHandleArea: showHandleArea,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderTimelineRangeSlider renderObject,
  ) {
    renderObject
      ..unavailableColor = unavailableColor
      ..backgroundColor = backgroundColor
      ..selectedColor = selectedColor
      ..blockedColor = blockedColor
      ..displayHandles = displayHandles
      ..displayLabels = displayLabels
      ..labelStyle = labelStyle
      ..step = step
      ..slideHeight = slideHeight
      ..selectedInterval = selectedInterval
      ..minInterval = minInterval
      ..maxInterval = maxInterval
      ..minTime = minTime
      ..maxTime = maxTime
      ..division = division
      ..onChanged = onChanged
      ..disabledIntervals = disabledIntervals
      ..showHandleArea = showHandleArea;
  }
}
