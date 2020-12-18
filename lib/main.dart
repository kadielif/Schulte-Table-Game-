import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:schulte_table_game/values.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const duration = const Duration(seconds: 1);
  List<int> val = Values.getValue();
  List<int> colorVal;
  bool isFinish = false;
  int secondPassed = 0;
  int bestScore, first;
  Timer timer;
  String time = "00 : 00 : 00";
  String timerText = "";
  double opacityLevel = 0.0;

  @override
  void initState() {
    first = 1;
    isFinish = false;
    colorVal = Values.getColorValue();
    super.initState();
  }

  void handleTick() {
    if (!isFinish) {
      setState(() {
        opacityLevel = 0.0;
        secondPassed++;
      });
    } else {
      setState(() {
        opacityLevel = 1.0;
        first = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    time = timerTextParse(secondPassed);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Schulte Table Game",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: Colors.redAccent.shade200,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "Best   : " + timerText,
                style: (Theme.of(context).textTheme.headline4),
              ),
              Text(
                "Timer : " + time,
                style: (Theme.of(context).textTheme.headline4),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        floatingActionButton: GridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 1,
          padding: EdgeInsets.fromLTRB(30.0, 350.0, 0.0, 50.0),
          children: List.generate(
            25,
            (index) {
              int text;
              text = val[index];
              return Container(
                padding: EdgeInsets.all(1.5),
                child: RaisedButton(
                  child: Text(
                    '$text',
                    style: (Theme.of(context).textTheme.headline5),
                  ),
                  color: colorVal[index] == 2
                      ? Colors.green.shade300
                      : Colors.grey.shade300,
                  onPressed: () => indexControllers(index),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10.0),
          child: AnimatedOpacity(
            opacity: opacityLevel,
            duration: Duration(milliseconds: 100),
            child: RaisedButton(
              child: Text(
                "RESTART",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              onPressed: () => restartButton(),
              color: Colors.redAccent.shade200,
            ),
          ),
        ),
      ),
    );
  }

  indexControllers(int index) {
    if (val[index] == first) {
      setState(() {
        colorVal[index] = 2;
        first++;
      });
      if (val[index] == 25) {
        setState(() {
          if (bestScore == null) {
            bestScore = secondPassed;
            timerText = timerTextParse(bestScore);
          } else if (secondPassed < bestScore) {
            bestScore = secondPassed;
            timerText = timerTextParse(bestScore);
          }
          isFinish = true;
        });
      }
    }
  }

  timerTextParse(int secondPassed) {
    int seconds, minutes, hours;
    String timeText;
    seconds = secondPassed % 60;
    minutes = secondPassed ~/ 60;
    hours = secondPassed ~/ (60 * 60);

    timeText = hours.toString().padLeft(2, '0') +
        " : " +
        minutes.toString().padLeft(2, '0') +
        " : " +
        seconds.toString().padLeft(2, '0');
    return timeText;
  }

  restartButton() {
    setState(() {
      secondPassed = 0;
      val = Values.getValue();
      colorVal = Values.getColorValue();
      isFinish = false;
    });
  }
}
