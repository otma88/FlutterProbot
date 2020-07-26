import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:probot/widgets/active_siluete_quick_kick.dart';
import 'package:probot/widgets/inactive_siluete.dart';
import 'package:probot/widgets/quick_kick_siluete.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class QuickKick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuickKickPage(),
    );
  }
}

class QuickKickPage extends StatefulWidget {
  @override
  _QuickKickPageState createState() => _QuickKickPageState();
}

String dropdownValue = 'EASY';

class _QuickKickPageState extends State<QuickKickPage> {
  var _value = "1";
  bool isActiveSiluete1;
  bool isActiveSiluete2;
  bool isActiveSiluete3;
  bool isActiveSiluete4;
  bool isActiveSiluete5;
  String labelPlayerHeight = heightEasy;
  String labelJumpHeight = jumpEasy;
  String labelJumpOccurrence = occurrenceEasy;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    isActiveSiluete1 = false;
    isActiveSiluete2 = false;
    isActiveSiluete3 = false;
    isActiveSiluete4 = false;
    isActiveSiluete5 = false;
  }

  DropdownButton _difficultyItems(double iconSize, double fontSize) => DropdownButton<String>(
        underline: SizedBox(),
        icon: SizedBox(),
        items: [
          DropdownMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/icons/difficulty_easy.png',
                  height: iconSize,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "EASY",
                )
              ],
            ),
            value: "1",
          ),
          DropdownMenuItem(
            value: "2",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/icons/difficulty_medium.png',
                  height: iconSize,
                ),
                SizedBox(width: 10.0),
                Text(
                  "MEDIUM",
                )
              ],
            ),
          ),
          DropdownMenuItem(
            value: "3",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/icons/difficulty_hard.png',
                  height: iconSize,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "HARD",
                )
              ],
            ),
          )
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
            if (_value == "1") {
              labelPlayerHeight = heightEasy;
              labelJumpHeight = jumpEasy;
              labelJumpOccurrence = occurrenceEasy;
            } else if (_value == "2") {
              labelPlayerHeight = heightMedium;
              labelJumpHeight = jumpMedium;
              labelJumpOccurrence = occurrenceMedium;
            } else if (_value == "3") {
              labelPlayerHeight = heightHard;
              labelJumpHeight = jumpHard;
              labelJumpOccurrence = occurrenceHard;
            }
          });
        },
        value: _value,
        isExpanded: true,
        elevation: 6,
        style: TextStyle(fontSize: fontSize, fontFamily: 'BarlowCondensed', color: Color(0xFF9999AC)),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: size.width / 3,
            color: Color(0xFF2D2D3C),
            child: Padding(
              padding: EdgeInsets.only(right: size.width * 0.02, top: size.height * 0.025, left: size.width * 0.025, bottom: size.height * 0.025),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "images/icons/back.png",
                          height: size.height * 0.07,
                          color: Color(0xFF9999AC),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Container(
                        width: size.width * 0.21,
                        child: Text(
                          "QUICK KICK",
                          style: TextStyle(
                              fontSize: size.height * 0.08,
                              color: Color(0xFF9999AC),
                              fontFamily: 'BarlowCondensed',
                              fontWeight: FontWeight.bold,
                              height: 0.9),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Select difficulty:",
                          style: TextStyle(color: Color(0xFF464655), fontSize: size.height * 0.03, fontFamily: 'BarlowCondensed'),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: size.height * 0.12,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: size.width * 0.01),
                                      child: _difficultyItems(size.height * 0.06, size.height * 0.05))),
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 5.0, offset: Offset(5.0, 5.0))],
                                  color: Color(0xFF464655)),
                            ),
                          ),
                          Container(
                            height: size.height * 0.12,
                            color: Color(0xFF242432),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: size.height * 0.05,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.33,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.035),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF3FA9F5),
                                boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 8.0, offset: Offset(7.0, 7.0))]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.03, horizontal: size.width * 0.04),
                              child: Text(
                                'START',
                                style: TextStyle(
                                    fontSize: size.height * 0.05,
                                    color: Color(0xFF282832),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "BarlowCondensed"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 2 / 3,
            color: Color(0xFF242432),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Player height:",
                                    style: TextStyle(color: Color(0xFF464655), fontSize: size.height * 0.035, fontFamily: "BarlowCondensed"),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    labelPlayerHeight,
                                    style: TextStyle(fontSize: size.height * 0.045, fontFamily: "BarlowCondensed"),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              )
                            ],
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Jump height:",
                                    style: TextStyle(color: Color(0xFF464655), fontSize: size.height * 0.035, fontFamily: "BarlowCondensed"),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    labelJumpHeight,
                                    style: TextStyle(fontSize: size.height * 0.045, fontFamily: "BarlowCondensed"),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              )
                            ],
                          )
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Jump occurrence:",
                                    style: TextStyle(color: Color(0xFF464655), fontSize: size.height * 0.035, fontFamily: "BarlowCondensed"),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    labelJumpOccurrence,
                                    style: TextStyle(fontSize: size.height * 0.045, fontFamily: "BarlowCondensed"),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.06),
                        child: Image.asset(
                          'images/icons/batt.png',
                          height: size.height * 0.05,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: QuickKickSiluete(
                                  onPress: () {
                                    setState(() {
                                      isActiveSiluete1 == false ? isActiveSiluete1 = true : isActiveSiluete1 = false;
                                    });
                                  },
                                  siluete: isActiveSiluete1 == true
                                      ? ActiveSilueteQuickKick(
                                          image: kQKActiveSiluete,
                                          number: "1",
                                          batteryLevel: 1,
                                          numAndEmptyIndicatorColor: emptyIndicatorQK,
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          batteryLevelBoxHeight: size.height * 0.1,
                                          batteryLevelBoxWidth: size.width * 0.04,
                                          batteryIndicatorHeight: size.height * 0.017,
                                          batteryIndicatorWidth: size.width * 0.036,
                                          batteryLevelPositionBottom: size.height * -0.43,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "1",
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          detachedPositionTop: size.height * 0.1,
                                          detachedPositionLeft: size.width * 0.012,
                                          detachedFontSIze: size.height * 0.032,
                                        )))
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: QuickKickSiluete(
                                  onPress: () {
                                    setState(() {
                                      isActiveSiluete2 == false ? isActiveSiluete2 = true : isActiveSiluete2 = false;
                                    });
                                  },
                                  siluete: isActiveSiluete2 == true
                                      ? ActiveSilueteQuickKick(
                                          image: kQKActiveSiluete,
                                          number: "2",
                                          batteryLevel: 2,
                                          numAndEmptyIndicatorColor: emptyIndicatorQK,
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          batteryLevelBoxHeight: size.height * 0.1,
                                          batteryLevelBoxWidth: size.width * 0.04,
                                          batteryIndicatorHeight: size.height * 0.017,
                                          batteryIndicatorWidth: size.width * 0.036,
                                          batteryLevelPositionBottom: size.height * -0.43,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "2",
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          detachedPositionTop: size.height * 0.1,
                                          detachedPositionLeft: size.width * 0.012,
                                          detachedFontSIze: size.height * 0.032,
                                        )))
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: QuickKickSiluete(
                                  onPress: () {
                                    setState(() {
                                      isActiveSiluete3 == false ? isActiveSiluete3 = true : isActiveSiluete3 = false;
                                    });
                                  },
                                  siluete: isActiveSiluete3 == true
                                      ? ActiveSilueteQuickKick(
                                          image: kQKActiveSiluete,
                                          number: "3",
                                          batteryLevel: 3,
                                          numAndEmptyIndicatorColor: emptyIndicatorQK,
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          batteryLevelBoxHeight: size.height * 0.1,
                                          batteryLevelBoxWidth: size.width * 0.04,
                                          batteryIndicatorHeight: size.height * 0.017,
                                          batteryIndicatorWidth: size.width * 0.036,
                                          batteryLevelPositionBottom: size.height * -0.43,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "3",
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          detachedPositionTop: size.height * 0.1,
                                          detachedPositionLeft: size.width * 0.012,
                                          detachedFontSIze: size.height * 0.032,
                                        )))
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: QuickKickSiluete(
                                  onPress: () {
                                    setState(() {
                                      isActiveSiluete4 == false ? isActiveSiluete4 = true : isActiveSiluete4 = false;
                                    });
                                  },
                                  siluete: isActiveSiluete4 == true
                                      ? ActiveSilueteQuickKick(
                                          image: kQKActiveSiluete,
                                          number: "4",
                                          batteryLevel: 4,
                                          numAndEmptyIndicatorColor: emptyIndicatorQK,
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          batteryLevelBoxHeight: size.height * 0.1,
                                          batteryLevelBoxWidth: size.width * 0.04,
                                          batteryIndicatorHeight: size.height * 0.017,
                                          batteryIndicatorWidth: size.width * 0.036,
                                          batteryLevelPositionBottom: size.height * -0.43,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "4",
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          detachedPositionTop: size.height * 0.1,
                                          detachedPositionLeft: size.width * 0.012,
                                          detachedFontSIze: size.height * 0.032,
                                        )))
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: QuickKickSiluete(
                                  onPress: () {
                                    setState(() {
                                      isActiveSiluete5 == false ? isActiveSiluete5 = true : isActiveSiluete5 = false;
                                    });
                                  },
                                  siluete: isActiveSiluete5 == true
                                      ? ActiveSilueteQuickKick(
                                          image: kQKActiveSiluete,
                                          number: "5",
                                          batteryLevel: 4,
                                          numAndEmptyIndicatorColor: emptyIndicatorQK,
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          batteryLevelBoxHeight: size.height * 0.1,
                                          batteryLevelBoxWidth: size.width * 0.04,
                                          batteryIndicatorHeight: size.height * 0.017,
                                          batteryIndicatorWidth: size.width * 0.036,
                                          batteryLevelPositionBottom: size.height * -0.43,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "5",
                                          silueteSize: size.height * 0.62,
                                          numberPositionBottom: size.height * -0.17,
                                          numberFontSize: size.height * 0.06,
                                          detachedPositionTop: size.height * 0.1,
                                          detachedPositionLeft: size.width * 0.012,
                                          detachedFontSIze: size.height * 0.032,
                                        )))
                        ],
                      ),
                      flex: 2,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
