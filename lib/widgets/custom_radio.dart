import 'package:flutter/material.dart';
import 'package:probot/model/radio_model.dart';

class CustomRadio extends StatefulWidget {
  final ValueChanged<int> parentAction;

  final int activeButton;

  const CustomRadio({Key key, this.parentAction, this.activeButton}) : super(key: key);

  @override
  State createState() {
    return CustomRadioState(activeButton);
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> radioList = new List<RadioModel>();

  int activeNumber;
  bool active1;
  bool active2;
  bool active3;
  bool active4;
  bool active5;

  CustomRadioState(this.activeNumber);

  @override
  void initState() {
    super.initState();
    radioList.add(new RadioModel(activeNumber == 1 ? active1 = true : active1 = false, "1"));
    radioList.add(new RadioModel(activeNumber == 2 ? active2 = true : active2 = false, "2"));
    radioList.add(new RadioModel(activeNumber == 3 ? active3 = true : active3 = false, "3"));
    radioList.add(new RadioModel(activeNumber == 4 ? active4 = true : active4 = false, "4"));
    radioList.add(new RadioModel(activeNumber == 5 ? active5 = true : active5 = false, "5"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ListView.builder(
          itemCount: radioList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  radioList.forEach((element) => element.isSelected = false);
                  radioList[index].isSelected = true;
                  widget.parentAction(int.parse(radioList[index].text));
                });
              },
              child: ModalRadioItem(radioList[index]),
            );
          }),
    );
  }
}

class ModalRadioItem extends StatelessWidget {
  final RadioModel _item;
  ModalRadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 8.0,
          width: 110.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Color(0xFF000000), blurRadius: _item.isSelected ? 5.0 : 0.0, offset: Offset(_item.isSelected ? 5.0 : 0.0, _item.isSelected ? 5.0 : 0.0))
          ], color: _item.isSelected ? Color(0xFF9999AC) : Color(0xFF242131)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(_item.text, style: TextStyle(color: Color(0xFF9999AC), fontSize: 20.0, fontFamily: 'BarlowCondensed')),
        )
      ],
    );
  }
}
