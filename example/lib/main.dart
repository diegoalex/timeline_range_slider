import 'package:flutter/material.dart';
import 'package:timeline_range_slider/timeline_range_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timeline Range Slider Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Timeline Range Slider Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String durationString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Timeline Range Slider',
              ),
              const SizedBox(height: 20),
              _buildSlider(),
              const SizedBox(height: 20),
              Text(
                durationString,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    var now = DateTime.now();

    return TimelineRangeSlider(
      // showHandleArea: true,
      onChanged: (value) {
        // _do(value);
        // print(value);
        setState(() {
          durationString = value.toString();

          int stInMin = value.start.hour * 60 + value.start.minute;
          int enInMin = value.end.hour * 60 + value.end.minute;

          // durationString += ' -  ${stInMin - enInMin} minutes';
          durationString += ' -  ${(stInMin - enInMin) / 60} hs';
        });
      },
      slideHeight: 50,
      displayHandles: true,
      displayLabels: true,
      division: const TimeOfDay(hour: 0, minute: 15),
      step: const TimeOfDay(hour: 0, minute: 30),
      selectedInterval: DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 10, 00),
        end: DateTime(now.year, now.month, now.day, 12, 00),
      ),
      minTime: const TimeOfDay(hour: 7, minute: 0),
      maxTime: const TimeOfDay(hour: 20, minute: 00),
      minInterval: const Duration(minutes: 60),
      maxInterval: const Duration(hours: 4),
      disabledIntervals: <Track>[
        Track(
          const TimeOfDay(hour: 8, minute: 30),
          const TimeOfDay(hour: 9, minute: 0),
        ),
        Track(
          const TimeOfDay(hour: 13, minute: 0),
          const TimeOfDay(hour: 15, minute: 00),
        ),
        Track(
          const TimeOfDay(hour: 16, minute: 30),
          const TimeOfDay(hour: 18, minute: 0),
        ),
      ],
    );
  }
}
