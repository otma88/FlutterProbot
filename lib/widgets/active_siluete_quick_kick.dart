import 'package:flutter/material.dart';
import '../constants.dart';

class ActiveSilueteQuickKick extends StatelessWidget {
  final String image;
  final String number;
  final int batteryLevel;
  final Color numAndEmptyIndicatorColor;
  final double silueteSize;
  final double numberPositionBottom;
  final double numberFontSize;
  final double batteryLevelPositionBottom;
  final double batteryLevelBoxHeight;
  final double batteryLevelBoxWidth;
  final double batteryIndicatorHeight;
  final double batteryIndicatorWidth;

  ActiveSilueteQuickKick(
      {this.image,
      this.number,
      this.batteryLevel,
      this.numAndEmptyIndicatorColor,
      this.silueteSize,
      this.numberPositionBottom,
      this.numberFontSize,
      this.batteryLevelPositionBottom,
      this.batteryLevelBoxHeight,
      this.batteryLevelBoxWidth,
      this.batteryIndicatorHeight,
      this.batteryIndicatorWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(
            image,
            fit: BoxFit.fill,
            height: silueteSize,
          ),
          Positioned.fill(
              bottom: numberPositionBottom,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: TextStyle(color: numAndEmptyIndicatorColor, fontSize: numberFontSize, fontWeight: FontWeight.w500, fontFamily: 'BarlowCondensed'),
                ),
              )),
          Positioned.fill(
            bottom: this.batteryLevelPositionBottom,
            child: Align(
              alignment: Alignment.bottomCenter,
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
