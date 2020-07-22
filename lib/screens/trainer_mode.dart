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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/logo_shadow.png'),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: size.height * 0.01, top: size.height * 0.02),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          logout();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'images/icons/logout.png',
                          height: size.height * 0.07,
                        ),
                      ),
                    )),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'TRAINER MODE',
                            style: TextStyle(fontSize: size.height * 0.1, fontFamily: 'Barlow', color: Color(0xFF191926), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: size.width * 0.005,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Image.asset(
                              'images/icons/role.png',
                              height: size.height * 0.05,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.005,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Probot",
                              style: TextStyle(fontSize: size.height * 0.04, color: Color(0xff9999AC)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Image.asset(
                        'images/icons/menu.png',
                        height: size.height * 0.07,
                      )))
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                  child: Text(
                    "Fully automated, hassle free practice.",
                    style: TextStyle(color: Color(0xFF464655), fontSize: size.height * 0.033, fontFamily: "BarlowCondensed"),
                  ),
                )),
                Expanded(
                    child: Container(
                  child: Text(
                    "Add players.",
                    style: TextStyle(color: Color(0xFF464655), fontSize: size.height * 0.033, fontFamily: "BarlowCondensed"),
                  ),
                )),
                Expanded(
                    child: Container(
                  child: Text(
                    "Practice against designated opponent.",
                    style: TextStyle(color: Color(0xFF464655), fontSize: size.height * 0.033, fontFamily: "BarlowCondensed"),
                  ),
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuickKickPage()));
                  },
                  child: MenuCard(
                    colour: cardColor,
                    cardChild: CardContent(
                      label: "QUICK KICK",
                      icon: 'images/icons/quick_kick.png',
                      fontSizeTitle: size.height * 0.06,
                      iconSize: size.height * 0.15,
                      paddingCard: size.height * 0.02,
                      cardHeight: size.height * 0.3,
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: MenuCard(
                    colour: cardColor,
                    cardChild: CardContent(
                      label: "PLAYERS",
                      icon: 'images/icons/season_shootout.png',
                      fontSizeTitle: size.height * 0.06,
                      iconSize: size.height * 0.15,
                      paddingCard: size.height * 0.02,
                      cardHeight: size.height * 0.3,
                    ),
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
                      icon: 'images/icons/duel_designer.png',
                      fontSizeTitle: size.height * 0.06,
                      iconSize: size.height * 0.15,
                      paddingCard: size.height * 0.02,
                      cardHeight: size.height * 0.3,
                    ),
                  ),
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
