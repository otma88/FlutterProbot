import 'package:flutter/material.dart';

class MenuCardDisabled extends StatelessWidget {
  final Widget cardChild;
  final Color colour;

  MenuCardDisabled({this.cardChild, this.colour});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      color: colour,
    );
  }
}
