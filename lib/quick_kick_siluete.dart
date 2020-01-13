import 'package:flutter/material.dart';

class QuickKickSiluete extends StatelessWidget {
  final Function onPress;
  final bool isActiveSiluete;
  final Widget siluete;

  QuickKickSiluete({this.onPress, this.isActiveSiluete, this.siluete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: siluete,
    );
  }
}
