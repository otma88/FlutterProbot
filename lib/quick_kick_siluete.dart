import 'package:flutter/material.dart';

class QuickKickSiluete extends StatelessWidget {
  final bool isActive;
  final String number;
  final int batteryLevel;
  String image;

  QuickKickSiluete(
      {@required this.isActive,
      @required this.number,
      @required this.batteryLevel});

  String getImage() {
    if (isActive) {
      this.image = "images/silueta-active.png";
    } else {
      this.image = "images/silueta-disabled.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(
            getImage(),
            fit: BoxFit.fill,
            height: 400,
          ),
          Positioned(
              bottom: 110,
              left: 40,
              child: Text(
                number,
                style: TextStyle(color: Color(0xFF338BCA), fontSize: 35.0),
              )),
          Positioned(
            bottom: 25,
            left: 32,
            child: Container(
              height: 65,
              width: 35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        color: Color(0xFF338BCA),
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: Color(0xFFFFFFFF),
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: Color(0xFFFFFFFF),
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: Color(0xFFFFFFFF),
                        width: 35,
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
