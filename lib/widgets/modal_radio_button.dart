import 'package:flutter/material.dart';

class ModalRadioButton extends StatelessWidget {
  bool isSelected;
  final String text;

  ModalRadioButton(this.isSelected, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 8.0,
            //color: isSelected ? Color(0xFF9999AC) : Color(0xFF242131),
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Color(0xFF000000), blurRadius: isSelected ? 5.0 : 0.0, offset: Offset(isSelected ? 5.0 : 0.0, isSelected ? 5.0 : 0.0))],
                color: isSelected ? Color(0xFF9999AC) : Color(0xFF242131)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(text, style: TextStyle(color: Color(0xFF9999AC), fontSize: 20.0, fontFamily: 'BarlowCondensed')),
          )
        ],
      ),
    );
  }
}
