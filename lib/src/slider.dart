import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timeline_range_slider/src/helpers.dart';
import 'dart:ui' as ui;

import 'package:timeline_range_slider/src/track.dart';

/// Renders a timeline range slider widget.
///
/// This widget allows the user to select a range of time values from a timeline.
/// The widget displays a track with a range of available and unavailable time
/// intervals, and two handles that the user can drag to select a range of time
/// values. The widget also displays labels that show the selected time range.
///
/// The widget is rendered using the [RenderBox] class and supports the following
/// properties:
///
/// * `borderColor`: The color of the border of the track.
/// * `unavailableColor`: The color of the track for unavailable time intervals.
/// * `availableColor`: The color of the track for available time intervals.
/// * `selectedColor`: The color of the track for the selected time range.
/// * `blockedColor`: The color of the track for blocked time intervals.
/// * `displayHandles`: Whether to display the handles for selecting the time range.
/// * `displayLabels`: Whether to display the labels for the selected time range.
/// * `step`: The time step for the timeline.
/// * `slideHeight`: The height of the slider.
/// * `labelStyle`: The style of the labels.
/// * `selectedInterval`: The selected time range.
/// * `minInterval`: The minimum time interval that can be selected.
/// * `maxInterval`: The maximum time interval that can be selected.
/// * `minTime`: The minimum time value for the timeline.
/// * `maxTime`: The maximum time value for the timeline.
/// * `division`: The time division for the timeline.
/// * `onChanged`: A callback function that is called when the selected time range changes.
/// * `disabledIntervals`: A list of time intervals that are disabled.

class RenderTimelineRangeSlider extends RenderBox {
  Color _borderColor;
  Color _unavailableColor;
  Color _backgroundColor;
  Color _selectedColor;
  Color _blockedColor;
  bool _displayHandles;
  bool _displayLabels;
  TimeOfDay _step;
  double _slideHeight;
  TextStyle _labelStyle;
  DateTimeRange _selectedInterval;
  Duration _minInterval;
  Duration? _maxInterval;
  TimeOfDay _minTime;
  TimeOfDay _maxTime;
  TimeOfDay _division;
  ValueChanged<Track>? _onChanged;
  List<Track> _disabledIntervals;
  bool _showHandleArea;

  // constructor
  RenderTimelineRangeSlider({
    required Color borderColor,
    required Color unavailableColor,
    required Color backgroundColor,
    required Color selectedColor,
    required Color blockedColor,
    required bool displayHandles,
    required bool displayLabels,
    required TimeOfDay step,
    required double slideHeight,
    required TextStyle labelStyle,
    required DateTimeRange selectedInterval,
    required Duration minInterval,
    required Duration? maxInterval,
    required TimeOfDay minTime,
    required TimeOfDay maxTime,
    required TimeOfDay division,
    required ValueChanged<Track>? onChanged,
    required List<Track> disabledIntervals,
    required bool showHandleArea,
  })  : _borderColor = borderColor,
        _unavailableColor = unavailableColor,
        _backgroundColor = backgroundColor,
        _selectedColor = selectedColor,
        _blockedColor = blockedColor,
        _displayHandles = displayHandles,
        _displayLabels = displayLabels,
        _labelStyle = labelStyle,
        _step = step,
        _slideHeight = slideHeight,
        _selectedInterval = selectedInterval,
        _minInterval = minInterval,
        _maxInterval = maxInterval,
        _minTime = minTime,
        _maxTime = maxTime,
        _division = division,
        _onChanged = onChanged,
        _disabledIntervals = disabledIntervals,
        _showHandleArea = showHandleArea {
    drag = HorizontalDragGestureRecognizer()..onUpdate = updateHandlePos;
    sortCheckValues();

    leftHandleValue =
        (TimeOfDay.fromDateTime(selectedInterval.start).totalRangeTime -
                minTime.totalRangeTime) /
            totalTimeInMinutes;

    rightHandleValue =
        (TimeOfDay.fromDateTime(selectedInterval.end).totalRangeTime -
                minTime.totalRangeTime) /
            totalTimeInMinutes;
  }

