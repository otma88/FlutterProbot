import 'package:flutter/material.dart';

class DisableButton extends StatelessWidget {
  final Function onTap;
  final String buttonTitle;

  DisableButton({this.onTap, this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(color: Color(0xFF464655), boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 8.0, offset: Offset(7.0, 7.0))]),
        child: Center(
          child: Text(
            buttonTitle,
            style: TextStyle(fontSize: 15.0, color: Color(0xFF9999AC), fontWeight: FontWeight.bold, fontFamily: 'BarlowCondensed'),
          ),
        ),
      ),
    );
  }
}
