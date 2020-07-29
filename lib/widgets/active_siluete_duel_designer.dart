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
  final double silueteSize;
  final double numberPositionBottom;
  final double numberFontSize;
  final double batteryLevelPositionBottom;
  final double batteryLevelBoxHeight;
  final double batteryLevelBoxWidth;
  final double batteryIndicatorHeight;
  final double batteryIndicatorWidth;
  final double kragnaTopPosition;
  final double kragnaWidth;
  final double kragnaPositionRight;
  final double shirtTopPosition;
  final double shirtWidth;
  final double shirtRightPosition;
  final double playerNameTopPosition;
  final double playerNameRightPosition;
  final double playerNameBoxHeight;
  final double playerNameBoxWidth;
  final double playerNumberTopPosition;
  final double playerNumberRightPosition;
  final double playerNumberFontSize;

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
      this.playerNumberStrokeColor,
      this.batteryIndicatorWidth,
      this.batteryIndicatorHeight,
      this.batteryLevelBoxWidth,
      this.batteryLevelBoxHeight,
      this.batteryLevelPositionBottom,
      this.numberFontSize,
      this.numberPositionBottom,
      this.silueteSize,
      this.kragnaTopPosition,
      this.kragnaWidth,
      this.kragnaPositionRight,
      this.shirtRightPosition,
      this.shirtTopPosition,
      this.shirtWidth,
      this.playerNameBoxHeight,
      this.playerNameBoxWidth,
      this.playerNameRightPosition,
      this.playerNameTopPosition,
      this.playerNumberRightPosition,
      this.playerNumberTopPosition,
      this.playerNumberFontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(image, fit: BoxFit.fill, height: silueteSize),
          Positioned.fill(
              top: kragnaTopPosition,
              right: kragnaPositionRight,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  kKragna,
                  color: kragna,
                  width: kragnaWidth,
                ),
              )),
          Positioned.fill(
            top: shirtTopPosition,
            right: shirtRightPosition,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                kDres,
                width: shirtWidth,
                color: shirtColor,
              ),
            ),
          ),
          Positioned.fill(
              top: playerNameTopPosition,
              right: playerNameRightPosition,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: playerNameBoxWidth,
                    height: playerNameBoxHeight,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Center(
                            child: Text(
                          playerName,
                          style: TextStyle(fontFamily: 'BarlowCondensed', color: playerNameColor, fontWeight: FontWeight.bold),
                        )))),
              )),
          Positioned.fill(
              top: playerNumberTopPosition,
              right: playerNumberRightPosition,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      playerNumber,
                      style: TextStyle(
                          fontSize: playerNumberFontSize,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Barlow',
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = playerNumberStrokeColor),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      playerNumber,
                      style: TextStyle(
                        fontSize: playerNumberFontSize,
                        color: playerNumberColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Barlow',
                      ),
                    ),
                  )
                ],
              )),
          Positioned.fill(
              bottom: numberPositionBottom,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: TextStyle(
                      color: numAndEmptyIndicatorColor, fontSize: numberFontSize, fontWeight: FontWeight.w500, fontFamily: 'BarlowCondensed'),
                ),
              )),
          Positioned.fill(
            bottom: batteryLevelPositionBottom,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: batteryLevelBoxHeight,
                width: batteryLevelBoxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          color: batteryLevel == 4 ? whiteIndicator : numAndEmptyIndicatorColor,
                          width: batteryIndicatorWidth,
                          height: batteryIndicatorHeight,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          color: batteryLevel == 3 || batteryLevel == 4 ? whiteIndicator : numAndEmptyIndicatorColor,
                          width: batteryIndicatorWidth,
                          height: batteryIndicatorHeight,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          color: batteryLevel == 2 || batteryLevel == 3 || batteryLevel == 4 ? whiteIndicator : numAndEmptyIndicatorColor,
                          width: batteryIndicatorWidth,
                          height: batteryIndicatorHeight,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          color: batteryLevel == 1 ? redIndicator : whiteIndicator,
                          width: batteryIndicatorWidth,
                          height: batteryIndicatorHeight,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
