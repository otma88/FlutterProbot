import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final String label;
  final String icon;

  CardContent({this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              label,
              style: TextStyle(color: Color(0xFF9999AC), fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),
          Image.asset(
            icon,
            height: 80.0,
            color: Color(0xFF3FA9F5),
          )
        ],
      ),
    );
  }
}
