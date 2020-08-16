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
    double topScreenPadding = size.width < 850 ? size.width * 0.015 : size.width * 0.020;
    double backIconSize = size.width < 850 ? size.width * 0.04 : size.width * 0.05;
    double quickKickFontSize = size.width < 850 ? size.width * 0.04 : size.width * 0.06;
    double fontSizeSelectDifficulty = size.width < 850 ? size.width * 0.02 : size.width * 0.025;
    double selectBoxSize = size.width < 850 ? size.width * 0.065 : size.width * 0.08;
    double selectBoxIconSize = size.width < 850 ? size.width * 0.025 : size.width * 0.03;
    double selectBoxFontSize = size.width < 850 ? size.width * 0.025 : size.width * 0.03;
    double selectBoxArrowDownSize = size.width < 850 ? size.width * 0.025 : size.width * 0.03;
    double buttonPaddingRight = size.width < 850 ? size.width * 0.02 : size.width * 0.035;
    double buttonPaddingVertical = size.width < 850 ? size.width * 0.018 : size.width * 0.02;
    double buttonPaddingHorizontal = size.width < 850 ? size.width * 0.03 : size.width * 0.04;
    double startFontSize = size.width < 850 ? size.width * 0.025 : size.width * 0.03;
    double labelParams = size.width < 850 ? size.width * 0.02 : size.width * 0.025;
    double valueParams = size.width < 850 ? size.width * 0.025 : size.width * 0.03;
    double silueteSize = size.width < 850 ? size.width * 0.3 : size.width * 0.45;
    double numberFontSize = size.width < 850 ? size.width * 0.03 : size.width * 0.04;
    double detachedFontSize = size.width < 850 ? size.width * 0.015 : size.width * 0.022;
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: size.width / 3,
            color: Color(0xFF2D2D3C),
            child: Padding(
              padding: EdgeInsets.only(right: size.width * 0.015, top: topScreenPadding, left: size.width * 0.015, bottom: size.width * 0.015),
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
                          height: backIconSize,
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
                          style: TextStyle(fontSize: quickKickFontSize, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed', fontWeight: FontWeight.bold, height: 0.9),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width < 850 ? size.height * 0.15 : size.height * 0.15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Select difficulty:",
                          style: TextStyle(color: Color(0xFF464655), fontSize: fontSizeSelectDifficulty, fontFamily: 'BarlowCondensed'),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: selectBoxSize,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Padding(padding: EdgeInsets.only(left: size.width * 0.01), child: _difficultyItems(selectBoxIconSize, selectBoxFontSize))),
                              decoration: BoxDecoration(boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 5.0, offset: Offset(5.0, 5.0))], color: Color(0xFF464655)),
                            ),
                          ),
                          Container(
                            height: selectBoxSize,
                            color: Color(0xFF242432),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: selectBoxArrowDownSize,
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
                          padding: EdgeInsets.only(right: buttonPaddingRight),
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xFF3FA9F5), boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 8.0, offset: Offset(7.0, 7.0))]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: buttonPaddingVertical, horizontal: buttonPaddingHorizontal),
                              child: Text(
                                'START',
                                style: TextStyle(fontSize: startFontSize, color: Color(0xFF282832), fontWeight: FontWeight.bold, fontFamily: "BarlowCondensed"),
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
                  padding: EdgeInsets.only(top: topScreenPadding),
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
                                    style: TextStyle(color: Color(0xFF464655), fontSize: labelParams, fontFamily: "BarlowCondensed"),
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
                                    style: TextStyle(fontSize: valueParams, fontFamily: "BarlowCondensed"),
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
                                    style: TextStyle(color: Color(0xFF464655), fontSize: labelParams, fontFamily: "BarlowCondensed"),
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
                                    style: TextStyle(fontSize: valueParams, fontFamily: "BarlowCondensed"),
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
                                    style: TextStyle(color: Color(0xFF464655), fontSize: labelParams, fontFamily: "BarlowCondensed"),
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
                                    style: TextStyle(fontSize: valueParams, fontFamily: "BarlowCondensed"),
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
                          height: size.width < 850 ? size.width * 0.02 : size.width * 0.03,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(child: LayoutBuilder(
                            builder: (context, constraints) {
                              double width = constraints.maxWidth;
                              return QuickKickSiluete(
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
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          batteryLevelBoxHeight: size.width < 850 ? width * 0.47 : width * 0.6,
                                          batteryLevelBoxWidth: size.width < 850 ? width * 0.30 : width * 0.4,
                                          batteryIndicatorHeight: size.width < 850 ? width * 0.08 : width * 0.1,
                                          batteryIndicatorWidth: size.width < 850 ? width * 0.27 : width * 0.35,
                                          batteryLevelPositionBottom: size.width < 850 ? width * 0.15 : width * 0.25,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "1",
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          detachedPositionTop: size.width < 850 ? width * 0.4 : width * 0.6,
                                          detachedPositionRight: size.width < 850 ? width * 0.01 : width * 0.02,
                                          detachedFontSIze: detachedFontSize,
                                        ));
                            },
                          ))
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(child: LayoutBuilder(
                            builder: (context, constraints) {
                              double width = constraints.maxWidth;
                              return QuickKickSiluete(
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
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          batteryLevelBoxHeight: size.width < 850 ? width * 0.47 : width * 0.6,
                                          batteryLevelBoxWidth: size.width < 850 ? width * 0.30 : width * 0.4,
                                          batteryIndicatorHeight: size.width < 850 ? width * 0.08 : width * 0.1,
                                          batteryIndicatorWidth: size.width < 850 ? width * 0.27 : width * 0.35,
                                          batteryLevelPositionBottom: size.width < 850 ? width * 0.15 : width * 0.25,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "2",
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          detachedPositionTop: size.width < 850 ? width * 0.4 : width * 0.6,
                                          detachedPositionRight: size.width < 850 ? width * 0.01 : width * 0.02,
                                          detachedFontSIze: detachedFontSize,
                                        ));
                            },
                          ))
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(child: LayoutBuilder(
                            builder: (context, constraints) {
                              double width = constraints.maxWidth;
                              return QuickKickSiluete(
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
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          batteryLevelBoxHeight: size.width < 850 ? width * 0.47 : width * 0.6,
                                          batteryLevelBoxWidth: size.width < 850 ? width * 0.30 : width * 0.4,
                                          batteryIndicatorHeight: size.width < 850 ? width * 0.08 : width * 0.1,
                                          batteryIndicatorWidth: size.width < 850 ? width * 0.27 : width * 0.35,
                                          batteryLevelPositionBottom: size.width < 850 ? width * 0.15 : width * 0.25,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "3",
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          detachedPositionTop: size.width < 850 ? width * 0.4 : width * 0.6,
                                          detachedPositionRight: size.width < 850 ? width * 0.01 : width * 0.02,
                                          detachedFontSIze: detachedFontSize,
                                        ));
                            },
                          ))
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(child: LayoutBuilder(
                            builder: (context, constraints) {
                              double width = constraints.maxWidth;
                              return QuickKickSiluete(
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
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          batteryLevelBoxHeight: size.width < 850 ? width * 0.47 : width * 0.6,
                                          batteryLevelBoxWidth: size.width < 850 ? width * 0.30 : width * 0.4,
                                          batteryIndicatorHeight: size.width < 850 ? width * 0.08 : width * 0.1,
                                          batteryIndicatorWidth: size.width < 850 ? width * 0.27 : width * 0.35,
                                          batteryLevelPositionBottom: size.width < 850 ? width * 0.15 : width * 0.25,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "4",
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          detachedPositionTop: size.width < 850 ? width * 0.4 : width * 0.6,
                                          detachedPositionRight: size.width < 850 ? width * 0.01 : width * 0.02,
                                          detachedFontSIze: detachedFontSize,
                                        ));
                            },
                          ))
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(child: LayoutBuilder(
                            builder: (context, constraints) {
                              double width = constraints.maxWidth;
                              return QuickKickSiluete(
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
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          batteryLevelBoxHeight: size.width < 850 ? width * 0.47 : width * 0.6,
                                          batteryLevelBoxWidth: size.width < 850 ? width * 0.30 : width * 0.4,
                                          batteryIndicatorHeight: size.width < 850 ? width * 0.08 : width * 0.1,
                                          batteryIndicatorWidth: size.width < 850 ? width * 0.27 : width * 0.35,
                                          batteryLevelPositionBottom: size.width < 850 ? width * 0.15 : width * 0.25,
                                        )
                                      : InactiveSiluete(
                                          image: kInactiveSiluete,
                                          number: "5",
                                          silueteSize: silueteSize,
                                          numberPositionBottom: size.width < 850 ? width * -0.7 : width * -1.1,
                                          numberFontSize: numberFontSize,
                                          detachedPositionTop: size.width < 850 ? width * 0.4 : width * 0.6,
                                          detachedPositionRight: size.width < 850 ? width * 0.01 : width * 0.02,
                                          detachedFontSIze: detachedFontSize,
                                        ));
                            },
                          ))
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
