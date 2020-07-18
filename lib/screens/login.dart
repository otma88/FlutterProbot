import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probot/network/api.dart';
import 'package:probot/screens/trainer_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var username;
  var password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMessage(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(label: 'Close', onPressed: () {}),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        color: Color(0xFF3FA9F5),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 50.0, color: Color(0xFF242432), fontFamily: 'Barlow', fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Expanded(
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Username:",
                                    style: TextStyle(fontSize: 23, color: Color(0xFF1E1E28), fontFamily: 'BarlowCondensed'),
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                style: TextStyle(fontSize: 35, color: Color(0xFF1E1E28)),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                validator: (usernameValue) {
                                  if (usernameValue.isEmpty) {
                                    return 'Please enter username';
                                  }
                                  username = usernameValue;
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Password:",
                                  style: TextStyle(fontSize: 23, color: Color(0xFF1E1E28), fontFamily: 'BarlowCondensed'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                style: TextStyle(fontSize: 35, color: Color(0xFF1E1E28)),
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                                    filled: true,
                                    fillColor: Colors.white),
                                expands: true,
                                maxLines: null,
                                minLines: null,
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 30.0,
                                          height: 30.0,
                                          child: Checkbox(
                                            activeColor: Colors.white,
                                            value: false,
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "Remember me",
                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'BarlowCondensed'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        child: Text(
                                          "Forgot password?",
                                          style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'BarlowCondensed'),
                                        ),
                                        onTap: () {
                                          print("Forgot password");
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(),
                          flex: 1,
                        ),
                        Expanded(
                          child: SizedBox(),
                          flex: 2,
                        ),
                        Expanded(
                          child: SizedBox(),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        _login();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "LOGIN",
                                              style: TextStyle(
                                                  fontSize: 30.0, fontFamily: 'BarlowCondensed', fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 5.0, offset: Offset(5.0, 5.0))],
                                          color: Color(0xFF1E1E28),
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(flex: 1, child: SizedBox()),
                              Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                          flex: 1,
                        ),
                        Expanded(
                          child: SizedBox(),
                          flex: 2,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    var data = {'username': username, 'password': password};

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      //print(localStorage.getKeys());
      localStorage.setString('token', json.encode(body['access_token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(context, MaterialPageRoute(builder: (context) => TrainerMode()));
    } else {
      _showMessage(body['message']);
    }
  }
}
