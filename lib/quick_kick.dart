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

String dropdownValue = 'Easy';

class _QuickKickPageState extends State<QuickKickPage> {
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
                            Icon(
                              Icons.arrow_back,
                              size: 50.0,
                              color: Color(0xFF9999AC),
                            ),
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
                        margin: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: <Widget>[
                            Text("fdgfgffgdfgdg"),
                            DropdownButton(
                                value: dropdownValue,
                                elevation: 16,
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Color(0xFF3FA9F5),
                                ),
                                iconSize: 30,
                                underline: Container(
                                  height: 2,
                                  color: Colors.blue,
                                ),
                                items: <String>[
                                  'Easy',
                                  'Medium',
                                  'Hard'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value), //ovdje odraditi style
                                  );
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                })
                          ],
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              color: Color(0xFF242432),
              height: 200.0,
              width: 200.0,
              child: Text("gdsgdfgd"),
            )
          ],
        ),
      ),
    );
  }
}
