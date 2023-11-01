import 'package:flutter/material.dart';
import 'package:timeline_range_slider/timeline_range_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timeline Range Slider Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: const MyHomePage(title: 'Timeline Range Slider Demo'),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
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
        //switch theme button
        actions: [
          IconButton(
            onPressed: () {
              if (Theme.of(context).brightness == Brightness.dark) {
                context.findAncestorStateOfType<_MyAppState>()?.changeTheme(
                      ThemeMode.light,
                    );
              } else {
                context.findAncestorStateOfType<_MyAppState>()?.changeTheme(
                      ThemeMode.dark,
                    );
              }
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.brightness_2
                  : Icons.brightness_7,
            ),
          ),
        ],
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
              SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: _buildSlider()),
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      unavailableColor: Theme.of(context).disabledColor,
      borderColor: Theme.of(context).colorScheme.onSurface,
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
      showHandleArea: false,
      displayLabels: true,
      division: const TimeOfDay(hour: 0, minute: 15),
      step: const TimeOfDay(hour: 0, minute: 30),
      selectedInterval: DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 9, 00),
        end: DateTime(now.year, now.month, now.day, 12, 00),
      ),
      minTime: const TimeOfDay(hour: 7, minute: 0),
      maxTime: const TimeOfDay(hour: 20, minute: 00),
      minInterval: const Duration(minutes: 60),
      // maxInterval: const Duration(hours: 4),
      user24HourFormat: false,
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
