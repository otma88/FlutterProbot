import 'package:flutter/material.dart';

class InactiveSiluete extends StatelessWidget {
  final String image;
  final String number;

  InactiveSiluete({this.image, this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset(
            image,
            fit: BoxFit.fill,
            height: 400,
          ),
          Positioned(
              bottom: 105,
              left: 40,
              child: Text(
                number,
                style: TextStyle(
                    color: Color(0xFF191926),
                    fontSize: 30.0,
                    fontFamily: 'BarlowCondensed',
                    fontWeight: FontWeight.w500),
              )),
          Positioned(
            child: Text(
              "DETACHED",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF191926),
                  fontFamily: 'BarlowCondensed'),
            ),
            top: 63,
            left: 22,
          )
        ],
      ),
    );
  }
}
