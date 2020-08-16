import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final String label;
  final String icon;
  double fontSizeTitle;
  double iconSize;
  double paddingCard;
  double cardHeight;
  Color textColor;
  Color iconColor;

  CardContent({this.label, this.icon, this.fontSizeTitle, this.iconSize, this.paddingCard, this.cardHeight, this.textColor, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: Padding(
        padding: EdgeInsets.all(paddingCard),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                label,
                style: TextStyle(color: textColor, fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(
              icon,
              height: iconSize,
              color: iconColor,
            )
          ],
        ),
      ),
    );
  }
}
