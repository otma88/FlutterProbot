import 'package:flutter/material.dart';
import '../constants.dart';

class ActiveSilueteQuickKick extends StatelessWidget {
  final String image;
  final String number;
  final int batteryLevel;
  final Color numAndEmptyIndicatorColor;

  ActiveSilueteQuickKick({this.image, this.number, this.batteryLevel, this.numAndEmptyIndicatorColor});

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
              bottom: 105,
              left: 40,
              child: Text(
                number,
                style: TextStyle(color: numAndEmptyIndicatorColor, fontSize: 30.0, fontWeight: FontWeight.w500, fontFamily: 'BarlowCondensed'),
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
                        color: batteryLevel == 4 ? whiteIndicator : numAndEmptyIndicatorColor,
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: batteryLevel == 3 || batteryLevel == 4 ? whiteIndicator : numAndEmptyIndicatorColor,
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: batteryLevel == 2 || batteryLevel == 3 || batteryLevel == 4 ? whiteIndicator : numAndEmptyIndicatorColor,
                        width: 35,
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        color: batteryLevel == 1 ? redIndicator : whiteIndicator,
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
