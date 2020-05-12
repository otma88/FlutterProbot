import 'package:flutter/material.dart';
import 'bottom_sheet_icons_icons.dart';

class ModalItem extends StatelessWidget {
  final String name;
  final String number;

  ModalItem(this.name, this.number);

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
              size: 120.0,
              color: Color(0xFF484452),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Container(
              color: Color(0xFF191526),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 46.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "18",
                      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "JORDI ALBA",
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
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
