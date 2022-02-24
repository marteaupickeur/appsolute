import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // set a time and after load the next route
  startTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration,
        () => {Navigator.pushReplacementNamed(context, '/everything')});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // call when start
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'appsolute',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  'Technical Test : News App',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
