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
  int seconds, minutes, hours;
  int maxScore, first;

  Timer timer;

  String time = "00 : 00 : 00";
  String timerText = "";

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
        secondPassed++;
      });
    } else {
      setState(() {
        first = 1;
        seconds = 0;
        minutes = 0;
        hours = 0;
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
    time = cal(secondPassed);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Schulte Table Game"),
          backgroundColor: Colors.redAccent.shade200,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
          child: Column(
            children: [
              Text(
                "Best   : " + timerText,
                style: (Theme.of(context).textTheme.headline5),
              ),
              Text(
                "Timer : " + time,
                style: (Theme.of(context).textTheme.headline5),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        floatingActionButton: GridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 1,
          padding: EdgeInsets.fromLTRB(30.0, 280.0, 0.0, 50.0),
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
                  onPressed: () => control(index),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(5),
          child: RaisedButton(
            child: Text(
              "Restart",
            ),
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                secondPassed = 0;
                val = Values.getValue();
                colorVal = Values.getColorValue();
                isFinish = false;
              });
            },
            color: Colors.redAccent.shade200,
          ),
        ),
      ),
    );
  }

  control(int index) {
    if (val[index] == first) {
      setState(() {
        colorVal[index] = 2;
        first++;
      });
      if (val[index] == 25) {
        setState(() {
          first = 0;
          if (maxScore == null) {
            maxScore = secondPassed;
            timerText = cal(maxScore);
          } else if (secondPassed < maxScore) {
            maxScore = secondPassed;
            timerText = cal(maxScore);
          }
          isFinish = true;
        });
      }
    }
  }

  //maxScore u text e çevirir.
  cal(int secondPassed) {
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
}
