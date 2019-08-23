import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimerApp();
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Text('$value',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          Text('$label', style: TextStyle(color: Colors.white70, fontSize: 14))
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void startTimer() {
    // clear any existing timer
    if (timer != null){
      timer.cancel();
    }

    setState(() {
      isActive = true;
    });
    timer = Timer.periodic(
        duration,
        (Timer t) => setState(() {
              secondsPassed += 1;
            }));
  }

  void stopTimer() {
    if (timer != null){
      timer.cancel();
    }
    setState(() {
      secondsPassed = 0;
      isActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60*60);

    return MaterialApp(
        title: 'timer',
        home: Scaffold(
            appBar: AppBar(title: Text('Timer App')),
            body: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextContainer(value: hours.toString().padLeft(2, '0'), label: 'HRS'),
                    CustomTextContainer(value: minutes.toString().padLeft(2, '0'), label: 'MIN'),
                    CustomTextContainer(value: seconds.toString().padLeft(2, '0'), label: 'SEC')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 16.0, right: 8.0),
                        child: RaisedButton(
                          child: Text('START',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.green,
                          onPressed: isActive ? null : startTimer,
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: RaisedButton(
                          child: Text(
                            'RESET',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                          onPressed: isActive ? stopTimer: null,
                        )),
                  ],
                )
              ],
            ))));
  }
}
