import 'package:flutter/material.dart';
import 'bottom_sheet_icons_icons.dart';

class ModalItem extends StatelessWidget {
  final String name;
  final int number;
  double iconSize;
  double playerItemHeight;
  double numberFontSize;
  double playerNameFontSize;

  ModalItem(this.name, this.number, this.iconSize, this.playerItemHeight, this.numberFontSize, this.playerNameFontSize);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: Color(0xFF9C96AE),
            child: Icon(
              BottomSheetIcons.no_photo,
              size: iconSize,
              color: Color(0xFF484452),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Container(
              height: playerItemHeight,
              color: Color(0xFF191526),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      number.toString(),
                      style: TextStyle(fontSize: numberFontSize, fontWeight: FontWeight.bold),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name.toUpperCase(),
                        style: TextStyle(fontSize: playerNameFontSize, fontFamily: 'BarlowCondensed'),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ))
      ],
    );
  }
}
