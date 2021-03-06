import 'dart:async';
import 'package:flutter/material.dart';
import 'package:probot/widgets/check_auth.dart';
import 'trainer_mode.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CheckAuth()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/background_logo.png'), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.1),
        child: Image(
          image: AssetImage('images/logo.png'),
        ),
      ),
    );
  }
}
