import 'package:flutter/material.dart';

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
                                  "DUEL DESIGNER",
                                  style: TextStyle(
                                    fontSize: 70.0,
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
                            ],
                          ),
                        )
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
