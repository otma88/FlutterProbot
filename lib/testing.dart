import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

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

  final String url = 'http://probot-backend.test:88/api/auth/leagues';
  final String accessToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQ1ODE3NmZjNmU4ZjZiNTdhOTkyNTFkNjMzN2Y0OTg5OTFmY2FjODRlNzNmMThmYzllYTQyZmUwYjY3NDMxMjZhM2UwYjNmODA2OTkzYzQ4In0.eyJhdWQiOiIyIiwianRpIjoiZDU4MTc2ZmM2ZThmNmI1N2E5OTI1MWQ2MzM3ZjQ5ODk5MWZjYWM4NGU3M2YxOGZjOWVhNDJmZTBiNjc0MzEyNmEzZTBiM2Y4MDY5OTNjNDgiLCJpYXQiOjE1Nzk4NTExMTQsIm5iZiI6MTU3OTg1MTExNCwiZXhwIjoxNjExNDczNTE0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.FbycSmizotdOEC6zll8QTmH8filtAzj8oiJ8Qp8XGyP5NUMEs5V3fO48f86coxeijw5iK_BmnGTy7ag_hIRNAmpcCCyZPVXxyWtvpHCCiqbAFRtpwx7U4NAObXIX2P8JL45DGKocYNjRv6PGDKfwB3_y7G8WeilU8UFZfyYiGva48Td6R7cKzpRSs8tMxZ1Ivqed4PAizHvuf1tLoxk1ESrfqxTwogBFfLLFfE0OIGq2feSaDRYUN-rDjNJ7GkxA_PS_x_zTye9oHt2CSQoyNgYGXHG_cViKYZf09DQjVGp0HPttnYSu0O2lFW7_-3mjfNjIggTyJiACU-HshEBJtdR51U0T4xob6C64wF4BKxJfRci7KlxFlCDOER1i41nroyhgF5roX26P89ZvX5WyPAL-j9xxoznjxoWXmr4SA4jgiYJI8BykT40z2ZVkaSU8Js2p-zMPBOMNnKuOchK17LtTTKTdzzvdd0KNp4bWKjk6CUsvfMeXt5uq2poKKeadjGbkfxZhOdwY1L_aUvLNLgmRQaCa_NdT-_lzo-t447XF4a9AxJ5U4_dBXXATrUetAEwokVmrYLFiLixDQdB1yplVTeoik9qPr8cVlM9M4zjOqEWzsW3rFQh-TmLo472Z0ABja1-PC5NGPi49KbcRGClaAufC5NooZOlUChzc9tY';

  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(url),
        headers: {HttpHeaders.authorizationHeader: accessToken});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

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
          items: data.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['item_name']),
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
