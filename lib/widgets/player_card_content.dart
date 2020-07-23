import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PlayerCardContent extends StatelessWidget {
  double cardHeight;
  double paddingCard;
  final String label;
  Color textColor;
  double fontSizeTitle;
  final String icon;
  double iconSize;
  Color iconColor;
  final String labelPlayer;
  Color textPlayerColor;
  double fontSizePlayer;
  final String labelPlayerNumber;
  Color textPlayeNumberColor;
  double fontSizePlayerNumber;

  PlayerCardContent(
      {this.cardHeight,
      this.paddingCard,
      this.label,
      this.textColor,
      this.fontSizeTitle,
      this.icon,
      this.iconColor,
      this.iconSize,
      this.labelPlayer,
      this.fontSizePlayer,
      this.textPlayerColor,
      this.labelPlayerNumber,
      this.fontSizePlayerNumber,
      this.textPlayeNumberColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 15,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            label,
                            style: TextStyle(color: textColor, fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            labelPlayer,
                            style: TextStyle(color: textPlayerColor, fontSize: fontSizePlayer),
                          ),
                          Text(
                            labelPlayerNumber,
                            style: TextStyle(color: textPlayeNumberColor, fontSize: fontSizePlayerNumber),
                          )
                        ],
                      ),
                      Image.asset(
                        icon,
                        height: iconSize,
                        color: iconColor,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Color(0xFF2D2D3C),
                    child: SizedBox(),
                  ),
                )
              ],
            );
          },
          itemCount: 5,
          control: SwiperControl(),
          pagination: SwiperPagination(
            builder: SwiperPagination.dots,
          )),
    );
  }
}
