import 'package:flutter/material.dart';
import '../constants.dart';

class ActiveSilueteDuelDesigner extends StatelessWidget {
  final String image;
  final String number;
  final int batteryLevel;
  final Color numAndEmptyIndicatorColor;
  final String playerName;
  final String playerNumber;
  final Color kragna;
  final Color shirtColor;
  final Color playerNameColor;
  final Color playerNumberColor;
  final Color playerNumberStrokeColor;

  ActiveSilueteDuelDesigner(
      {this.image,
      this.number,
      this.batteryLevel,
      this.numAndEmptyIndicatorColor,
      this.playerName,
      this.playerNumber,
      this.kragna,
      this.shirtColor,
      this.playerNameColor,
      this.playerNumberColor,
      this.playerNumberStrokeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(image, fit: BoxFit.fill, height: 400),
          Positioned(
              top: 48,
              left: 21,
              child: Image.asset(
                kKragna,
                color: kragna,
                width: 56,
              )),
          Positioned(
            top: 54,
            left: 6,
            child: Image.asset(
              kDres,
              width: 86,
              color: shirtColor,
            ),
          ),
          Positioned(
              top: 63,
              left: 8,
              child: Container(
                  width: 82,
                  height: 20,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Center(
                          child: Text(
                        playerName,
                        style: TextStyle(fontFamily: 'BarlowCondensed', color: playerNameColor, fontSize: 40.0, fontWeight: FontWeight.bold),
                      ))))),
          Positioned(
              top: 77,
              left: 14,
              child: Container(
                width: 70,
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Text(
                        playerNumber,
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Barlow',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = playerNumberStrokeColor),
                      ),
                      Text(
                        playerNumber,
                        style: TextStyle(
                          fontSize: 50.0,
                          color: playerNumberColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Barlow',
                        ),
                      )
                    ],
                  ),
                ),
              )),
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
