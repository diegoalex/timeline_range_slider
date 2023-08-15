<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Timeline Range Slider

A Flutter widget that allows you to easily select hour ranges on a timeline.

## Usage

To use this widget, simply add it to your Flutter app and provide the necessary parameters:

```dart
TimelineRangeSlider(
  division: const TimeOfDay(hour: 0, minute: 15),
  onChanged: (value) {
    print(value);
  },
  slideHeight: 50,
  displayHandles: true,
  displayLabels: true,
  step: const TimeOfDay(hour: 0, minute: 15),
  selectedInterval: DateTimeRange(
    start: DateTime(now.year, now.month, now.day, 10, 00),
    end: DateTime(now.year, now.month, now.day, 12, 00),
  ),
  minTime: const TimeOfDay(hour: 7, minute: 0),
  maxTime: const TimeOfDay(hour: 20, minute: 00),
  disabledIntervals: <Track>[
    Track(
      const TimeOfDay(hour: 8, minute: 30),
      const TimeOfDay(hour: 9, minute: 0),
    ),
    Track(
      const TimeOfDay(hour: 13, minute: 0),
      const TimeOfDay(hour: 15, minute: 30),
    ),
    Track(
      const TimeOfDay(hour: 16, minute: 30),
      const TimeOfDay(hour: 18, minute: 0),
    ),
  ],
)
```

## Parameters

- `unavailableColor`: Color for displaying unavailable `Track` ranges. Defaults to dark grey color.
- `backgroundColor`: Slider background color. Defaults to grey color.
- `selectedColor`: Color for displaying the current selected `Track` range. Defaults to green color.
- `blockedColor`: Color for displaying the blocked `Track` ranges. Defaults to red color.
- `displayHandles`: Whether to display handles at the bounds of selected `Track` range. Defaults to true.
- `displayLabels`: Whether to display labels at bottom of the `TimelineRangeSlider` slider. Defaults to true.
- `labelStyle`: The `TextStyle` of the label.
- `step`: How often to display the divider. Defaults to each 30 min.
- `slideHeight`: Height of the slider. Defaults to 50.0.
- `selectedInterval`: Selected interval. Inform start and end `TimeOfDay`.
- `minInterval`: Minimum interval to be selected. Defaults to 1 hour.
- `maxInterval`: Maximum interval to be selected. Defaults to null.
- `minTime`: Initial/starting boundary of the left side of `TimelineRangeSlider`. Defaults to 0h 0min.
- `maxTime`: Ending/final boundary of the left side of `TimelineRangeSlider`. Defaults to 0h 0min.
- `division`: What `TimeOfDay` values can be iterated for each handle drag. Defaults to 30 minutes.
- `onChanged`: Triggered when the handle position changes.
- `disabledIntervals`: List of `Track` which will fill the `TimelineRangeSlider` by the `isAvailable` property of `Track`. Not every range is needed to be filled - the rest of unfilled area will be filled with green `Track` values by default. `Track` must not overlap!

## Example

For a complete example, see the `example` directory in this repository.

## License

This library is licensed under the MIT license. See the `LICENSE` file for more details.
