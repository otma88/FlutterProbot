import 'package:flutter/cupertino.dart';
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
          control: SwiperControl(color: Colors.white, size: 10.0),
          pagination: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
            List<Widget> list = [];

            int itemCount = config.itemCount;
            int activeIndex = config.activeIndex;

            for (int i = 0; i < itemCount; i++) {
              bool active = i == activeIndex;
              list.add(
                Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: -3,
                      left: 0,
                      child: Container(
                        height: 11,
                        width: 16,
                        decoration: BoxDecoration(
                            color: Color(0xFF3FA9F5),
                            borderRadius: BorderRadius.circular(2.0),
                            boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 3.0, offset: Offset(1.0, 1.0))]),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset('images/icons/sliderIcon.png'),
                        ),
                      ),
                    )
                  ],
                  overflow: Overflow.visible,
                ),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 5.0,
                  color: Color(0xFF2D2D3C),
                  child: Column(
                    children: list,
                  ),
                ),
              ],
            );
          })),
    );
  }
}
