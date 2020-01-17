import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'countries.dart';
import 'clubs.dart';

const kPlayerParamTextStyle =
    TextStyle(fontFamily: 'BarlowCondensed', fontSize: 30.0);

const kPlayerParamDisabled = Text(
  '-',
  style: TextStyle(
      fontSize: 30.0, fontFamily: 'BarlowCondensed', color: Color(0xFF707070)),
);

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
                                        child: RaisedButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: null,
                                      child: Container(
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF464655),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0xFF000000),
                                                  blurRadius: 8.0,
                                                  offset: Offset(7.0, 7.0))
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0, 0.0, 15.0, 0.0),
                                          child: Container(
                                            child: Text(
                                              'START',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Color(0xFF9999AC),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Icon(FontAwesomeIcons.addressBook)),
                                Expanded(child: Icon(FontAwesomeIcons.star))
                              ],
                            ),
                          )
                        ],
                      ),
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
