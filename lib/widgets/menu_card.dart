import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  MenuCard({@required this.colour, this.cardChild});

  final Color colour;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(1.0),
          boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: 8.0, offset: Offset(7.0, 7.0))]),
    );
  }
}
