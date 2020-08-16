import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:probot/network/api.dart';
import 'package:probot/screens/trainer_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class NewLogin extends StatefulWidget {
  @override
  _NewLoginState createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  final _formKey = GlobalKey<FormState>();
  var username;
  var password;
  bool isValidedUsername = false;
  bool isValidedPassword = false;
  bool _obsecureText = true;
  bool _rememberMeCheck = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMessage(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(label: 'Close', onPressed: () {}),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void changeObsecureText() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
          color: Color(0xFF3FA9F5),
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  height: size.height / 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 30.0),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(fontSize: size.height * 0.08, color: Color(0xFF242432), fontFamily: 'Barlow', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: size.height / 2,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: size.width / 3,
                      ),
                      Container(
                        width: size.width / 2,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Username:",
                                  style: TextStyle(fontSize: size.height * 0.04, color: Color(0xFF1E1E28), fontFamily: 'BarlowCondensed'),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                width: size.width / 3,
                                child: TextFormField(
                                  style: TextStyle(fontSize: size.height * 0.06, color: Color(0xFF1E1E28)),
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (usernameValue) {
                                    if (usernameValue.isEmpty) {
                                      setState(() {
                                        isValidedUsername = false;
                                      });
                                    } else {
                                      setState(() {
                                        isValidedUsername = true;
                                      });
                                    }
                                    return null;
                                  },
                                  validator: (usernameValue) {
                                    if (usernameValue.isEmpty) {
                                      return null;
                                    }
                                    username = usernameValue;
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                child: Text(
                                  "Password:",
                                  style: TextStyle(fontSize: size.height * 0.04, color: Color(0xFF1E1E28), fontFamily: 'BarlowCondensed'),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: size.width / 3,
                                    child: TextFormField(
                                      style: TextStyle(fontSize: size.height * 0.06, color: Color(0xFF1E1E28)),
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            icon: Container(
                                              width: 30.0,
                                              child: Icon(
                                                FontAwesomeIcons.eye,
                                                size: 15.0,
                                                color: Color(0xff9999AC),
                                              ),
                                            ),
                                            onPressed: () {
                                              changeObsecureText();
                                            }),
                                        border: UnderlineInputBorder(borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      obscureText: _obsecureText,
                                      onChanged: (passwordValue) {
                                        if (passwordValue.isEmpty) {
                                          setState(() {
                                            isValidedPassword = false;
                                          });
                                        } else {
                                          setState(() {
                                            isValidedPassword = true;
                                          });
                                        }
                                        return null;
                                      },
                                      validator: (passwordValue) {
                                        if (passwordValue.isEmpty) {
                                          return null;
                                        }
                                        password = passwordValue;
                                        return null;
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (this.isValidedUsername && this.isValidedPassword) {
                                        if (_formKey.currentState.validate()) {
                                          _login();
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: Container(
                                        width: size.width * 0.12,
                                        height: size.height * 0.105,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "LOGIN",
                                              style: TextStyle(
                                                  fontSize: size.height * 0.05,
                                                  fontFamily: 'BarlowCondensed',
                                                  fontWeight: FontWeight.bold,
                                                  color: isValidedUsername && isValidedPassword ? Colors.white : Colors.white.withOpacity(0.32)),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: isValidedUsername && isValidedPassword
                                              ? [BoxShadow(color: Color(0xFF000000), blurRadius: 5.0, offset: Offset(5.0, 5.0))]
                                              : null,
                                          color: isValidedUsername && isValidedPassword ? Color(0xFF1E1E28) : Color(0xFF1E1E28).withOpacity(0.32),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                width: size.width / 3,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: SizedBox(
                                        height: 30.0,
                                        width: 30.0,
                                        child: Checkbox(
                                          onChanged: (newValue) {
                                            setState(() {
                                              _rememberMeCheck = newValue;
                                            });
                                          },
                                          value: _rememberMeCheck,
                                          activeColor: Colors.white,
                                          checkColor: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Remember Me",
                                        style: TextStyle(color: Colors.white, fontSize: size.height * 0.03, fontFamily: 'BarlowCondensed'),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          child: Text(
                                            "Forgot password?",
                                            style: TextStyle(color: Colors.white, fontSize: size.height * 0.03, fontFamily: 'BarlowCondensed'),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
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
