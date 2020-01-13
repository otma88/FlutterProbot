import 'package:flutter/material.dart';

const whiteIndicator = Color(0xFFFFFFFF);
const emptyIndicator = Color(0xFF338BCA);
const redIndicator = Color(0xFFC70056);

class QuickKickActiveSiluete extends StatelessWidget {
  final String image;
  final String number;
  final int batteryLevel;

  QuickKickActiveSiluete({this.image, this.number, this.batteryLevel});

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
                        color:
                            batteryLevel == 4 ? whiteIndicator : emptyIndicator,
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: batteryLevel == 3 || batteryLevel == 4
                            ? whiteIndicator
                            : emptyIndicator,
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: batteryLevel == 2 ||
                                batteryLevel == 3 ||
                                batteryLevel == 4
                            ? whiteIndicator
                            : emptyIndicator,
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color:
                            batteryLevel == 1 ? redIndicator : whiteIndicator,
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
