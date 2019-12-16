import 'dart:async';
import 'package:flutter/material.dart';
import 'trainer_mode.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {

  @override
  State createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TrainerMode()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/background_logo.png'),
            fit: BoxFit.cover
        ),
      ),
      child: Center(
        child: Image(
            image: AssetImage('images/logo.png'),
        ),
      ),
    );
  }


}