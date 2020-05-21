import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:probot/custom_icons/test_sheet_icons_icons.dart';
import 'package:probot/widgets/check_auth.dart';
import 'package:probot/screens/duel_designer.dart';
import 'package:probot/screens/login.dart';
import 'package:probot/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/menu_card.dart';
import '../widgets/card_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../custom_icons/probot_icons_icons.dart';
import '../custom_icons/probot_params_icons.dart';
import 'quick_kick.dart';
import 'package:flutter/services.dart';

const cardColor = Color(0xFF464655);

class TrainerMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff2D2D3C),
        scaffoldBackgroundColor: Color(0xff2D2D3C),
      ),
      home: TrainerModePage(title: 'TRAINER MODE'),
    );
  }
}

class TrainerModePage extends StatefulWidget {
  TrainerModePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TrainerModePageState createState() => _TrainerModePageState();
}

class _TrainerModePageState extends State<TrainerModePage> {
  String name;

  @override
  void initState() {
    getUserData();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/logo_shadow.png'),
          fit: BoxFit.fill,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 20.0, 2.0, 2.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 50.0,
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                        ),
                        onPressed: () {
                          logout();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Text(
                        'TRAINER MODE',
                        style: TextStyle(fontSize: 55.0, fontFamily: 'Barlow', color: Color(0xFF191926), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "PROBOT",
                            style: TextStyle(fontSize: 25.0, color: Colors.white),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Icon(
                          Icons.dehaze,
                          size: 50.0,
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                        ),
                      ))
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuickKickPage()));
                      },
                      child: MenuCard(
                        colour: cardColor,
                        cardChild: CardContent(label: "QUICK KICK", icon: ProbotIcons.ball),
                        description: 'Fully automated, hassle free practice.',
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {},
                      child: MenuCard(
                        colour: cardColor,
                        cardChild: CardContent(
                          label: "PLAYERS",
                          icon: ProbotIcons.trophy,
                        ),
                        description: "Add players.",
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DuelDesignerPage()));
                      },
                      child: MenuCard(
                        colour: cardColor,
                        cardChild: CardContent(
                          label: "DUEL DESIGNER",
                          icon: ProbotIcons.params,
                        ),
                        description: "Practice against designated opponent.",
                      ),
                    ))
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void logout() async {
    var res = await Network().getData("/logout");
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuth()));
    }
  }

  void getUserData() async {
    var res = await Network().getData("/user");
    var user = jsonDecode(res.body);

    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }
}
