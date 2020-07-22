import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final String label;
  final String icon;
  double fontSizeTitle;
  double iconSize;
  double paddingCard;
  double cardHeight;

  CardContent({this.label, this.icon, this.fontSizeTitle, this.iconSize, this.paddingCard, this.cardHeight});

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
                style: TextStyle(color: Color(0xFF9999AC), fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(
              icon,
              height: iconSize,
              color: Color(0xFF3FA9F5),
            )
          ],
        ),
      ),
    );
  }
}
