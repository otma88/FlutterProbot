import 'package:flutter/material.dart';
import 'package:probot/trainer_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print(localStorage.getKeys());
    var token = localStorage.getString('token');
    print(token);
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = TrainerMode();
    } else {
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
}
