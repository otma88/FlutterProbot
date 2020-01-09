import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  MenuCard({@required this.colour, this.cardChild, this.description});

  final Color colour;
  final Widget cardChild;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            description,
            style: TextStyle(color: Color(0xFF464655), fontSize: 15.0),
          ),
          margin: EdgeInsets.fromLTRB(18.0, 150.0, 15.0, 15.0),
        ),
        Container(
          height: 200.0,
          child: cardChild,
          margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(1.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF000000),
                    blurRadius: 8.0,
                    offset: Offset(7.0, 7.0))
              ]),
        ),
      ],
    );
  }
}
