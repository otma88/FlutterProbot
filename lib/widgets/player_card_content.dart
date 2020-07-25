import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:probot/widgets/bottom_sheet_icons_icons.dart';

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
  double swiperControlSize;
  double swiperControlPadding;
  double fractionFontSize;

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
      this.textPlayeNumberColor,
      this.swiperControlSize,
      this.swiperControlPadding,
      this.fractionFontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 4.0, left: paddingCard, right: paddingCard, top: paddingCard),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            label,
                            style: TextStyle(color: textColor, fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            labelPlayer,
                            style: TextStyle(
                                color: textPlayerColor,
                                fontSize: fontSizePlayer,
                                fontFamily: "BarlowCondensed",
                                height: 0.6,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            labelPlayerNumber,
                            style: TextStyle(
                                color: textPlayeNumberColor,
                                fontSize: fontSizePlayerNumber,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.bold,
                                height: 0.9),
                          )
                        ],
                      ),
                      Icon(
                        BottomSheetIcons.no_photo,
                        size: iconSize,
                        color: iconColor,
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          itemCount: 8,
          control: SwiperControl(color: Colors.white, size: swiperControlSize, padding: EdgeInsets.only(top: swiperControlPadding)),
          pagination: SwiperPagination(
              builder: FractionPaginationBuilder(
                  fontSize: fractionFontSize, activeFontSize: fractionFontSize, color: Colors.white, activeColor: Colors.white),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(0.0)),
          controller: SwiperController(),
        ),
      ),

//          pagination: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
//            final double activeSize = 10.0;
//            final double size = 10.0;
//            Color activeColor = Colors.amberAccent;
//            Color color = Colors.brown;
//            List<Widget> list = [];
//
//            int itemCount = config.itemCount;
//            int activeIndex = config.activeIndex;
//
//            for (int i = 0; i < itemCount; i++) {
//              bool active = i == activeIndex;
//
//              for (int i = 0; i < itemCount; ++i) {
//                bool active = i == activeIndex;
//                list.add(Container(
//                  key: Key("pagination_$i"),
//                  margin: EdgeInsets.all(8.0),
//                  child: ClipOval(
//                    child: Container(
//                      color: active ? activeColor : color,
//                      width: active ? activeSize : size,
//                      height: active ? activeSize : size,
//                    ),
//                  ),
//                ));
//              }
//
////              list.add(Container(
////                key: Key("pagination_$i"),
////                child: Container(
////                  height: 5,
////                  width: 16,
////                  color: Colors.amber,
////                ),
////              ));
//
////              list.add(
////                Stack(
////                  children: <Widget>[
////                    Positioned(
////                      bottom: -3,
////                      left: 0,
////                      child: Container(
////                        key: Key("pagination_$i"),
////                        height: 11,
////                        width: 16,
////                        decoration: BoxDecoration(
////                            color: Color(0xFF3FA9F5),
////                            borderRadius: BorderRadius.circular(2.0),
////                            boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 3.0, offset: Offset(1.0, 1.0))]),
////                        child: Padding(
////                          padding: const EdgeInsets.all(2.0),
////                          child: Image.asset('images/icons/sliderIcon.png'),
////                        ),
////                      ),
////                    )
////                  ],
////                  overflow: Overflow.visible,
////                ),
////              );
//            }
//
////            return Column(
////              mainAxisAlignment: MainAxisAlignment.end,
////              key: key,
////              children: <Widget>[
////                Container(
////                  height: 5.0,
////                  color: Color(0xFF2D2D3C),
////                  child: Column(
////                    children: list,
////                    key: key,
////                    mainAxisSize: MainAxisSize.min,
////                  ),
////                ),
////              ],
////            );
//          })),
    );
  }
}
