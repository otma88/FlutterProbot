import 'package:flutter/material.dart';


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
          )
        ),
      ),
    );
  }
}
