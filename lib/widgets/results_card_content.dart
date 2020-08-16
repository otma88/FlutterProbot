import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultsCardContent extends StatelessWidget {
  double cardHeight;
  double paddingCard;
  String cardTitle;
  Color titleColor;
  double fontSizeTitle;
  String playerName;
  Color textPlayerColor;
  double fontSizePlayer;
  String rankNumber;
  double fontSizeNumber;
  double fontSizeInClubRank;
  String rankNumberSufix;
  double fontSizeNumberSufix;

  ResultsCardContent(
      {this.cardHeight,
      this.paddingCard,
      this.titleColor,
      this.cardTitle,
      this.fontSizeTitle,
      this.playerName,
      this.textPlayerColor,
      this.fontSizePlayer,
      this.rankNumber,
      this.fontSizeNumber,
      this.fontSizeInClubRank,
      this.rankNumberSufix,
      this.fontSizeNumberSufix});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: Padding(
        padding: EdgeInsets.all(paddingCard),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cardTitle,
                      style: TextStyle(color: titleColor, fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      playerName,
                      style: TextStyle(color: textPlayerColor, fontSize: fontSizePlayer, fontFamily: "BarlowCondensed", fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 11.0),
                        child: Text(
                          rankNumber,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                              fontSize: fontSizeNumber,
                              height: 0.9,
                              fontFamily: "Barlow",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        rankNumberSufix,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: fontSizeNumberSufix,
                          fontFamily: "Barlow",
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "IN-CLUB RANKING",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: fontSizeInClubRank,
                      fontFamily: "BarlowCondensed",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
