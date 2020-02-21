import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:probot/network/api.dart';
import 'package:probot/players.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'leagues.dart';
import 'clubs.dart';
import 'quick_kick_siluete.dart';
import 'inactive_siluete.dart';
import 'active_siluete_duel_designer.dart';
import 'start_button.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<List<League>> _fetchLeagues(http.Client client) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var accessToken = jsonDecode(localStorage.getString('token'));
  var response = await client.get(URL_LEAGUE_API, headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $accessToken"});
  return compute(parseLeagues, response.body);
}

Future<List<Club>> _fetchClubsByLeagueID(http.Client client, String leagueID) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var accessToken = jsonDecode(localStorage.getString('token'));
  var response = await client.get('http://probot-backend.test/api/auth/clubs/league/$leagueID',
      headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $accessToken"});

  return compute(parseClubs, response.body);
}

Future<List<Player>> _fetchPlayersByClubID(http.Client client, String clubID) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var accessToken = jsonDecode(localStorage.getString('token'));
  var response = await client.get('http://probot-backend.test/api/auth/players/club/$clubID',
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
  String clubID = "1";

  bool isActiveSiluete1;
  bool isActiveSiluete2;
  bool isActiveSiluete3;
  bool isActiveSiluete4;
  bool isActiveSiluete5;

  @override
  void initState() {
    super.initState();
    _leagues = _fetchLeagues(http.Client());
    _clubs = _fetchClubsByLeagueID(http.Client(), leagueID);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  Widget LeaguesDropdown() {
    return Container(
        child: FutureBuilder<List<League>>(
            future: _leagues,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Nema podataka"),
                );
              }
              return DropdownButton<League>(
                hint: Text("Choose league"),
                underline: SizedBox(),
                icon: SizedBox(),
                items: snapshot.data
                    .map<DropdownMenuItem<League>>((league) => DropdownMenuItem<League>(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SvgPicture.network(
                                league.flag,
                                width: 25,
                                height: 25,
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
                style: TextStyle(fontSize: 25.0, fontFamily: 'BarlowCondensed', color: Color(0xFF9999AC)),
              );
            }));
  }

  Widget ClubsDropdown() {
    return Container(
        child: FutureBuilder<List<Club>>(
            future: _clubs,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Nema podataka"),
                );
              }
              return DropdownButton<Club>(
                hint: Text("Choose club"),
                underline: SizedBox(),
                icon: SizedBox(),
                items: snapshot.data
                    .map<DropdownMenuItem<Club>>((club) => DropdownMenuItem<Club>(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                club.logo,
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 10.0,
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
                  });
                },
                value: _selectedClub,
                isExpanded: true,
                elevation: 6,
                style: TextStyle(fontSize: 25.0, fontFamily: 'BarlowCondensed', color: Color(0xFF9999AC)),
              );
            }));
  }

  Color getColorFromString(String value) {
    return new Color(int.parse(value.substring(4, 10), radix: 16) + 0xFF000000);
  }

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
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                                child: Text(
                                  "Select opponent:",
                                  style: TextStyle(color: Color(0xFF464655), fontSize: 18.0, fontFamily: 'BarlowCondensed'),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10.0, 7.0, 5.0, 7.0),
                                      child: Container(child: LeaguesDropdown()),
                                      decoration:
                                          BoxDecoration(boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 5.0, offset: Offset(5.0, 5.0))], color: Color(0xFF464655)),
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
                                      padding: EdgeInsets.fromLTRB(10.0, 7.0, 5.0, 7.0),
                                      child: Container(child: ClubsDropdown()),
                                      decoration:
                                          BoxDecoration(boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 5.0, offset: Offset(5.0, 5.0))], color: Color(0xFF464655)),
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
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'LOAD',
                                                  style: TextStyle(fontSize: 25.0, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed'),
                                                ),
                                                Text('SAVED PRESET', style: TextStyle(fontSize: 15.0, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed'))
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
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'SAVE',
                                                  style: TextStyle(fontSize: 25.0, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed'),
                                                ),
                                                Text('THIS SETUP', style: TextStyle(fontSize: 15.0, color: Color(0xFF9999AC), fontFamily: 'BarlowCondensed'))
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
                                    Expanded(child: StartButton(onTap: null, buttonTitle: "START"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                    padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 10.0),
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
                                                _selectedPlayer1 != null ? _selectedPlayer1.height != null ? _selectedPlayer1.height : "-" : kPlayerParamDisabled.data,
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
                                                _selectedPlayer2 != null ? _selectedPlayer2.height != null ? _selectedPlayer2.height : "-" : kPlayerParamDisabled.data,
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
                                                _selectedPlayer3 != null ? _selectedPlayer3.height != null ? _selectedPlayer3.height : "-" : kPlayerParamDisabled.data,
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
                                                _selectedPlayer4 != null ? _selectedPlayer4.height != null ? _selectedPlayer4.height : "-" : kPlayerParamDisabled.data,
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
                                                _selectedPlayer5 != null ? _selectedPlayer5.height != null ? _selectedPlayer5.height : "-" : kPlayerParamDisabled.data,
                                                style: kPlayerParamTextStyle,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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
                                                _selectedPlayer1 != null ? _selectedPlayer1.height != null ? "45 cm" : "-" : "-",
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
                                                _selectedPlayer2 != null ? _selectedPlayer2.height != null ? "45 cm" : "-" : "-",
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
                                                _selectedPlayer3 != null ? _selectedPlayer3.height != null ? "45 cm" : "-" : "-",
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
                                                _selectedPlayer4 != null ? _selectedPlayer4.height != null ? "45 cm" : "-" : "-",
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
                                                _selectedPlayer5 != null ? _selectedPlayer5.height != null ? "45 cm" : "-" : "-",
                                                style: kPlayerParamTextStyle,
                                              )
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
                      flex: 4,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
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
                                    child: Icon(
                                      FontAwesomeIcons.caretDown,
                                      color: Color(0xFF191926),
                                      size: 60.0,
                                    ),
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
                                          padding: const EdgeInsets.only(top: 60.0),
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
                                                  if (this._selectedClub != null) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CupertinoAlertDialog(
                                                            title: Text("Choose player"),
                                                            actions: <Widget>[
                                                              CupertinoDialogAction(
                                                                child: Text("Disable siluette"),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _selectedPlayer1 = null;
                                                                    isActiveSiluete1 = false;
                                                                  });
                                                                  Navigator.pop(context, 'Disable');
                                                                },
                                                              )
                                                            ],
                                                            content: Container(
                                                              width: 500,
                                                              height: 500,
                                                              child: FutureBuilder<List<Player>>(
                                                                future: _players,
                                                                builder: (context, snapshot) {
                                                                  switch (snapshot.connectionState) {
                                                                    case ConnectionState.none:
                                                                    case ConnectionState.waiting:
                                                                      return Text("Loading...");
                                                                    default:
                                                                      if (snapshot.hasError) {
                                                                        return Text('Error: ${snapshot.error}');
                                                                      } else {
                                                                        return ListView.builder(
                                                                            itemCount: snapshot.data.length,
                                                                            itemBuilder: (context, index) {
                                                                              return Card(
                                                                                child: ListTile(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      _selectedPlayer1 = snapshot.data[index];
                                                                                      isActiveSiluete1 = true;
                                                                                      Navigator.pop(context, 'Cancel');
                                                                                    });
                                                                                  },
                                                                                  leading: Icon(Icons.accessibility),
                                                                                  title: Text(snapshot.data[index].playerName),
                                                                                  subtitle:
                                                                                      Text("Height: ${snapshot.data[index].height != null ? snapshot.data[index].height : "No "
                                                                                              "data"}, "
                                                                                          "Position: ${snapshot.data[index].position != null ? snapshot.data[index].position : "-"
                                                                                              ""}"),
                                                                                ),
                                                                              );
                                                                            });
                                                                      }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        });
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
                                                siluete: isActiveSiluete1 == true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "1",
                                                        batteryLevel: 1,
                                                        numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                        playerName: _selectedPlayer1.lastName != null ? _selectedPlayer1.lastName.toUpperCase() : "",
                                                        playerNumber: _selectedPlayer1.number != null ? _selectedPlayer1.number.toString() : "1",
                                                        kragna: _selectedClub.collarColor != null ? getColorFromString(_selectedClub.collarColor) : Color(0xFFFF0000),
                                                        shirtColor: _selectedClub.shirtColor != null ? getColorFromString(_selectedClub.shirtColor) : Color(0xFF243479),
                                                        playerNameColor: _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                        playerNumberColor: _selectedClub.numberColor != null ? getColorFromString(_selectedClub.numberColor) : Color(0xFFFF0000),
                                                        playerNumberStrokeColor:
                                                            _selectedClub.numBorderColor != null ? getColorFromString(_selectedClub.numBorderColor) : Colors.white,
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
                                                    if (this._selectedClub != null) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CupertinoAlertDialog(
                                                              title: Text("Choose player"),
                                                              actions: <Widget>[
                                                                CupertinoDialogAction(
                                                                  child: Text("Disable siluette"),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      _selectedPlayer2 = null;
                                                                      isActiveSiluete2 = false;
                                                                    });
                                                                    Navigator.pop(context, 'Disable');
                                                                  },
                                                                )
                                                              ],
                                                              content: Container(
                                                                height: 500,
                                                                child: FutureBuilder<List<Player>>(
                                                                  future: _players,
                                                                  builder: (context, snapshot) {
                                                                    switch (snapshot.connectionState) {
                                                                      case ConnectionState.none:
                                                                      case ConnectionState.waiting:
                                                                        return Text("Loading...");
                                                                      default:
                                                                        if (snapshot.hasError) {
                                                                          return Text('Error: ${snapshot.error}');
                                                                        } else {
                                                                          return ListView.builder(
                                                                              itemCount: snapshot.data.length,
                                                                              itemBuilder: (context, index) {
                                                                                return Card(
                                                                                  child: ListTile(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        _selectedPlayer2 = snapshot.data[index];
                                                                                        isActiveSiluete2 = true;
                                                                                        Navigator.pop(context, 'Cancel');
                                                                                      });
                                                                                    },
                                                                                    leading: Icon(Icons.accessibility),
                                                                                    title: Text(snapshot.data[index].playerName),
                                                                                    subtitle: Text("Height: ${snapshot.data[index].height != null ? snapshot.data[index].height : "-"
                                                                                        "-"}, Position: ${snapshot.data[index].position != null ? snapshot.data[index].position : "-"
                                                                                        ""}"),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        }
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) => CupertinoAlertDialog(
                                                                title: Text("Warninng!"),
                                                                content: Text("Please choose oponnent!"),
                                                                actions: <Widget>[
                                                                  CupertinoDialogAction(
                                                                    onPressed: () => Navigator.pop(context, 'Discard'),
                                                                    isDefaultAction: true,
                                                                    child: Text("Close"),
                                                                  )
                                                                ],
                                                              ));
                                                    }
                                                  });
                                                },
                                                siluete: isActiveSiluete2 == true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "2",
                                                        batteryLevel: 2,
                                                        numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                        playerName: _selectedPlayer2.lastName.toUpperCase(),
                                                        playerNumber: _selectedPlayer2.number != null ? _selectedPlayer2.number.toString() : "1",
                                                        kragna: _selectedClub.collarColor != null ? getColorFromString(_selectedClub.collarColor) : Color(0xFFFF0000),
                                                        shirtColor: _selectedClub.shirtColor != null ? getColorFromString(_selectedClub.shirtColor) : Color(0xFF243479),
                                                        playerNameColor: _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                        playerNumberColor: _selectedClub.numberColor != null ? getColorFromString(_selectedClub.numberColor) : Color(0xFFFF0000),
                                                        playerNumberStrokeColor:
                                                            _selectedClub.numBorderColor != null ? getColorFromString(_selectedClub.numBorderColor) : Colors.white,
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
                                                  //tu otvori Cupertino
                                                  setState(() {
                                                    if (this._selectedClub != null) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CupertinoAlertDialog(
                                                              title: Text("Choose player"),
                                                              actions: <Widget>[
                                                                CupertinoDialogAction(
                                                                  child: Text("Disable siluette"),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      _selectedPlayer3 = null;
                                                                      isActiveSiluete3 = false;
                                                                    });
                                                                    Navigator.pop(context, 'Disable');
                                                                  },
                                                                )
                                                              ],
                                                              content: Container(
                                                                height: 500,
                                                                child: FutureBuilder<List<Player>>(
                                                                  future: _players,
                                                                  builder: (context, snapshot) {
                                                                    switch (snapshot.connectionState) {
                                                                      case ConnectionState.none:
                                                                      case ConnectionState.waiting:
                                                                        return Text("Loading...");
                                                                      default:
                                                                        if (snapshot.hasError) {
                                                                          return Text('Error: ${snapshot.error}');
                                                                        } else {
                                                                          return ListView.builder(
                                                                              itemCount: snapshot.data.length,
                                                                              itemBuilder: (context, index) {
                                                                                return Card(
                                                                                  child: ListTile(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        _selectedPlayer3 = snapshot.data[index];
                                                                                        isActiveSiluete3 = true;
                                                                                        Navigator.pop(context, 'Cancel');
                                                                                      });
                                                                                    },
                                                                                    leading: Icon(Icons.accessibility),
                                                                                    title: Text(snapshot.data[index].playerName),
                                                                                    subtitle: Text("Height: ${snapshot.data[index].height != null ? snapshot.data[index].height : "-"
                                                                                        "-"}, Position: ${snapshot.data[index].position != null ? snapshot.data[index].position : "-"
                                                                                        ""}"),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        }
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) => CupertinoAlertDialog(
                                                                title: Text("Warninng!"),
                                                                content: Text("Please choose oponnent!"),
                                                                actions: <Widget>[
                                                                  CupertinoDialogAction(
                                                                    onPressed: () => Navigator.pop(context, 'Discard'),
                                                                    isDefaultAction: true,
                                                                    child: Text("Close"),
                                                                  )
                                                                ],
                                                              ));
                                                    }
                                                  });
                                                },
                                                siluete: isActiveSiluete3 == true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "3",
                                                        batteryLevel: 3,
                                                        numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                        playerName: _selectedPlayer3.lastName.toUpperCase(),
                                                        playerNumber: _selectedPlayer3.number != null ? _selectedPlayer3.number.toString() : "1",
                                                        kragna: _selectedClub.collarColor != null ? getColorFromString(_selectedClub.collarColor) : Color(0xFFFF0000),
                                                        shirtColor: _selectedClub.shirtColor != null ? getColorFromString(_selectedClub.shirtColor) : Color(0xFF243479),
                                                        playerNameColor: _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                        playerNumberColor: _selectedClub.numberColor != null ? getColorFromString(_selectedClub.numberColor) : Color(0xFFFF0000),
                                                        playerNumberStrokeColor:
                                                            _selectedClub.numBorderColor != null ? getColorFromString(_selectedClub.numBorderColor) : Colors.white,
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
                                                    if (this._selectedClub != null) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CupertinoAlertDialog(
                                                              title: Text("Choose player"),
                                                              actions: <Widget>[
                                                                CupertinoDialogAction(
                                                                  child: Text("Disable siluette"),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      _selectedPlayer4 = null;
                                                                      isActiveSiluete4 = false;
                                                                    });
                                                                    Navigator.pop(context, 'Disable');
                                                                  },
                                                                )
                                                              ],
                                                              content: Container(
                                                                height: 500,
                                                                child: FutureBuilder<List<Player>>(
                                                                  future: _players,
                                                                  builder: (context, snapshot) {
                                                                    switch (snapshot.connectionState) {
                                                                      case ConnectionState.none:
                                                                      case ConnectionState.waiting:
                                                                        return Text("Loading...");
                                                                      default:
                                                                        if (snapshot.hasError) {
                                                                          return Text('Error: ${snapshot.error}');
                                                                        } else {
                                                                          return ListView.builder(
                                                                              itemCount: snapshot.data.length,
                                                                              itemBuilder: (context, index) {
                                                                                return Card(
                                                                                  child: ListTile(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        _selectedPlayer4 = snapshot.data[index];
                                                                                        isActiveSiluete4 = true;
                                                                                        Navigator.pop(context, 'Cancel');
                                                                                      });
                                                                                    },
                                                                                    leading: Icon(Icons.accessibility),
                                                                                    title: Text(snapshot.data[index].playerName),
                                                                                    subtitle: Text("Height: ${snapshot.data[index].height != null ? snapshot.data[index].height : "-"
                                                                                        "-"}, Position: ${snapshot.data[index].position != null ? snapshot.data[index].position : "-"
                                                                                        ""}"),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        }
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) => CupertinoAlertDialog(
                                                                title: Text("Warninng!"),
                                                                content: Text("Please choose oponnent!"),
                                                                actions: <Widget>[
                                                                  CupertinoDialogAction(
                                                                    onPressed: () => Navigator.pop(context, 'Discard'),
                                                                    isDefaultAction: true,
                                                                    child: Text("Close"),
                                                                  )
                                                                ],
                                                              ));
                                                    }
                                                  });
                                                },
                                                siluete: isActiveSiluete4 == true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "4",
                                                        batteryLevel: 4,
                                                        numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                        playerName: _selectedPlayer4.lastName.toUpperCase(),
                                                        playerNumber: _selectedPlayer4.number != null ? _selectedPlayer4.number.toString() : "1",
                                                        kragna: _selectedClub.collarColor != null ? getColorFromString(_selectedClub.collarColor) : Color(0xFFFF0000),
                                                        shirtColor: _selectedClub.shirtColor != null ? getColorFromString(_selectedClub.shirtColor) : Color(0xFF243479),
                                                        playerNameColor: _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                        playerNumberColor: _selectedClub.numberColor != null ? getColorFromString(_selectedClub.numberColor) : Color(0xFFFF0000),
                                                        playerNumberStrokeColor:
                                                            _selectedClub.numBorderColor != null ? getColorFromString(_selectedClub.numBorderColor) : Colors.white,
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
                                                    if (this._selectedClub != null) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return CupertinoAlertDialog(
                                                              title: Text("Choose player"),
                                                              actions: <Widget>[
                                                                CupertinoDialogAction(
                                                                  child: Text("Disable siluette"),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      _selectedPlayer5 = null;
                                                                      isActiveSiluete5 = false;
                                                                    });
                                                                    Navigator.pop(context, 'Disable');
                                                                  },
                                                                )
                                                              ],
                                                              content: Container(
                                                                height: 500,
                                                                child: FutureBuilder<List<Player>>(
                                                                  future: _players,
                                                                  builder: (context, snapshot) {
                                                                    switch (snapshot.connectionState) {
                                                                      case ConnectionState.none:
                                                                      case ConnectionState.waiting:
                                                                        return Text("Loading...");
                                                                      default:
                                                                        if (snapshot.hasError) {
                                                                          return Text('Error: ${snapshot.error}');
                                                                        } else {
                                                                          return ListView.builder(
                                                                              itemCount: snapshot.data.length,
                                                                              itemBuilder: (context, index) {
                                                                                return Card(
                                                                                  child: ListTile(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        _selectedPlayer5 = snapshot.data[index];
                                                                                        isActiveSiluete5 = true;
                                                                                        Navigator.pop(context, 'Cancel');
                                                                                      });
                                                                                    },
                                                                                    leading: Icon(Icons.accessibility),
                                                                                    title: Text(snapshot.data[index].playerName),
                                                                                    subtitle: Text("Height: ${snapshot.data[index].height != null ? snapshot.data[index].height : "-"
                                                                                        "-"}, Position: ${snapshot.data[index].position != null ? snapshot.data[index].position : "-"
                                                                                        ""}"),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        }
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) => CupertinoAlertDialog(
                                                                title: Text("Warninng!"),
                                                                content: Text("Please choose oponnent!"),
                                                                actions: <Widget>[
                                                                  CupertinoDialogAction(
                                                                    onPressed: () => Navigator.pop(context, 'Discard'),
                                                                    isDefaultAction: true,
                                                                    child: Text("Close"),
                                                                  )
                                                                ],
                                                              ));
                                                    }
                                                  });
                                                },
                                                siluete: isActiveSiluete5 == true
                                                    ? ActiveSilueteDuelDesigner(
                                                        image: kDDActiveSiluete,
                                                        number: "5",
                                                        batteryLevel: 4,
                                                        numAndEmptyIndicatorColor: emptyIndicatorDD,
                                                        playerName: _selectedPlayer5.lastName.toUpperCase(),
                                                        playerNumber: _selectedPlayer5.number != null ? _selectedPlayer5.number.toString() : "1",
                                                        kragna: _selectedClub.collarColor != null ? getColorFromString(_selectedClub.collarColor) : Color(0xFFFF0000),
                                                        shirtColor: _selectedClub.shirtColor != null ? getColorFromString(_selectedClub.shirtColor) : Color(0xFF243479),
                                                        playerNameColor: _selectedClub.nameColor != null ? getColorFromString(_selectedClub.nameColor) : Colors.white,
                                                        playerNumberColor: _selectedClub.numberColor != null ? getColorFromString(_selectedClub.numberColor) : Color(0xFFFF0000),
                                                        playerNumberStrokeColor:
                                                            _selectedClub.numBorderColor != null ? getColorFromString(_selectedClub.numBorderColor) : Colors.white,
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
                                padding: const EdgeInsets.only(left: 120.0, right: 57.0),
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
                                          border: Border(left: BorderSide(width: 1, color: Color(0xFF9999AC)), bottom: BorderSide(width: 1, color: Color(0xFF9999AC)))),
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
                                          style: TextStyle(fontSize: 20.0, color: Color(0xFF9999AC)),
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
                                          border: Border(right: BorderSide(width: 1, color: Color(0xFF9999AC)), bottom: BorderSide(width: 1, color: Color(0xFF9999AC)))),
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
