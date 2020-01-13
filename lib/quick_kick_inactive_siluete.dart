import 'package:flutter/material.dart';

class QuickKickInactiveSiluete extends StatelessWidget {
  final String image;
  final String number;

  QuickKickInactiveSiluete({this.image, this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(
            image,
            fit: BoxFit.fill,
            height: 400,
          ),
          Positioned(
              bottom: 110,
              left: 40,
              child: Text(
                number,
                style: TextStyle(color: Color(0xFF191926), fontSize: 35.0),
              )),
          Positioned(
            child: Text(
              "DETACHED",
              style: TextStyle(fontSize: 12.0, color: Color(0xFF191926)),
            ),
            bottom: 310,
            left: 18,
          )
        ],
      ),
    );
  }
}
