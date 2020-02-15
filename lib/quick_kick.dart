import 'package:flutter/material.dart';
import 'package:probot/active_siluete_quick_kick.dart';
import 'package:probot/inactive_siluete.dart';
import 'package:probot/quick_kick_siluete.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

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

  DropdownButton _difficultyItems() => DropdownButton<String>(
        underline: SizedBox(),
        icon: SizedBox(),
        items: [
          DropdownMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.star_border,
                  color: Color(0xFF3FA9F5),
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
                Icon(
                  Icons.star_half,
                  color: Color(0xFF3FA9F5),
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
                Icon(
                  Icons.star,
                  color: Color(0xFF3FA9F5),
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
        style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'BarlowCondensed',
            color: Color(0xFF9999AC)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 2.0, 2.0),
                child: Container(
                  color: Color(0xFF2D2D3C),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 80.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 50.0,
                                  color: Color(0xFF9999AC),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            SizedBox(
                              width: 20.0,
                            ),
                            Flexible(
                              child: Text(
                                "QUICK KICK",
                                style: TextStyle(
                                    fontSize: 70.0,
                                    height: 1,
                                    color: Color(0xFF9999AC),
                                    fontFamily: 'BarlowCondensed',
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 20.0, 15.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Select difficulty:",
                                style: TextStyle(
                                    color: Color(0xFF464655),
                                    fontSize: 18.0,
                                    fontFamily: 'BarlowCondensed'),
                              ),
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 7.0, 5.0, 7.0),
                                    //color: Color(0xFF464655),
                                    child: Container(child: _difficultyItems()),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF000000),
                                          blurRadius: 5.0,
                                          offset: Offset(5.0, 5.0))
                                    ], color: Color(0xFF464655)),
                                  ),
                                ),
                                Container(
                                  height: 63.0,
                                  color: Color(0xFF242432),
                                  child: Icon(Icons.keyboard_arrow_down),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: RaisedButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: null,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF3FA9F5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF000000),
                                          blurRadius: 8.0,
                                          offset: Offset(7.0, 7.0))
                                    ]),
                                child: Text(
                                  'START',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Color(0xFF282832),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                padding: EdgeInsets.all(20.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Color(0xFF242432),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 50.0),
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
                                        style: TextStyle(
                                            color: Color(0xFF464655),
                                            fontSize: 20.0),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        labelPlayerHeight,
                                        style: TextStyle(fontSize: 20.0),
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
                                        style: TextStyle(
                                            color: Color(0xFF464655),
                                            fontSize: 20.0),
                                      )
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        labelJumpHeight,
                                        style: TextStyle(fontSize: 20.0),
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
                                        style: TextStyle(
                                            color: Color(0xFF464655),
                                            fontSize: 20.0),
                                      )
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        labelJumpOccurrence,
                                        style: TextStyle(fontSize: 20.0),
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
                      height: 100.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 300,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.battery_full,
                                          color: Color(0xFF464655),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
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
                                          isActiveSiluete1 == false
                                              ? isActiveSiluete1 = true
                                              : isActiveSiluete1 = false;
                                        });
                                      },
                                      siluete: isActiveSiluete1 == true
                                          ? ActiveSilueteQuickKick(
                                              image: kQKActiveSiluete,
                                              number: "1",
                                              batteryLevel: 1,
                                              numAndEmptyIndicatorColor:
                                                  emptyIndicatorQK,
                                            )
                                          : InactiveSiluete(
                                              image: kInactiveSiluete,
                                              number: "1",
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
                                          isActiveSiluete2 == false
                                              ? isActiveSiluete2 = true
                                              : isActiveSiluete2 = false;
                                        });
                                      },
                                      siluete: isActiveSiluete2 == true
                                          ? ActiveSilueteQuickKick(
                                              image: kQKActiveSiluete,
                                              number: "2",
                                              batteryLevel: 2,
                                              numAndEmptyIndicatorColor:
                                                  emptyIndicatorQK,
                                            )
                                          : InactiveSiluete(
                                              image: kInactiveSiluete,
                                              number: "2",
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
                                          isActiveSiluete3 == false
                                              ? isActiveSiluete3 = true
                                              : isActiveSiluete3 = false;
                                        });
                                      },
                                      siluete: isActiveSiluete3 == true
                                          ? ActiveSilueteQuickKick(
                                              image: kQKActiveSiluete,
                                              number: "3",
                                              batteryLevel: 3,
                                              numAndEmptyIndicatorColor:
                                                  emptyIndicatorQK,
                                            )
                                          : InactiveSiluete(
                                              image: kInactiveSiluete,
                                              number: "3",
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
                                          isActiveSiluete4 == false
                                              ? isActiveSiluete4 = true
                                              : isActiveSiluete4 = false;
                                        });
                                      },
                                      siluete: isActiveSiluete4 == true
                                          ? ActiveSilueteQuickKick(
                                              image: kQKActiveSiluete,
                                              number: "4",
                                              batteryLevel: 4,
                                              numAndEmptyIndicatorColor:
                                                  emptyIndicatorQK,
                                            )
                                          : InactiveSiluete(
                                              image: kInactiveSiluete,
                                              number: "4",
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
                                          isActiveSiluete5 == false
                                              ? isActiveSiluete5 = true
                                              : isActiveSiluete5 = false;
                                        });
                                      },
                                      siluete: isActiveSiluete5 == true
                                          ? ActiveSilueteQuickKick(
                                              image: kQKActiveSiluete,
                                              number: "5",
                                              batteryLevel: 4,
                                              numAndEmptyIndicatorColor:
                                                  emptyIndicatorQK,
                                            )
                                          : InactiveSiluete(
                                              image: kInactiveSiluete,
                                              number: "5",
                                            )))
                            ],
                          ),
                          flex: 2,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
