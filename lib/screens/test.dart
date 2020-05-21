import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:collection';

void main() {
  runApp(new MaterialApp(home: new DemoApp()));
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Nested ListView Example')),
      body: new Center(
        child: new ListView(
          children: <Widget>[
            new Container(
              height: 80.0,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: new List.generate(10, (int index) {
                  return new Card(
                    color: Colors.blue[index * 100],
                    child: new Container(
                      width: 50.0,
                      height: 50.0,
                      child: new Text("$index"),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
