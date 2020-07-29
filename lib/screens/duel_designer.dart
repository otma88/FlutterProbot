import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:probot/model/players.dart';
import 'package:probot/widgets/custom_radio.dart';
import 'package:probot/widgets/disable_button.dart';
import 'package:probot/widgets/disable_button_disable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/leagues.dart';
import '../model/clubs.dart';
import '../widgets/quick_kick_siluete.dart';
import '../widgets/inactive_siluete.dart';
import '../widgets/active_siluete_duel_designer.dart';
import '../widgets/start_button.dart';
import '../constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../widgets/modal_item.dart';

Future<List<League>> _fetchLeagues(http.Client client) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var accessToken = jsonDecode(localStorage.getString('token'));
  var response = await client
      .get(URL_LEAGUE_API, headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $accessToken"});
  return compute(parseLeagues, response.body);
}

Future<List<Club>> _fetchClubsByLeagueID(http.Client client, String leagueID) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var accessToken = jsonDecode(localStorage.getString('token'));
  var response = await client.get('http://165.22.26.62/api/auth/clubs/league/$leagueID',
      headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $accessToken"});

  return compute(parseClubs, response.body);
}

Future<List<Player>> _fetchPlayersByClubID(http.Client client, String clubID) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var accessToken = jsonDecode(localStorage.getString('token'));
  var response = await client.get('http://165.22.26.62/api/auth/players/club/$clubID',
      headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $accessToken"});

  return compute(parsePlayers, response.body);
}

Future<List<Player>> _fetchPlayersByClubIDAndPosition(http.Client client, String clubID, String position) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var accessToken = jsonDecode(localStorage.getString('token'));

  var response = await client.get('http://165.22.26.62/api/auth/players/club/$clubID/$position',
      headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $accessToken"});

  return compute(parsePlayers, response.body);
}

List<League> parseLeagues(String responseBody) {
  final parsed = jsonDecode(responseBody);
  Map<String, dynamic> pas = parsed;
  return pas['data'].map<League>((json) => League.fromJson(json)).toList();
}

List<Club> parseClubs(String responseBody) {
  final parsed = jsonDecode(responseBody);
  Map<String, dynamic> pas = parsed;
  return pas['data'].map<Club>((json) => Club.fromJson(json)).toList();
}

