import 'package:flutter/material.dart';

class DisableButtonDisable extends StatelessWidget {
  double buttonSize;
  String buttonTitle;
  double titleFontSize;

  DisableButtonDisable({this.buttonSize, this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: buttonSize,
        color: Color(0xFF464655).withOpacity(0.5),
        child: Center(
          child: Text(
            buttonTitle,
            style: TextStyle(
              fontSize: titleFontSize,
              color: Color(0xFF9999AC).withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontFamily: 'BarlowCondensed',
            ),
          ),
        ));
  }
}
