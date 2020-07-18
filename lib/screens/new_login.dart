import 'package:flutter/material.dart';

class NewLogin extends StatefulWidget {
  @override
  _NewLoginState createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xFF3FA9F5),
        width: double.infinity,
        height: size.height,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              height: size.height / 2,
              child: Padding(
                padding: EdgeInsets.only(left: 30.0, top: 30.0),
                child: Text(
                  "LOGIN",
                  style: TextStyle(fontSize: size.height * 0.08, color: Color(0xFF242432), fontFamily: 'Barlow', fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: size.height / 2,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: size.width / 3,
                  ),
                  Container(
                    width: size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Username:",
                            style: TextStyle(fontSize: size.height * 0.03, color: Color(0xFF1E1E28), fontFamily: 'BarlowCondensed'),
                          ),
                        ),
                        Container(
                          width: size.width / 3,
                          child: TextFormField(
                            style: TextStyle(fontSize: size.height * 0.04, color: Color(0xFF1E1E28)),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
