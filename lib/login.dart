import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probot/network/api.dart';
import 'package:probot/trainer_mode.dart';
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
      key: _scaffoldKey,
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
                    style: TextStyle(fontSize: 50.0, color: Color(0xFF242432)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 280,
            ),
            Row(
              children: <Widget>[
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                                child: Text(
                              "User name:",
                              style: TextStyle(fontSize: 20, color: Color(0xFF1E1E28)),
                            )),
                          ),
                          Container(
                            width: 350,
                            child: TextFormField(
                              style: TextStyle(fontSize: 30, color: Color(0xFF1E1E28)),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (usernameValue) {
                                if (usernameValue.isEmpty) {
                                  return 'Please enter username';
                                }
                                username = usernameValue;
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 20),
                            child: Text(
                              "Password:",
                              style: TextStyle(fontSize: 20, color: Color(0xFF1E1E28)),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 350,
                                child: TextFormField(
                                  obscureText: true,
                                  style: TextStyle(fontSize: 30, color: Color(0xFF1E1E28)),
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                                      contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                                      filled: true,
                                      fillColor: Colors.white),
                                  validator: (passwordValue) {
                                    if (passwordValue.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    password = passwordValue;
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              FlatButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _login();
                                    }
                                  },
                                  color: Color(0xFF1E1E28),
                                  textColor: Colors.white,
                                  padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(fontSize: 30.0),
                                  ))
//                          GestureDetector(
//                            onTap: null,
//                            child: Container(
//                              padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
//                              decoration: BoxDecoration(color: Color(0xFF1E1E28), boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 8.0, offset: Offset(7.0, 7.0))]),
//                              child: Center(
//                                child: Text(
//                                  "LOGIN",
//                                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 30.0),
//                                ),
//                              ),
//                            ),
//                          )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
                                  padding: EdgeInsets.all(15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Remember me",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "Forgot password?",
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    var data = {'email': username, 'password': password};

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