List<Player> parsePlayers(String responseBody) {
  final parsed = jsonDecode(responseBody);
  Map<String, dynamic> pas = parsed;
  return pas['data'].map<Player>((json) => Player.fromJson(json)).toList();
}

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
  League _selectedLeague;
  Future<List<League>> _leagues;
  Club _selectedClub;
  Future<List<Club>> _clubs;
  String leagueID = "1";
  Player _selectedPlayer1;
  Player _selectedPlayer2;
  Player _selectedPlayer3;
  Player _selectedPlayer4;
  Player _selectedPlayer5;
  Future<List<Player>> _players;
  Future<List<Player>> _defenders;
  Future<List<Player>> _midfilders;
  Future<List<Player>> _forwards;
  String clubID = "1";

  bool isActiveSiluete1;
  bool isActiveSiluete2;
  bool isActiveSiluete3;
  bool isActiveSiluete4;
  bool isActiveSiluete5;

  int activeRadioButtonInModal;

  @override
  void initState() {
    super.initState();
    _leagues = _fetchLeagues(http.Client());
    _clubs = _fetchClubsByLeagueID(http.Client(), leagueID);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    activeRadioButtonInModal = 1;
  }

  _updateActiveRadioButton(int activeNumber) {
    setState(() {
      activeRadioButtonInModal = activeNumber;
    });
  }

  Widget LeaguesDropdown(double chooseLeagueFontSize, double flagSizeHeight, double flagSizeWidth) {
    return Container(
        child: FutureBuilder<List<League>>(
            future: _leagues,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nema podataka",
                    style: TextStyle(fontSize: chooseLeagueFontSize, fontFamily: 'BarlowCondensed', color: Color(0xFF9999AC)),
                  ),
                );
              }
              return DropdownButton<League>(
                hint: Text(
                  "Choose league",
                  style: TextStyle(fontSize: chooseLeagueFontSize, fontFamily: 'BarlowCondensed'),
                ),
                underline: SizedBox(),
                icon: SizedBox(),
                items: snapshot.data
                    .map<DropdownMenuItem<League>>((league) => DropdownMenuItem<League>(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SvgPicture.network(
                                league.flag,
                                width: flagSizeWidth,
                                height: flagSizeHeight,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(league.name)
                            ],
                          ),
                          value: league,
                        ))
                    .toList(),
                onChanged: (League value) {
                  setState(() {
                    isActiveSiluete1 = false;
                    isActiveSiluete2 = false;
                    isActiveSiluete3 = false;
                    isActiveSiluete4 = false;
                    isActiveSiluete5 = false;
                    _selectedLeague = value;
                    _selectedPlayer1 = null;
                    _selectedPlayer2 = null;
                    _selectedPlayer3 = null;
                    _selectedPlayer4 = null;
                    _selectedPlayer5 = null;
                    _selectedClub = null;
                    leagueID = _selectedLeague.id.toString();
                    _clubs = _fetchClubsByLeagueID(http.Client(), leagueID);
                  });
                },
                value: _selectedLeague,
                isExpanded: true,
                elevation: 6,
                style: TextStyle(fontSize: chooseLeagueFontSize, fontFamily: 'BarlowCondensed', color: Color(0xFF9999AC)),
              );
            }));
  }

  Widget ClubsDropdown(double chooseLeagueFontSize, double flagSizeHeight, double flagSizeWidth) {
    return Container(
        child: FutureBuilder<List<Club>>(
            future: _clubs,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Nema podataka",
                        style: TextStyle(
                          fontSize: chooseLeagueFontSize,
                          fontFamily: 'BarlowCondensed',
                          color: Color(0xFF9999AC),
                        )));
              }
              return DropdownButton<Club>(
                hint: Text(
                  "Choose club",
                  style: TextStyle(fontSize: chooseLeagueFontSize, fontFamily: 'BarlowCondensed'),
                ),
                underline: SizedBox(),
                icon: SizedBox(),
                items: snapshot.data
                    .map<DropdownMenuItem<Club>>((club) => DropdownMenuItem<Club>(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                club.logo,
                                width: flagSizeWidth,
                                height: flagSizeHeight,
                              ),
                              Text(club.name)
                            ],
                          ),
                          value: club,
                        ))
                    .toList(),
                onChanged: (Club value) {
                  setState(() {
                    _selectedClub = value;
                    isActiveSiluete1 = false;
                    isActiveSiluete2 = false;
                    isActiveSiluete3 = false;
                    isActiveSiluete4 = false;
                    isActiveSiluete5 = false;
                    _selectedPlayer1 = null;
                    _selectedPlayer2 = null;
                    _selectedPlayer3 = null;
                    _selectedPlayer4 = null;
                    _selectedPlayer5 = null;
                    clubID = _selectedClub.id.toString();
                    _players = _fetchPlayersByClubID(http.Client(), clubID);
                    _defenders = _fetchPlayersByClubIDAndPosition(http.Client(), clubID, "Defender");
                    _midfilders = _fetchPlayersByClubIDAndPosition(http.Client(), clubID, "Midfielder");
                    _forwards = _fetchPlayersByClubIDAndPosition(http.Client(), clubID, "Attacker");
                  });
                },
                value: _selectedClub,
                isExpanded: true,
                elevation: 6,
                style: TextStyle(fontSize: chooseLeagueFontSize, fontFamily: 'BarlowCondensed', color: Color(0xFF9999AC)),
              );
            }));
  }

  Color getColorFromString(String value) {
    return new Color(int.parse(value.substring(4, 10), radix: 16) + 0xFF000000);
  }

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
                          "DUEL DESIGNER",
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
                    height: size.height * 0.12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Select opponent:",
                          style: TextStyle(color: Color(0xFF464655), fontSize: size.height * 0.03, fontFamily: 'BarlowCondensed'),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
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
                                    child: LeaguesDropdown(size.height * 0.04, size.height * 0.045, size.width * 0.045),
                                  )),
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
                      SizedBox(
                        height: size.height * 0.03,
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
                                    child: ClubsDropdown(size.height * 0.04, size.height * 0.06, size.width * 0.06),
                                  )),
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
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: size.height * 0.12,
                              child: GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(size.height * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'LOAD',
                                        style: TextStyle(fontSize: size.height * 0.045, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed'),
                                      ),
                                      Text('SAVED PRESET',
                                          style: TextStyle(fontSize: size.height * 0.021, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed'))
                                    ],
                                  ),
                                ),
                              ),
                              color: Color(0xFF242432),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.028,
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: size.height * 0.12,
                              child: GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(size.height * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'SAVE',
                                        style: TextStyle(fontSize: size.height * 0.045, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed'),
                                      ),
                                      Text('THIS SETUP',
                                          style: TextStyle(fontSize: size.height * 0.021, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed'))
                                    ],
                                  ),
                                ),
                              ),
                              color: Color(0xFF242432),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Expanded(
                              child: StartButton(
                            onTap: null,
                            buttonTitle: "START",
                            buttonPadding: size.height * 0.02,
                            buttonSize: size.height * 0.12,
                            titleFontSize: size.height * 0.05,
                          )),
                          SizedBox(
                            width: size.width * 0.028,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 2 / 3,
            color: Color(0xFF242432),
            child: Column(
              children: <Widget>[
                Container(
                  height: size.height / 5,
                  color: Color(0xFF191926),
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.03),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Image.asset(
                                          'images/icons/height.png',
                                          height: size.height * 0.06,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          _selectedPlayer1 != null
                                              ? _selectedPlayer1.height != null ? _selectedPlayer1.height : "-"
                                              : kPlayerParamDisabled.data,
                                          style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          _selectedPlayer2 != null
                                              ? _selectedPlayer2.height != null ? _selectedPlayer2.height : "-"
                                              : kPlayerParamDisabled.data,
                                          style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          _selectedPlayer3 != null
                                              ? _selectedPlayer3.height != null ? _selectedPlayer3.height : "-"
                                              : kPlayerParamDisabled.data,
                                          style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          _selectedPlayer4 != null
                                              ? _selectedPlayer4.height != null ? _selectedPlayer4.height : "-"
                                              : kPlayerParamDisabled.data,
                                          style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          _selectedPlayer5 != null
                                              ? _selectedPlayer5.height != null ? _selectedPlayer5.height : "-"
                                              : kPlayerParamDisabled.data,
                                          style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Image.asset(
                                            'images/icons/jump_height.png',
                                            height: size.height * 0.06,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            _selectedPlayer1 != null ? _selectedPlayer1.height != null ? "45 cm" : "-" : "-",
                                            style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            _selectedPlayer2 != null ? _selectedPlayer2.height != null ? "45 cm" : "-" : "-",
                                            style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            _selectedPlayer3 != null ? _selectedPlayer3.height != null ? "45 cm" : "-" : "-",
                                            style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            _selectedPlayer4 != null ? _selectedPlayer4.height != null ? "45 cm" : "-" : "-",
                                            style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            _selectedPlayer5 != null ? _selectedPlayer5.height != null ? "45 cm" : "-" : "-",
                                            style: TextStyle(fontFamily: 'BarlowCondensed', fontSize: size.height * 0.045),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: size.height * 4 / 5,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.05,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(),
                              flex: 1,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'images/icons/down.png',
                                  height: size.height * 0.04,
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    'images/icons/down.png',
                                    height: size.height * 0.04,
                                  )),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    'images/icons/down.png',
                                    height: size.height * 0.04,
                                  )),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    'images/icons/down.png',
                                    height: size.height * 0.04,
                                  )),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    'images/icons/down.png',
                                    height: size.height * 0.04,
                                  )),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        verticalDirection: VerticalDirection.down,