  // Getters and setters
  Color get borderColor => _borderColor;
  set borderColor(Color value) {
    if (value == borderColor) {
      return;
    }
    _borderColor = value;
    markNeedsPaint();
  }

  Color get unavailableColor => _unavailableColor;
  set unavailableColor(Color value) {
    if (value == unavailableColor) {
      return;
    }
    _unavailableColor = value;
    markNeedsPaint();
  }

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color value) {
    if (value == backgroundColor) {
      return;
    }
    _backgroundColor = value;
    markNeedsPaint();
  }

  Color get selectedColor => _selectedColor;
  set selectedColor(Color value) {
    if (value == selectedColor) {
      return;
    }
    _selectedColor = value;
    markNeedsPaint();
  }

  Color get blockedColor => _blockedColor;
  set blockedColor(Color value) {
    if (value == blockedColor) {
      return;
    }
    _blockedColor = value;
    markNeedsPaint();
  }

  bool get displayHandles => _displayHandles;
  set displayHandles(bool value) {
    if (value == displayHandles) {
      return;
    }
    _displayHandles = value;
    markNeedsLayout();
  }

  bool get displayLabels => _displayLabels;
  set displayLabels(bool value) {
    if (value == displayLabels) {
      return;
    }
    _displayLabels = value;
    markNeedsLayout();
  }

  TimeOfDay get step => _step;
  set step(TimeOfDay value) {
    if (value == step) {
      return;
    }
    _step = value;
    markNeedsPaint();
  }

  double get slideHeight => _slideHeight;
  set slideHeight(double value) {
    if (value == slideHeight) {
      return;
    }
    _slideHeight = value;
    markNeedsLayout();
  }

  TextStyle get labelStyle => _labelStyle;
  set labelStyle(TextStyle value) {
    if (value == labelStyle) {
      return;
    }
    _labelStyle = value;
    markNeedsLayout();
  }

  DateTimeRange get selectedInterval => _selectedInterval;
  set selectedInterval(DateTimeRange value) {
    if (value == selectedInterval) {
      return;
    }
    _selectedInterval = value;
    markNeedsPaint();
  }

  Duration get minInterval => _minInterval;
  set minInterval(Duration value) {
    if (value == minInterval) {
      return;
    }
    _minInterval = value;
    markNeedsPaint();
  }

  Duration? get maxInterval => _maxInterval;
  set maxInterval(Duration? value) {
    if (value == maxInterval) {
      return;
    }
    _maxInterval = value;
    markNeedsPaint();
  }

  TimeOfDay get minTime => _minTime;
  set minTime(TimeOfDay value) {
    if (value == minTime) {
      return;
    }
    _minTime = value;
    markNeedsPaint();
  }

  TimeOfDay get maxTime => _maxTime;
  set maxTime(TimeOfDay value) {
    if (value == maxTime) {
      return;
    }
    _maxTime = value;
    markNeedsPaint();
  }

  TimeOfDay get division => _division;
  set division(TimeOfDay value) {
    if (value == division) {
      return;
    }
    _division = value;
    markNeedsPaint();
  }

  ValueChanged<Track>? get onChanged => _onChanged;
  set onChanged(ValueChanged<Track>? value) {
    if (value == onChanged) {
      return;
    }
    _onChanged = value;
    markNeedsPaint();
  }

  List<Track> get disabledIntervals => _disabledIntervals;
  set disabledIntervals(List<Track> value) {
    if (value == disabledIntervals) {
      return;
    }
    _disabledIntervals = List.from(value);
    markNeedsPaint();
  }

  bool get showHandleArea => _showHandleArea;
  set showHandleArea(bool value) {
    if (value == showHandleArea) {
      return;
    }
    _showHandleArea = value;
    markNeedsPaint();
  }

  static const minWidth = 120.0;

  double get handleSize => (labelStyle.fontSize ?? 3);

  double leftHandleValue = 0.1;
  double rightHandleValue = 0.8;

  bool sliderBlocked = false;

  late HorizontalDragGestureRecognizer drag;

  // Create the UI
  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    // translate() method remaps the (0,0) position on the canvas
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    paintRects(canvas);

    if (displayHandles) {
      paintHandles(canvas);
    }

    if (displayLabels) {
      paintBars(canvas);
    }

    // restore the translation at the beginning
    canvas.restore();
  }

  @override
  void performResize() {
    size = constraints.constrain(Size(
      600,
      slideHeight,
    ));
  }

  void sortCheckValues() {
    if (disabledIntervals.isEmpty) {
      setupEmpty();
    } else {
      disabledIntervals.any((e) {
        final check = e.end.totalRangeTime > maxTime.totalRangeTime;
        if (check) {
          throw ('${e.toString()} does not fit into the maxTime: ${maxTime.toString()}');
        }
        return check;
      });

      final bookingValuesList = <Track>[
        ...disabledIntervals.where((item) => !item.isAvailable)
      ];
      if (bookingValuesList.isEmpty) {
        setupEmpty();
        return;
      }

      bookingValuesList.sort((a, b) => a.compareTo(b));

      bool isInvalid = false;
      for (var i = 0; i < bookingValuesList.length; i++) {
        if (i != bookingValuesList.length - 1) {
          final curr = bookingValuesList[i];
          final next = bookingValuesList[i + 1];

          final currStartTime = curr.start.totalRangeTime;
          final nextStartTime = next.start.totalRangeTime;

          final currEndTime = curr.end.totalRangeTime;
          if (currStartTime == nextStartTime) {
            isInvalid = false;
          } else if (nextStartTime < currEndTime) {
            isInvalid = true;
          } else {
            isInvalid = false;
          }

          if (isInvalid) {
            throw ('Values cannot overlap. The relevant values: \n$curr\n$next');
          }
        }
      }
      disabledIntervals = bookingValuesList;
    }
  }

  void setupEmpty() {
    disabledIntervals = <Track>[
      Track(minTime, maxTime, isAvailable: true),
    ];
  }

  /// Create the blocks for the available and unavailable times
  void paintRects(Canvas canvas) {
    var newSize = size; //Size(size.width, slideHeight);
    final total = totalTimeInMinutes;
    final onePortion = size.width / total;

    final paintBorder = Paint()
      ..color = _borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5;

    // Draw the available area (slider rail)
    final availablePaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final baseRect = Rect.fromPoints(
      Offset.zero,
      newSize.bottomRight(Offset.zero),
    );
    canvas.drawRect(baseRect, availablePaint);
    canvas.drawRect(baseRect, paintBorder);

    // Draw the unavailable areas
    for (final value in disabledIntervals.where((e) => !e.isAvailable)) {
      final paint = Paint();

      paint
        ..color = unavailableColor
        ..style = PaintingStyle.fill;

      final timePortionRect = Rect.fromPoints(
        Offset(
          onePortion * (value.start.totalRangeTime - minTime.totalRangeTime),
          0,
        ),
        Offset(
          onePortion * (value.end.totalRangeTime - minTime.totalRangeTime),
          newSize.bottomRight(Offset.zero).dy,
        ),
      );

      canvas.drawRect(timePortionRect, paint);
      canvas.drawRect(timePortionRect, paintBorder);
    }

    // Draw the Selected area
    final selectedRect = Rect.fromPoints(
      Offset(newSize.width * leftHandleValue, 0),
      Offset(newSize.width * rightHandleValue, newSize.height),
    );
    canvas.drawRect(
      selectedRect,
      Paint()..color = sliderBlocked ? blockedColor : selectedColor,
    );
  }

  /// build the slider handles
  void paintHandles(Canvas canvas) {
    final paint = Paint()..color = const Color.fromARGB(255, 43, 43, 43);

    final paintBorder = Paint()
      ..color = const Color.fromARGB(255, 228, 224, 224)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final leftHandleX = leftHandleValue * size.width;
    final rightHandleX = rightHandleValue * size.width;

    const handleSize = Size(8, 20);
    final leftHandleRect = RRect.fromRectAndRadius(
        Offset(leftHandleX - 5, (size.height / 2) - 10) & handleSize,
        const Radius.circular(1));
    final rightHandleRect = RRect.fromRectAndRadius(
        Offset(rightHandleX - 5, (size.height / 2) - 10) & handleSize,
        const Radius.circular(1));

    final leftPath = Path();
    leftPath.addRRect(leftHandleRect);

    final rightPath = Path();
    rightPath.addRRect(rightHandleRect);

    if (showHandleArea) {
      //draw touch area
      var handleBound = 12.0;
      final touchPaint = Paint();
      touchPaint
        ..color = Colors.amber
        ..style = PaintingStyle.fill;

      // left handle touch area
      final leftHandleTouchArea = RRect.fromRectAndRadius(
        Offset(leftHandleX - 9 - handleBound, 0) &
            Size(16 + handleBound + handleBound, slideHeight),
        const Radius.circular(1),
      );
      final leftTouchPath = Path();
      leftTouchPath.addRRect(leftHandleTouchArea);
      canvas.drawPath(leftTouchPath, touchPaint);

      // right handle touch area
      final rightHandleTouchArea = RRect.fromRectAndRadius(
        Offset(rightHandleX - 9 - handleBound, 0) &
            Size(16 + handleBound + handleBound, slideHeight),
        const Radius.circular(1),
      );
      final rightTouchPath = Path();
      rightTouchPath.addRRect(rightHandleTouchArea);
      touchPaint.color = Colors.red;
      canvas.drawPath(rightTouchPath, touchPaint);
    }
    canvas.drawPath(leftPath, paint);
    canvas.drawPath(leftPath, paintBorder);
    canvas.drawPath(rightPath, paint);
    canvas.drawPath(rightPath, paintBorder);
  }

  /// Create the steps divider and the labels
  void paintBars(Canvas canvas) {
    var total = maxTime.totalRangeTime - minTime.totalRangeTime;
    if (total == 0) {
      total = 1440;
    }

    var isHour = true;
    if (minTime.minute != 0) {
      isHour = false;
    }

    var activeTime = minTime;

    // calculate the spacing between each step
    final p = step.totalRangeTime;
    final freq = total / p;
    final spacing = size.width / freq;

    // calculate the number of labels to print
    var labelSize = 25;
    var totHours = (total / 60);
    var totHoursWidth = totHours * labelSize;
    var totLabels = (totHoursWidth / labelSize).floor();
    var maxLabels = (size.width / labelSize).floor();

    // create the paint for the lines
    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = .85;

    for (var i = 0; i <= freq; i++) {
      var upperPoint = Offset(spacing * i, slideHeight);
      final lowerPoint = Offset(
        spacing * i,
        slideHeight - (isHour ? 10 : 5),
      );

      // draw the line
      canvas.drawLine(upperPoint, lowerPoint, paint);

      // only print hours
      if (isHour) {
        // check if the number of labels is too high
        // if so, print only the even hours
        if (totLabels > maxLabels) {
          if (activeTime.hour % 2 == 0) {
            paintTextLabel(canvas, upperPoint, lowerPoint, freq, activeTime);
          }
        } else {
          paintTextLabel(canvas, upperPoint, lowerPoint, freq, activeTime);
        }
      }

      activeTime = activeTime.plusMinutes(p);
      isHour = (activeTime.minute == 0);
    }
  }

  /// Paint the text label for the given [time]
  void paintTextLabel(
    Canvas canvas,
    Offset upperPoint,
    Offset lowerPoint,
    double freq,
    TimeOfDay time,
  ) {
    final hrs = Helpers.addLeadingZeroIfNeeded(time.hour);
    final mins = Helpers.addLeadingZeroIfNeeded(time.minute);

    final textStyle = labelStyle.getTextStyle(textScaleFactor: .9);
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText('$hrs:$mins');
    const constraints =
        ui.ParagraphConstraints(width: 25); // size.width / freq);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);

    final textOffset =
        Offset(lowerPoint.dx - 10, slideHeight); //.scale(1 * 0.9995, 2.25);
    canvas.drawParagraph(paragraph, textOffset);
  }

  void updateHandlePos(DragUpdateDetails dragUpdateDetails) {
    // restrict a number between 0 and size of the widget
    // (to get rid of out bounds clicks)
    final x = dragUpdateDetails.localPosition.dx.clamp(0, size.width);

    // calculate the position of the click as a percentage
    final pos = x / size.width;

    // check which handle is being dragged
    var isLeftHandleChanged = false;
    var isRightHandleChanged = false;
    // Calculate the handle bound area
    // so that the user can drag the handle
    // The standard handle bound is 0.04 for 15 minutes
    // handleBound = [division_in_minutes] * 0.04 / 15
    var handleBound = 0.05; //division.totalRangeTime * 0.04 / 15;
    var stepSize = division.totalRangeTime * 0.05 / 15;
    var stepHandleBound = handleBound + (stepSize - handleBound);

    //check if left handle is being dragged
    if ((pos + handleBound) >= leftHandleValue &&
        (pos - handleBound) <= leftHandleValue) {
      print('left handle');
      isLeftHandleChanged = true;
    }

    //check if right handle is being dragged
    if ((pos + handleBound) >= rightHandleValue &&
        (pos - handleBound) <= rightHandleValue) {
      print('right handle');
      isRightHandleChanged = true;
    }

    // check if pos is between the handles
    if (pos > (leftHandleValue + handleBound) &&
        pos < (rightHandleValue - handleBound)) {
      print('inside area');
      moveFixedSlider(pos);
      return;
    } else {
      if (!isLeftHandleChanged && !isRightHandleChanged) {
        print('OURSIDE area');

        return;
      }
    }

    resizeSlider(isLeftHandleChanged, pos);
  }

  void moveFixedSlider(double position) {
    //get center position of slider
    var centerPos = (leftHandleValue + rightHandleValue) / 2;
    var newPos = double.parse((findClosest(position)).toStringAsFixed(12));

    // get diff between center and new position
    var diff = centerPos - newPos;

    // check if the new position is out of bounds
    if (leftHandleValue - diff < 0 || rightHandleValue - diff > 1) {
      return;
    }

    //move slider
    leftHandleValue = leftHandleValue - diff;
    rightHandleValue = rightHandleValue - diff;

    checkSliderAvailability();

    markNeedsPaint();
  }

  void resizeSlider(bool isLeftHandle, double position) {
    // config new position based on the slider step
    var newPos = double.parse((findClosest(position)).toStringAsFixed(12));
    var leftPos =
        leftHandleValue; // double.parse((findClosest(leftHandleValue)).toStringAsFixed(12));
    var rightPos =
        rightHandleValue; //double.parse((findClosest(rightHandleValue)).toStringAsFixed(12));

    // new slider duration
    var newInterval = ((isLeftHandle
                ? (rightHandleValue - newPos)
                : (newPos - leftHandleValue)) *
            totalTimeInMinutes)
        .round();

    // check if the new position is the same as the old one
    if ((isLeftHandle ? leftHandleValue : rightHandleValue) == newPos) {
      return;
    }

    // check if the new position is not out of bounds
    if (newPos < 0 || newPos > 1) {
      return;
    }

    // // calculate the min and max distance between the handles
    var minDistance =
        ((minInterval.inMinutes * 100) / totalTimeInMinutes) / 100;
    var maxDistance =
        (((maxInterval ?? const Duration(seconds: 0)).inMinutes * 100) /
                totalTimeInMinutes) /
            100;

    print(
        '${isLeftHandle ? 'LEFT' : 'RIGHT'} - newval: $newInterval ----- minval: ${minInterval.inMinutes} ----- maxval: ${maxInterval?.inMinutes}');

    if (isLeftHandle) {
      leftPos = newPos;
    } else {
      rightPos = newPos;
    }

    // check min distance between handles
    if (newInterval <= minInterval.inMinutes) {
      if (isLeftHandle) {
        rightPos = newPos + minDistance;
      } else {
        leftPos = newPos - minDistance;
      }
    }

    // check max distance between handles
    else if (maxInterval != null && newInterval >= maxInterval!.inMinutes) {
      if (isLeftHandle) {
        rightPos = newPos + maxDistance;
      } else {
        leftPos = newPos - maxDistance;
      }
    }

    // set new handle position
    leftHandleValue = leftPos;
    rightHandleValue = rightPos;

    checkSliderAvailability();

    markNeedsPaint();
  }

  // The `checkSliderAvailability()` function calculates the time range selected by the user on a slider and checks if that range is available for booking.
  void checkSliderAvailability() {
    // Calculate the total time range based on the minimum and maximum time values
    final total = totalTimeInMinutes;
    // Calculate the time value of the left handle of the slider
    final leftValueTime = Helpers.convertToTimeOfDay(
        (leftHandleValue * total) + minTime.totalRangeTime);
    // Calculate the time value of the right handle of the slider
    final rightValueTime = Helpers.convertToTimeOfDay(
        (rightHandleValue * total) + minTime.totalRangeTime);

    // Check if the selected time range is available for booking
    final track = isSelectionAvailable(leftValueTime, rightValueTime);
    // Set the sliderBlocked variable to true if the selected time range is not available for booking
    sliderBlocked = (track.isAvailable == false);

    // Call the onChanged callback function with the track value as an argument
    if (onChanged != null) onChanged!(track);
  }

  Track isSelectionAvailable(
    TimeOfDay leftValueTime,
    TimeOfDay rightValueTime,
  ) {
    final isUnavailable = disabledIntervals.any((item) {
      if (item.isAvailable) {
        // print('base');
        return false;
      }

      final leftHandleDur = leftValueTime.totalRangeTime;
      final rightHandleDur = rightValueTime.totalRangeTime;

      final leftItemDur = item.start.totalRangeTime;
      final rightItemDur = item.end.totalRangeTime;

      // 120 - 180; 30 - 120
      if (leftHandleDur <= leftItemDur && rightHandleDur <= leftItemDur) {
        // print('valid 1st');
        return false;
      }

      // 120 - 180; 180 - 210
      if (leftHandleDur >= rightItemDur && leftHandleDur >= rightItemDur) {
        // print('valid 2nd');
        return false;
      }

      // 120 - 180; 120 - 150
      if (leftHandleDur >= leftItemDur && rightHandleDur <= rightItemDur) {
        // print('1st');
        return true;
      }

      // 120 - 180; 60 - 200
      if (leftHandleDur <= leftItemDur && rightHandleDur >= rightItemDur) {
        // print('2nd');
        return true;
      }

      // 120 - 180; 60 - 150
      if (leftHandleDur <= leftItemDur &&
          rightHandleDur >= leftItemDur &&
          rightHandleDur <= rightItemDur) {
        // print('3rd');
        return true;
      }

      // 120 - 180; 150 - 200
      if ((leftHandleDur >= leftItemDur && leftHandleDur <= rightItemDur) &&
          (rightHandleDur >= leftItemDur && rightHandleDur >= rightItemDur)) {
        // print('4th');
        return true;
      }

      // print('end');
      return false;
    });
    // print('${!isUnavailable} \n\n');
    return Track(
      leftValueTime,
      rightValueTime,
      isAvailable: !isUnavailable,
    );
  }

  // 24 hrs range - 0:00 to 0:00
  int get totalTimeInMinutes {
    var total = maxTime.totalRangeTime - minTime.totalRangeTime;
    if (total == 0) {
      total = 1440;
    }
    return total;
  }

  double findClosest(double input) {
    final total = totalTimeInMinutes;

    final p = division.totalRangeTime;
    final freq = total / p;
    final timestampDiv = 1 / freq;

    final list = List.generate(
      freq.floor() + 1,
      (i) => i * timestampDiv,
    );

    double minDiff = 999;
    double closest = -1;
    for (final val in list) {
      final curr = input - val;
      if (curr >= 0 && curr < minDiff) {
        minDiff = curr;
        closest = val;
      }
    }
    // debugPrint('$input ----------- $list ----------- $closest');

    if (closest == -1) {
      return 0;
    }
    return closest;
  }

  @override
  double computeMinIntrinsicWidth(double height) => minWidth;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final customHeight = (labelStyle.fontSize ?? 3) * 1.5;
    final size = Size(
      constraints.maxWidth,
      customHeight,
    );
    return size;
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool get sizedByParent => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      drag.addPointer(event);
    }
  }

  @override
  void detach() {
    drag.dispose();
    super.detach();
  }
}
