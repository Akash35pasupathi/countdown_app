import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyDashboard extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyDashboardPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyDashboardPage extends StatefulWidget {
  MyDashboardPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboardPage> {
  int day = 0, hour = 0, minute = 5, sec = 0;

  bool isTurnerStated = false;

  int countdownTimer = 300;
  double countdownPercent = 1.00;

  @override
  void initState() {
    super.initState();
    _countdownTimer();
  }

  void _countdownTimer() {
    setState(() {
      if (sec == 0 && minute == 0) {
        sec = 00;
        minute = 05;
      } else {
        if (sec == 00) {
          minute = minute - 1;
          sec = 59;
        } else {
          sec = sec - 1;
        }
      }

      countdownTimer = (minute * 60) + sec;

      countdownPercent = countdownTimer / 300;

      Timer(
        Duration(seconds: 1),
        _countdownTimer,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding:
                EdgeInsets.only(bottom: 50, left: 30.0, right: 30, top: 60),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/dashboard_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Turnier Countdown',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width / 1.6,
                        lineWidth: 15.0,
                        percent: countdownPercent,
                        center: Expanded(
                          child: Image.asset('assets/image/image_button.png'),
                        ),
                        progressColor: Color(0xFFDC5D64),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Turnierstart',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 29,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Container(
                        height: MediaQuery.of(context).size.height / 7,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            circleCountDownWidget(
                                "DAY(s)",
                                day.toString().length == 1
                                    ? "0${day.toString()}"
                                    : day.toString),
                            circleCountDownWidget(
                                "HOUR",
                                hour.toString().length == 1
                                    ? "0${hour.toString()}"
                                    : hour.toString()),
                            circleCountDownWidget(
                                "MINUTE",
                                minute.toString().length == 1
                                    ? "0${minute.toString()}"
                                    : minute.toString()),
                            circleCountDownWidget(
                                "SECOND",
                                sec.toString().length == 1
                                    ? "0${sec.toString()}"
                                    : sec.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget circleCountDownWidget(
    String lblText,
    String countdownText,
  ) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: Color(0xFFDC5D64),
                    width: 2,
                  ),
                ),
                child: new Center(
                  child: new Text(
                    countdownText,
                    style: TextStyle(
                      color: Color(0xFFDC5D64),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            lblText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