//                        children: <Widget>[
//                          Expanded(
//                            child: SizedBox(),
//                            flex: 1,
//                          ),
//                          Expanded(
//                            flex: 2,
//                            child: Padding(
//                                padding: EdgeInsets.only(left: size.height * 0.025, right: size.height * 0.025),
//                                child: isActiveSiluete1 == true
//                                    ? DisableButton(
//                                        onTap: () {
//                                          setState(() {
//                                            isActiveSiluete1 = false;
//                                            _selectedPlayer1 = null;
//                                          });
//                                        },
//                                        buttonTitle: "Disable",
//                                        titleFontSize: size.height * 0.035,
//                                        buttonSize: size.height * 0.07,
//                                      )
//                                    : DisableButtonDisable(
//                                        buttonSize: size.height * 0.07,
//                                        buttonTitle: "Disable",
//                                      )),
//                          ),
//                          Expanded(
//                            flex: 2,
//                            child: Padding(
//                                padding: EdgeInsets.only(left: size.height * 0.025, right: size.height * 0.025),
//                                child: isActiveSiluete2 == true
//                                    ? DisableButton(
//                                        onTap: () {
//                                          setState(() {
//                                            isActiveSiluete2 = false;
//                                            _selectedPlayer2 = null;
//                                          });
//                                        },
//                                        buttonTitle: "Disable",
//                                        titleFontSize: size.height * 0.035,
//                                        buttonSize: size.height * 0.07,
//                                      )
//                                    : DisableButtonDisable(
//                                        buttonSize: size.height * 0.07,
//                                        buttonTitle: "Disable",
//                                      )),
//                          ),
//                          Expanded(
//                            flex: 2,
//                            child: Padding(
//                                padding: EdgeInsets.only(left: size.height * 0.025, right: size.height * 0.025),
//                                child: isActiveSiluete3 == true
//                                    ? DisableButton(
//                                        onTap: () {
//                                          setState(() {
//                                            isActiveSiluete3 = false;
//                                            _selectedPlayer3 = null;
//                                          });
//                                        },
//                                        buttonTitle: "Disable",
//                                        titleFontSize: size.height * 0.035,
//                                        buttonSize: size.height * 0.07,
//                                      )
//                                    : DisableButtonDisable(
//                                        buttonSize: size.height * 0.07,
//                                        buttonTitle: "Disable",
//                                      )),
//                          ),
//                          Expanded(
//                            flex: 2,
//                            child: Padding(
//                                padding: EdgeInsets.only(left: size.height * 0.025, right: size.height * 0.025),
//                                child: isActiveSiluete4 == true
//                                    ? DisableButton(
//                                        onTap: () {
//                                          setState(() {
//                                            isActiveSiluete4 = false;
//                                            _selectedPlayer4 = null;
//                                          });
//                                        },
//                                        buttonTitle: "Disable",
//                                        titleFontSize: size.height * 0.035,
//                                        buttonSize: size.height * 0.07,
//                                      )
//                                    : DisableButtonDisable(
//                                        buttonSize: size.height * 0.07,
//                                        buttonTitle: "Disable",
//                                      )),
//                          ),
//                          Expanded(
//                            flex: 2,
//                            child: Padding(
//                                padding: EdgeInsets.only(left: size.height * 0.025, right: size.height * 0.025),
//                                child: isActiveSiluete5 == true
//                                    ? DisableButton(
//                                        onTap: () {
//                                          setState(() {
//                                            isActiveSiluete5 = false;
//                                            _selectedPlayer5 = null;
//                                          });
//                                        },
//                                        buttonTitle: "Disable",
//                                        titleFontSize: size.height * 0.035,
//                                        buttonSize: size.height * 0.07,
//                                      )
//                                    : DisableButtonDisable(
//                                        buttonSize: size.height * 0.07,
//                                        buttonTitle: "Disable",
//                                      )),
//                          )
//                        ],
//                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: size.height * 0.1,
                                ),
                                Container(
                                  child: Image.asset(
                                    'images/icons/player.png',
                                    height: size.height * 0.04,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.38,
                                ),
                                Container(
                                  child: Image.asset(
                                    'images/icons/batt.png',
                                    height: size.height * 0.04,
                                  ),
                                ),
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
                                          if (this._selectedClub != null) {
                                            setState(() {
                                              activeRadioButtonInModal = 1;
                                            });
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return Container(
                                                    height: MediaQuery.of(context).size.height * 0.75,
                                                    color: Color(0xFF484454),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    size: 50.0,
                                                                    color: Color(0xFF9999AC),
                                                                  ),
                                                                  onTap: () => Navigator.pop(context)),
                                                              SizedBox(
                                                                width: 20.0,
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  "PLAYERS",
                                                                  style: TextStyle(
                                                                      fontSize: 50.0, color: Color(0xFF9999AC), fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 5,
                                                                  child: CustomRadio(
                                                                      parentAction: _updateActiveRadioButton, activeButton: activeRadioButtonInModal))
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Defenders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _defenders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Midfilders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _midfilders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Forwards",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _forwards,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
//
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) => CupertinoAlertDialog(
                                                      title: Text("Alert"),
                                                      content: Text("Please choose opponent!"),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          onPressed: () => Navigator.pop(context, 'Discard'),
                                                          isDefaultAction: true,
                                                          child: Text("Close"),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                        },
                                        siluete: isActiveSiluete1 == true
                                            ? ActiveSilueteDuelDesigner(
                                                image: kDDActiveSiluete,
                                                number: "1",
                                                batteryLevel: 1,
                                                numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                playerName: _selectedPlayer1.lastName != null ? _selectedPlayer1.lastName.toUpperCase() : "",
                                                playerNumber: _selectedPlayer1.number != null ? _selectedPlayer1.number.toString() : "1",
                                                kragna: _selectedClub.collarColor != null
                                                    ? getColorFromString(_selectedClub.collarColor)
                                                    : Color(0xFFFF0000),
                                                shirtColor: _selectedClub.shirtColor != null
                                                    ? getColorFromString(_selectedClub.shirtColor)
                                                    : Color(0xFF243479),
                                                playerNameColor:
                                                    _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                playerNumberColor: _selectedClub.numberColor != null
                                                    ? getColorFromString(_selectedClub.numberColor)
                                                    : Color(0xFFFF0000),
                                                playerNumberStrokeColor: _selectedClub.numBorderColor != null
                                                    ? getColorFromString(_selectedClub.numBorderColor)
                                                    : Colors.white,
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
                                                numberFontSize: size.height * 0.06,
                                                batteryLevelBoxHeight: size.height * 0.1,
                                                batteryLevelBoxWidth: size.width * 0.04,
                                                batteryIndicatorHeight: size.height * 0.017,
                                                batteryIndicatorWidth: size.width * 0.036,
                                                batteryLevelPositionBottom: size.height * -0.43,
                                                kragnaTopPosition: size.height * 0.076,
                                                kragnaPositionRight: size.height * 0.007,
                                                kragnaWidth: size.height * 0.09,
                                                shirtTopPosition: size.height * 0.084,
                                                shirtRightPosition: size.width * 0.005,
                                                shirtWidth: size.width * 0.08,
                                                playerNameTopPosition: size.height * 0.092,
                                                playerNameRightPosition: size.width * 0.005,
                                                playerNameBoxHeight: size.height * 0.03,
                                                playerNameBoxWidth: size.width * 0.07,
                                                playerNumberTopPosition: size.height * 0.11,
                                                playerNumberRightPosition: size.width * 0.005,
                                                playerNumberFontSize: size.height * 0.08,
                                              )
                                            : InactiveSiluete(
                                                image: kInactiveSiluete,
                                                number: "1",
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                    child: QuickKickSiluete(
                                        onPress: () {
                                          if (this._selectedClub != null) {
                                            setState(() {
                                              activeRadioButtonInModal = 2;
                                            });
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return Container(
                                                    height: MediaQuery.of(context).size.height * 0.75,
                                                    color: Color(0xFF484454),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    size: 50.0,
                                                                    color: Color(0xFF9999AC),
                                                                  ),
                                                                  onTap: () => Navigator.pop(context)),
                                                              SizedBox(
                                                                width: 20.0,
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  "PLAYERS",
                                                                  style: TextStyle(
                                                                      fontSize: 50.0, color: Color(0xFF9999AC), fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 5,
                                                                  child: CustomRadio(
                                                                      parentAction: _updateActiveRadioButton, activeButton: activeRadioButtonInModal))
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Defenders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _defenders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Midfilders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _midfilders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Forwards",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _forwards,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                            //
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) => CupertinoAlertDialog(
                                                      title: Text("Hey!!!"),
                                                      content: Text("Please choose opponent!"),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          onPressed: () => Navigator.pop(context, 'Discard'),
                                                          isDefaultAction: true,
                                                          child: Text("Close"),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                        },
                                        siluete: isActiveSiluete2 == true
                                            ? ActiveSilueteDuelDesigner(
                                                image: kDDActiveSiluete,
                                                number: "2",
                                                batteryLevel: 2,
                                                numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                playerName: _selectedPlayer2.lastName != null ? _selectedPlayer2.lastName.toUpperCase() : "",
                                                playerNumber: _selectedPlayer2.number != null ? _selectedPlayer2.number.toString() : "2",
                                                kragna: _selectedClub.collarColor != null
                                                    ? getColorFromString(_selectedClub.collarColor)
                                                    : Color(0xFFFF0000),
                                                shirtColor: _selectedClub.shirtColor != null
                                                    ? getColorFromString(_selectedClub.shirtColor)
                                                    : Color(0xFF243479),
                                                playerNameColor:
                                                    _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                playerNumberColor: _selectedClub.numberColor != null
                                                    ? getColorFromString(_selectedClub.numberColor)
                                                    : Color(0xFFFF0000),
                                                playerNumberStrokeColor: _selectedClub.numBorderColor != null
                                                    ? getColorFromString(_selectedClub.numBorderColor)
                                                    : Colors.white,
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
                                                numberFontSize: size.height * 0.06,
                                                batteryLevelBoxHeight: size.height * 0.1,
                                                batteryLevelBoxWidth: size.width * 0.04,
                                                batteryIndicatorHeight: size.height * 0.017,
                                                batteryIndicatorWidth: size.width * 0.036,
                                                batteryLevelPositionBottom: size.height * -0.43,
                                                kragnaTopPosition: size.height * 0.076,
                                                kragnaPositionRight: size.height * 0.007,
                                                kragnaWidth: size.height * 0.09,
                                                shirtTopPosition: size.height * 0.084,
                                                shirtRightPosition: size.width * 0.005,
                                                shirtWidth: size.width * 0.08,
                                                playerNameTopPosition: size.height * 0.092,
                                                playerNameRightPosition: size.width * 0.005,
                                                playerNameBoxHeight: size.height * 0.03,
                                                playerNameBoxWidth: size.width * 0.07,
                                                playerNumberTopPosition: size.height * 0.11,
                                                playerNumberRightPosition: size.width * 0.005,
                                                playerNumberFontSize: size.height * 0.08,
                                              )
                                            : InactiveSiluete(
                                                image: kInactiveSiluete,
                                                number: "2",
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                    child: QuickKickSiluete(
                                        onPress: () {
                                          if (this._selectedClub != null) {
                                            setState(() {
                                              activeRadioButtonInModal = 3;
                                            });
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return Container(
                                                    height: MediaQuery.of(context).size.height * 0.75,
                                                    color: Color(0xFF484454),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    size: 50.0,
                                                                    color: Color(0xFF9999AC),
                                                                  ),
                                                                  onTap: () => Navigator.pop(context)),
                                                              SizedBox(
                                                                width: 20.0,
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  "PLAYERS",
                                                                  style: TextStyle(
                                                                      fontSize: 50.0, color: Color(0xFF9999AC), fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 5,
                                                                  child: CustomRadio(
                                                                      parentAction: _updateActiveRadioButton, activeButton: activeRadioButtonInModal))
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Defenders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _defenders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Midfilders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _midfilders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Forwards",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _forwards,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                            //
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) => CupertinoAlertDialog(
                                                      title: Text("Hey!!!"),
                                                      content: Text("Please choose opponent!"),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          onPressed: () => Navigator.pop(context, 'Discard'),
                                                          isDefaultAction: true,
                                                          child: Text("Close"),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                        },
                                        siluete: isActiveSiluete3 == true
                                            ? ActiveSilueteDuelDesigner(
                                                image: kDDActiveSiluete,
                                                number: "3",
                                                batteryLevel: 3,
                                                numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                playerName: _selectedPlayer3.lastName != null ? _selectedPlayer3.lastName.toUpperCase() : "",
                                                playerNumber: _selectedPlayer3.number != null ? _selectedPlayer3.number.toString() : "3",
                                                kragna: _selectedClub.collarColor != null
                                                    ? getColorFromString(_selectedClub.collarColor)
                                                    : Color(0xFFFF0000),
                                                shirtColor: _selectedClub.shirtColor != null
                                                    ? getColorFromString(_selectedClub.shirtColor)
                                                    : Color(0xFF243479),
                                                playerNameColor:
                                                    _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                playerNumberColor: _selectedClub.numberColor != null
                                                    ? getColorFromString(_selectedClub.numberColor)
                                                    : Color(0xFFFF0000),
                                                playerNumberStrokeColor: _selectedClub.numBorderColor != null
                                                    ? getColorFromString(_selectedClub.numBorderColor)
                                                    : Colors.white,
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
                                                numberFontSize: size.height * 0.06,
                                                batteryLevelBoxHeight: size.height * 0.1,
                                                batteryLevelBoxWidth: size.width * 0.04,
                                                batteryIndicatorHeight: size.height * 0.017,
                                                batteryIndicatorWidth: size.width * 0.036,
                                                batteryLevelPositionBottom: size.height * -0.43,
                                                kragnaTopPosition: size.height * 0.076,
                                                kragnaPositionRight: size.height * 0.007,
                                                kragnaWidth: size.height * 0.09,
                                                shirtTopPosition: size.height * 0.084,
                                                shirtRightPosition: size.width * 0.005,
                                                shirtWidth: size.width * 0.08,
                                                playerNameTopPosition: size.height * 0.092,
                                                playerNameRightPosition: size.width * 0.005,
                                                playerNameBoxHeight: size.height * 0.03,
                                                playerNameBoxWidth: size.width * 0.07,
                                                playerNumberTopPosition: size.height * 0.11,
                                                playerNumberRightPosition: size.width * 0.005,
                                                playerNumberFontSize: size.height * 0.08,
                                              )
                                            : InactiveSiluete(
                                                image: kInactiveSiluete,
                                                number: "3",
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                    child: QuickKickSiluete(
                                        onPress: () {
                                          if (this._selectedClub != null) {
                                            setState(() {
                                              activeRadioButtonInModal = 4;
                                            });
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return Container(
                                                    height: MediaQuery.of(context).size.height * 0.75,
                                                    color: Color(0xFF484454),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    size: 50.0,
                                                                    color: Color(0xFF9999AC),
                                                                  ),
                                                                  onTap: () => Navigator.pop(context)),
                                                              SizedBox(
                                                                width: 20.0,
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  "PLAYERS",
                                                                  style: TextStyle(
                                                                      fontSize: 50.0, color: Color(0xFF9999AC), fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 5,
                                                                  child: CustomRadio(
                                                                      parentAction: _updateActiveRadioButton, activeButton: activeRadioButtonInModal))
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Defenders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _defenders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Midfilders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _midfilders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Forwards",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _forwards,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                            //
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) => CupertinoAlertDialog(
                                                      title: Text("Hey!!!"),
                                                      content: Text("Please choose opponent!"),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          onPressed: () => Navigator.pop(context, 'Discard'),
                                                          isDefaultAction: true,
                                                          child: Text("Close"),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                        },
                                        siluete: isActiveSiluete4 == true
                                            ? ActiveSilueteDuelDesigner(
                                                image: kDDActiveSiluete,
                                                number: "4",
                                                batteryLevel: 4,
                                                numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                playerName: _selectedPlayer4.lastName != null ? _selectedPlayer4.lastName.toUpperCase() : "",
                                                playerNumber: _selectedPlayer4.number != null ? _selectedPlayer4.number.toString() : "4",
                                                kragna: _selectedClub.collarColor != null
                                                    ? getColorFromString(_selectedClub.collarColor)
                                                    : Color(0xFFFF0000),
                                                shirtColor: _selectedClub.shirtColor != null
                                                    ? getColorFromString(_selectedClub.shirtColor)
                                                    : Color(0xFF243479),
                                                playerNameColor:
                                                    _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                playerNumberColor: _selectedClub.numberColor != null
                                                    ? getColorFromString(_selectedClub.numberColor)
                                                    : Color(0xFFFF0000),
                                                playerNumberStrokeColor: _selectedClub.numBorderColor != null
                                                    ? getColorFromString(_selectedClub.numBorderColor)
                                                    : Colors.white,
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
                                                numberFontSize: size.height * 0.06,
                                                batteryLevelBoxHeight: size.height * 0.1,
                                                batteryLevelBoxWidth: size.width * 0.04,
                                                batteryIndicatorHeight: size.height * 0.017,
                                                batteryIndicatorWidth: size.width * 0.036,
                                                batteryLevelPositionBottom: size.height * -0.43,
                                                kragnaTopPosition: size.height * 0.076,
                                                kragnaPositionRight: size.height * 0.007,
                                                kragnaWidth: size.height * 0.09,
                                                shirtTopPosition: size.height * 0.084,
                                                shirtRightPosition: size.width * 0.005,
                                                shirtWidth: size.width * 0.08,
                                                playerNameTopPosition: size.height * 0.092,
                                                playerNameRightPosition: size.width * 0.005,
                                                playerNameBoxHeight: size.height * 0.03,
                                                playerNameBoxWidth: size.width * 0.07,
                                                playerNumberTopPosition: size.height * 0.11,
                                                playerNumberRightPosition: size.width * 0.005,
                                                playerNumberFontSize: size.height * 0.08,
                                              )
                                            : InactiveSiluete(
                                                image: kInactiveSiluete,
                                                number: "4",
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                    child: QuickKickSiluete(
                                        onPress: () {
                                          if (this._selectedClub != null) {
                                            setState(() {
                                              activeRadioButtonInModal = 5;
                                            });
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return Container(
                                                    height: MediaQuery.of(context).size.height * 0.75,
                                                    color: Color(0xFF484454),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    size: 50.0,
                                                                    color: Color(0xFF9999AC),
                                                                  ),
                                                                  onTap: () => Navigator.pop(context)),
                                                              SizedBox(
                                                                width: 20.0,
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  "PLAYERS",
                                                                  style: TextStyle(
                                                                      fontSize: 50.0, color: Color(0xFF9999AC), fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 5,
                                                                  child: CustomRadio(
                                                                      parentAction: _updateActiveRadioButton, activeButton: activeRadioButtonInModal))
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Defenders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _defenders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Midfilders",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _midfilders,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  color: Color(0xFF242131),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Forwards",
                                                                          style: TextStyle(
                                                                              fontSize: 25.0,
                                                                              fontFamily: 'BarlowCondensed',
                                                                              color: Color(0xFF9999AC)),
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<List<Player>>(
                                                                        future: _forwards,
                                                                        builder: (context, snapshot) {
                                                                          switch (snapshot.connectionState) {
                                                                            case ConnectionState.none:
                                                                            case ConnectionState.waiting:
                                                                              return Text("Loading...");
                                                                            default:
                                                                              if (snapshot.hasError) {
                                                                                return Text('Error: ${snapshot.error}');
                                                                              } else {
                                                                                return Container(
                                                                                  child: Scrollbar(
                                                                                    child: ListView.separated(
                                                                                        separatorBuilder: (context, index) => SizedBox(
                                                                                              height: 15.0,
                                                                                            ),
                                                                                        itemCount: snapshot.data.length,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        shrinkWrap: true,
                                                                                        itemBuilder: (context, index) {
                                                                                          return GestureDetector(
                                                                                            child: ModalItem(
                                                                                                snapshot.data[index].playerName,
                                                                                                snapshot.data[index].number != null
                                                                                                    ? snapshot.data[index].number
                                                                                                    : 18),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                if (activeRadioButtonInModal == 1) {
                                                                                                  _selectedPlayer1 = snapshot.data[index];
                                                                                                  isActiveSiluete1 = true;
                                                                                                } else if (activeRadioButtonInModal == 2) {
                                                                                                  _selectedPlayer2 = snapshot.data[index];
                                                                                                  isActiveSiluete2 = true;
                                                                                                } else if (activeRadioButtonInModal == 3) {
                                                                                                  _selectedPlayer3 = snapshot.data[index];
                                                                                                  isActiveSiluete3 = true;
                                                                                                } else if (activeRadioButtonInModal == 4) {
                                                                                                  _selectedPlayer4 = snapshot.data[index];
                                                                                                  isActiveSiluete4 = true;
                                                                                                } else {
                                                                                                  _selectedPlayer5 = snapshot.data[index];
                                                                                                  isActiveSiluete5 = true;
                                                                                                }
                                                                                              });
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  height: 450,
                                                                                );
                                                                              }
                                                                          }
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                            //
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) => CupertinoAlertDialog(
                                                      title: Text("Hey!!!"),
                                                      content: Text("Please choose opponent!"),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          onPressed: () => Navigator.pop(context, 'Discard'),
                                                          isDefaultAction: true,
                                                          child: Text("Close"),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                        },
                                        siluete: isActiveSiluete5 == true
                                            ? ActiveSilueteDuelDesigner(
                                                image: kDDActiveSiluete,
                                                number: "5",
                                                batteryLevel: 5,
                                                numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                playerName: _selectedPlayer5.lastName != null ? _selectedPlayer5.lastName.toUpperCase() : "",
                                                playerNumber: _selectedPlayer5.number != null ? _selectedPlayer5.number.toString() : "5",
                                                kragna: _selectedClub.collarColor != null
                                                    ? getColorFromString(_selectedClub.collarColor)
                                                    : Color(0xFFFF0000),
                                                shirtColor: _selectedClub.shirtColor != null
                                                    ? getColorFromString(_selectedClub.shirtColor)
                                                    : Color(0xFF243479),
                                                playerNameColor:
                                                    _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                playerNumberColor: _selectedClub.numberColor != null
                                                    ? getColorFromString(_selectedClub.numberColor)
                                                    : Color(0xFFFF0000),
                                                playerNumberStrokeColor: _selectedClub.numBorderColor != null
                                                    ? getColorFromString(_selectedClub.numBorderColor)
                                                    : Colors.white,
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
                                                numberFontSize: size.height * 0.06,
                                                batteryLevelBoxHeight: size.height * 0.1,
                                                batteryLevelBoxWidth: size.width * 0.04,
                                                batteryIndicatorHeight: size.height * 0.017,
                                                batteryIndicatorWidth: size.width * 0.036,
                                                batteryLevelPositionBottom: size.height * -0.43,
                                                kragnaTopPosition: size.height * 0.076,
                                                kragnaPositionRight: size.height * 0.007,
                                                kragnaWidth: size.height * 0.09,
                                                shirtTopPosition: size.height * 0.084,
                                                shirtRightPosition: size.width * 0.005,
                                                shirtWidth: size.width * 0.08,
                                                playerNameTopPosition: size.height * 0.092,
                                                playerNameRightPosition: size.width * 0.005,
                                                playerNameBoxHeight: size.height * 0.03,
                                                playerNameBoxWidth: size.width * 0.07,
                                                playerNumberTopPosition: size.height * 0.11,
                                                playerNumberRightPosition: size.width * 0.005,
                                                playerNumberFontSize: size.height * 0.08,
                                              )
                                            : InactiveSiluete(
                                                image: kInactiveSiluete,
                                                number: "5",
                                                silueteSize: size.height * 0.62,
                                                numberPositionBottom: size.height * -0.22,
                                                numberFontSize: size.height * 0.06,
                                                detachedPositionTop: size.height * 0.1,
                                                detachedPositionLeft: size.width * 0.012,
                                                detachedFontSIze: size.height * 0.032,
                                              )))
                              ],
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                      Container(child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          double width = constraints.maxWidth;
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                width: width * 0.18,
                              ),
                              Container(
                                height: size.height * 0.03,
                                width: width * 0.145,
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(width: 1, color: Color(0xFF9999AC)),
                                        bottom: BorderSide(width: 1, color: Color(0xFF9999AC)))),
                              ),
                              Container(
                                  child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'images/icons/substitute.png',
                                      height: size.height * 0.04,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'tap on player to SUBSTITUTE',
                                      style: TextStyle(fontSize: size.height * 0.04, color: Color(0xFF9999AC), fontFamily: "BarlowCondensed"),
                                    ),
                                  ),
                                ],
                              )),
                              Container(
                                height: size.height * 0.03,
                                width: width * 0.14,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(width: 1, color: Color(0xFF9999AC)),
                                        bottom: BorderSide(width: 1, color: Color(0xFF9999AC)))),
                              ),
                            ],
                          );
                        },
                      ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
