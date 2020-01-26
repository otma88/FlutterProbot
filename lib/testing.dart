import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MaterialApp(
      title: "Hospital Management",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _mySelection;

  final String url = 'http://probot-backend.test/api/auth/leagues';
  final String accessToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZhYzY2NzMyZWM2NGQxYTI0YTJjNmYwMGI5NzQ3ODYxMDM2MDZmNjM4MDlkY2U3OThlOWIxOWRmMTM3ZTg5NjdiNjBjMTYxM2ViNDcyMzI0In0.eyJhdWQiOiIyIiwianRpIjoiNmFjNjY3MzJlYzY0ZDFhMjRhMmM2ZjAwYjk3NDc4NjEwMzYwNmY2MzgwOWRjZTc5OGU5YjE5ZGYxMzdlODk2N2I2MGMxNjEzZWI0NzIzMjQiLCJpYXQiOjE1Nzk5NjE5NzQsIm5iZiI6MTU3OTk2MTk3NCwiZXhwIjoxNjExNTg0Mzc0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.ra7PGAVjLKqLcdJJMSPS3YxM4-gLOjpzPqNKYe5u0FbmP_PYYPjmIkuk2x6q72Q3WlqaoIfGmMRlEigt7asBTGqwOd5i2uex8DnLs6zo1kO2YRtcp6wGoK0LY8HIcSc_OeUooyJJwSeyvSosju5velIMVpnGrIfFOxgGQ7EOBS0d3JDqX7vQF5KqKByKpopEK-QgY0Ca8eUMRyR9FV8N7Y2VCgjMAEHueXfpximpbG0_RQAHu76ROl3zKO-m6IusdAL7j2286gEjgYTEoxaHUnuxJ2qLFHHn7BWqkb6Dg-8uOxi_MOGgK1iwoaujaZGlE7wdgqLznRcsa8EKdTcH7uM64uu6OZsLbfX0S6mY-AljZZGG3l5XscsE8bMwRB2Ua1stisCnyx6_5yubzvrkVne02sEx9dCmnYotLo-mKSH_fP-GeAqETFOm0wwfo8oYVQm5CJcocirjOAxDkgwk6Bi7_b6Ak_VJfpCB3u1VqIwb7YBzKkEF-gSBS6i8MkplOMIzR5rUZbwdFrhf0oLHwWV1YXneoT8HHd5Og1yYbpwqJLl-aaBF9CFXdx0OH5JyMpK5QzLcc37iOAk6t0m87p_v6DzPC-LnY4V0Fl31JWxuFjt_-5YoiIbcKny-kK6qeQROC1IMPbHv9helgk1vv70O6_EzLcu-nO5JT8Pn8gA';

  List leagues = List(); //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(url), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    });

    Map<String, dynamic> map = jsonDecode(res.body);
    List<dynamic> data = map["data"];

    setState(() {
      leagues = data;
    });

    print(leagues);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Hospital Management"),
      ),
      body: new Center(
        child: new DropdownButton(
          items: leagues.map((item) {
            return new DropdownMenuItem(
              child: Row(
                children: <Widget>[
                  SvgPicture.network(
                    item['flag'],
                    width: 50,
                    height: 50,
                  ),
                  Text(item['name']),
                ],
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal;
            });
          },
          value: _mySelection,
        ),
      ),
    );
  }
}
