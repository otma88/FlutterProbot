import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'countries.dart';
import 'clubs.dart';
import 'quick_kick_siluete.dart';
import 'inactive_siluete.dart';
import 'active_siluete_quick_kick.dart';
import 'active_siluete_duel_designer.dart';
import 'start_button.dart';
import 'constants.dart';

class DuelDesigner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DuelDesignerPage(),
    );
  }
}

class DuelDesignerPage extends StatefulWidget {
  @override
  _DuelDesignerPageState createState() => _DuelDesignerPageState();
}

class _DuelDesignerPageState extends State<DuelDesignerPage> {
  List<Country> _countries = Country.getCountries();
  List<DropdownMenuItem<Country>> _dropdownCountryItems;
  Country _selectedCountry;

  List<Club> _clubs = Club.getClubs();
  List<DropdownMenuItem<Club>> _dropdownClubItems;
  Club _selectedClub;

  bool isActiveSiluete1;
  bool isActiveSiluete2;
  bool isActiveSiluete3;
  bool isActiveSiluete4;
  bool isActiveSiluete5;

  @override
  void initState() {
    _dropdownCountryItems = buildDropdownCountryItems(_countries);
    _selectedCountry = _dropdownCountryItems[0].value;
    _dropdownClubItems = buildDropdownClubItems(_clubs);
    _selectedClub = _dropdownClubItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Country>> buildDropdownCountryItems(List countries) {
    List<DropdownMenuItem<Country>> items = List();
    for (Country country in countries) {
      items.add(
        DropdownMenuItem(
          value: country,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('images/croatia-flag.png'),
              SizedBox(
                width: 10.0,
              ),
              Text(country.name)
            ],
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Club>> buildDropdownClubItems(List clubs) {
    List<DropdownMenuItem<Club>> items = List();
    for (Club club in clubs) {
      items.add(DropdownMenuItem(
        value: club,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'images/dinamo.jpg',
              height: 20.0,
              width: 20.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(club.name),
          ],
        ),
      ));
    }
    return items;
  }

  onChangeCountryItem(Country selectedCountry) {
    setState(() {
      _selectedCountry = selectedCountry;
    });
  }

  onChangeClubItem(Club selectedClub) {
    setState(() {
      _selectedClub = selectedClub;
    });
  }

  DropdownButton _selectLegaue() => DropdownButton<Country>(
        underline: SizedBox(),
        icon: SizedBox(),
        items: buildDropdownCountryItems(_countries),
        onChanged: onChangeCountryItem,
        value: _selectedCountry,
        isExpanded: true,
        elevation: 6,
        style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'BarlowCondensed',
            color: Color(0xFF9999AC)),
      );

  DropdownButton _selectClub() => DropdownButton<Club>(
        underline: SizedBox(),
        icon: SizedBox(),
        items: buildDropdownClubItems(_clubs),
        onChanged: onChangeClubItem,
        value: _selectedClub,
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
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 70.0),
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
                                  "DUEL DESIGNER",
                                  style: TextStyle(
                                    fontSize: 70.0,
                                    height: 1,
                                    color: Color(0xFF9999AC),
                                    fontFamily: 'BarlowCondensed',
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                                child: Text(
                                  "Select opponent:",
                                  style: TextStyle(
                                      color: Color(0xFF464655),
                                      fontSize: 18.0,
                                      fontFamily: 'BarlowCondensed'),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          10.0, 7.0, 5.0, 7.0),
                                      child: Container(child: _selectLegaue()),
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
                              SizedBox(
                                height: 17.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          10.0, 7.0, 5.0, 7.0),
                                      child: Container(child: _selectClub()),
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
                              SizedBox(
                                height: 17.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 24.0, 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'LOAD',
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Color(0xFF9999AC),
                                                      fontFamily:
                                                          'BarlowCondensed'),
                                                ),
                                                Text('SAVED PRESET',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color:
                                                            Color(0xFF9999AC),
                                                        fontFamily:
                                                            'BarlowCondensed'))
                                              ],
                                            ),
                                          ),
                                        ),
                                        color: Color(0xFF242432),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 17.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 24.0, 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'SAVE',
                                                  style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Color(0xFF9999AC),
                                                      fontFamily:
                                                          'BarlowCondensed'),
                                                ),
                                                Text('THIS SETUP',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color:
                                                            Color(0xFF9999AC),
                                                        fontFamily:
                                                            'BarlowCondensed'))
                                              ],
                                            ),
                                          ),
                                        ),
                                        color: Color(0xFF242432),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                        child: StartButton(
                                            onTap: null, buttonTitle: "START"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
//                        Expanded(
//                            child: Align(
//                          alignment: FractionalOffset.bottomRight,
//                          child: Padding(
//                            padding: const EdgeInsets.all(40.0),
//                            child: RaisedButton(
//                              padding: EdgeInsets.all(0.0),
//                              onPressed: null,
//                              child: Container(
//                                padding: EdgeInsets.all(20.0),
//                                decoration: BoxDecoration(
//                                    color: Color(0xFF3FA9F5),
//                                    boxShadow: [
//                                      BoxShadow(
//                                          color: Color(0xFF000000),
//                                          blurRadius: 8.0,
//                                          offset: Offset(7.0, 7.0))
//                                    ]),
//                                child: Text(
//                                  'START',
//                                  style: TextStyle(
//                                      fontSize: 30.0,
//                                      color: Color(0xFF282832),
//                                      fontWeight: FontWeight.bold),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ))
                      ],
                    ),
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Color(0xFF191926),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 50.0, 0.0, 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.arrow_upward,
                                                size: 30.0,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "183 cm",
                                                style: kPlayerParamTextStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "190 cm",
                                                style: kPlayerParamTextStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "183 cm",
                                                style: kPlayerParamTextStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              kPlayerParamDisabled
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              kPlayerParamDisabled
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.accessibility_new,
                                                size: 30.0,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "45 cm",
                                                style: kPlayerParamTextStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "40 cm",
                                                style: kPlayerParamTextStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "48 cm",
                                                style: kPlayerParamTextStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              kPlayerParamDisabled
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              kPlayerParamDisabled
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Icon(
                                    FontAwesomeIcons.caretDown,
                                    color: Color(0xFF191926),
                                    size: 60.0,
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Icon(
                                    FontAwesomeIcons.caretDown,
                                    color: Color(0xFF191926),
                                    size: 60.0,
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Icon(
                                    FontAwesomeIcons.caretDown,
                                    color: Color(0xFF191926),
                                    size: 60.0,
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Icon(
                                    FontAwesomeIcons.caretDown,
                                    color: Color(0xFF191926),
                                    size: 60.0,
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Icon(
                                    FontAwesomeIcons.caretDown,
                                    color: Color(0xFF191926),
                                    size: 60.0,
                                  ),
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 60.0),
                                          child: Icon(
                                            FontAwesomeIcons.user,
                                            color: Color(0xFF464655),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 250,
                                        ),
                                        Icon(
                                          Icons.battery_full,
                                          color: Color(0xFF464655),
                                        )
                                      ],
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                            child: QuickKickSiluete(
                                                onPress: () {
                                                  setState(() {
                                                    isActiveSiluete1 == false
                                                        ? isActiveSiluete1 =
                                                            true
                                                        : isActiveSiluete1 =
                                                            false;
                                                  });
                                                },
                                                siluete: isActiveSiluete1 ==
                                                        true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "1",
                                                        batteryLevel: 1,
                                                        numAndEmptyIndicatorColor:
                                                            emptyIndicatorDD,
                                                        playerName: "SILVA",
                                                        playerNumber: "2",
                                                        kragna:
                                                            Color(0xFFFF0000),
                                                        shirtColor:
                                                            Color(0xFF243479),
                                                        playerNameColor:
                                                            Colors.white,
                                                        playerNumberColor:
                                                            Color(0xFFFF0000),
                                                        playerNumberStrokeColor:
                                                            Colors.white,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                            child: QuickKickSiluete(
                                                onPress: () {
                                                  setState(() {
                                                    isActiveSiluete2 == false
                                                        ? isActiveSiluete2 =
                                                            true
                                                        : isActiveSiluete2 =
                                                            false;
                                                  });
                                                },
                                                siluete: isActiveSiluete2 ==
                                                        true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "2",
                                                        batteryLevel: 2,
                                                        numAndEmptyIndicatorColor:
                                                            emptyIndicatorDD,
                                                        playerName: "MEUNIER",
                                                        playerNumber: "12",
                                                        kragna:
                                                            Color(0xFFFF0000),
                                                        shirtColor:
                                                            Color(0xFF243479),
                                                        playerNameColor:
                                                            Colors.white,
                                                        playerNumberColor:
                                                            Color(0xFFFF0000),
                                                        playerNumberStrokeColor:
                                                            Colors.white,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                            child: QuickKickSiluete(
                                                onPress: () {
                                                  setState(() {
                                                    isActiveSiluete3 == false
                                                        ? isActiveSiluete3 =
                                                            true
                                                        : isActiveSiluete3 =
                                                            false;
                                                  });
                                                },
                                                siluete: isActiveSiluete3 ==
                                                        true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "3",
                                                        batteryLevel: 3,
                                                        numAndEmptyIndicatorColor:
                                                            emptyIndicatorDD,
                                                        playerName: "KIMPEMBE",
                                                        playerNumber: "4",
                                                        kragna:
                                                            Color(0xFFFF0000),
                                                        shirtColor:
                                                            Color(0xFF243479),
                                                        playerNameColor:
                                                            Colors.white,
                                                        playerNumberColor:
                                                            Color(0xFFFF0000),
                                                        playerNumberStrokeColor:
                                                            Colors.white,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                            child: QuickKickSiluete(
                                                onPress: () {
                                                  setState(() {
                                                    isActiveSiluete4 == false
                                                        ? isActiveSiluete4 =
                                                            true
                                                        : isActiveSiluete4 =
                                                            false;
                                                  });
                                                },
                                                siluete: isActiveSiluete4 ==
                                                        true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "4",
                                                        batteryLevel: 4,
                                                        numAndEmptyIndicatorColor:
                                                            emptyIndicatorDD,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                            child: QuickKickSiluete(
                                                onPress: () {
                                                  setState(() {
                                                    isActiveSiluete5 == false
                                                        ? isActiveSiluete5 =
                                                            true
                                                        : isActiveSiluete5 =
                                                            false;
                                                  });
                                                },
                                                siluete: isActiveSiluete5 ==
                                                        true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "5",
                                                        batteryLevel: 4,
                                                        numAndEmptyIndicatorColor:
                                                            emptyIndicatorDD,
                                                      )
                                                    : InactiveSiluete(
                                                        image: kInactiveSiluete,
                                                        number: "5",
                                                      )))
                                      ],
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 120.0, right: 57.0),
                                child: Container(
                                    child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: SizedBox(
                                        width: 100,
                                        height: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF9999AC)),
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF9999AC)))),
                                    ),
                                    Container(
                                        child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            FontAwesomeIcons.exchangeAlt,
                                            color: Color(0xFF9999AC),
                                          ),
                                        ),
                                        Text(
                                          'tap on player to SUBSTITUTE',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Color(0xFF9999AC)),
                                        ),
                                      ],
                                    )),
                                    Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      child: SizedBox(
                                        width: 92,
                                        height: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF9999AC)),
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF9999AC)))),
                                    ),
                                  ],
                                )),
                              ))
                        ],
                      ),
                    ),
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
