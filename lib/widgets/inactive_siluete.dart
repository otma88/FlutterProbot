import 'package:flutter/material.dart';

class InactiveSiluete extends StatelessWidget {
  final String image;
  final String number;
  double silueteSize;
  double numberPositionBottom;
  double numberFontSize;
  double detachedPositionTop;
  double detachedPositionLeft;
  double detachedFontSIze;

  InactiveSiluete(
      {this.image,
      this.number,
      this.silueteSize,
      this.numberPositionBottom,
      this.detachedPositionLeft,
      this.numberFontSize,
      this.detachedPositionTop,
      this.detachedFontSIze});

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
                  style: TextStyle(color: Color(0xFF191926), fontSize: numberFontSize, fontFamily: 'BarlowCondensed', fontWeight: FontWeight.w500),
                ),
              )),
          Positioned(
            child: Text(
              "DETACHED",
              style: TextStyle(fontSize: detachedFontSIze, color: Color(0xFF191926), fontFamily: 'BarlowCondensed', fontWeight: FontWeight.bold),
            ),
            top: detachedPositionTop,
            left: detachedPositionLeft,
          )
        ],
      ),
    );
  }
}
