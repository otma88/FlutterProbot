import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF3FA9F5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 25.0, 2.0, 2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 50.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
