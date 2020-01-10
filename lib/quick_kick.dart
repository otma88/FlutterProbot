import 'package:flutter/material.dart';

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
          });
        },
        value: _value,
        isExpanded: true,
        elevation: 6,
        style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w300,
            color: Color(0xFF9999AC)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 2.0, 2.0),
              child: Container(
                color: Color(0xFF2D2D3C),
                width: 300.0,
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
                                  fontSize: 50.0,
                                  color: Color(0xFF9999AC),
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
                                  color: Color(0xFF464655), fontSize: 18.0),
                            ),
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 7.0, 5.0, 7.0),
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
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[Text("fdgjdfjfgdfjo")],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
