import 'package:flutter/material.dart';
import 'menu_card.dart';
import 'card_content.dart';

class TrainerMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff2D2D3C),
        scaffoldBackgroundColor: Color(0xff2D2D3C),
      ),
      home: TrainerModePage(title: 'TRAINER MODE'),
    );
  }
}

class TrainerModePage extends StatefulWidget {
  TrainerModePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TrainerModePageState createState() => _TrainerModePageState();
}

class _TrainerModePageState extends State<TrainerModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/logo_shadow.png'),
          fit: BoxFit.fill,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.arrow_back,
                      size: 50.0,
                      color: Color.fromRGBO(255, 255, 255, 0.9),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    child: Text(
                      'TRAINER MODE',
                      style: TextStyle(
                          fontSize: 55.0,
                          fontFamily: 'Barlow',
                          color: Color(0xFF191926),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Icon(
                        Icons.dehaze,
                        size: 50.0,
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                      ),
                    ))
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      onTap: () {},
                      child: MenuCard(
                        colour: Colors.blueGrey,
                        cardChild: CardContent(title, icon),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {},
                      child: MenuCard(
                        colour: Colors.blueGrey,
                        cardChild: Text('DUEL DESIGNER'),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {},
                      child: MenuCard(
                        colour: Colors.blueGrey,
                        cardChild: Text('DUEL DESIGNER'),
                      ),
                    ))
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
