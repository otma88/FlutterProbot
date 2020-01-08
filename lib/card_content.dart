import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final String title;
  final IconData icon;

  CardContent(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 50.0),
        ),
        SizedBox(
          width: 15.0,
        ),
        Icon(
          icon,
          size: 55.0,
        ),
      ],
    );
  }
}
