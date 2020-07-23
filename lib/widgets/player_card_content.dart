import 'package:flutter/material.dart';

class PlayerCardContent extends StatelessWidget {
  double cardHeight;
  double paddingCard;
  final String label;
  Color textColor;
  double fontSizeTitle;
  final String icon;
  double iconSize;
  Color iconColor;
  final String labelPlayer;
  Color textPlayerColor;
  double fontSizePlayer;
  final String labelPlayerNumber;
  Color textPlayeNumberColor;
  double fontSizePlayerNumber;
  Widget sliderWidget;

  PlayerCardContent(
      {this.cardHeight,
      this.paddingCard,
      this.label,
      this.textColor,
      this.fontSizeTitle,
      this.icon,
      this.iconColor,
      this.iconSize,
      this.labelPlayer,
      this.fontSizePlayer,
      this.textPlayerColor,
      this.labelPlayerNumber,
      this.fontSizePlayerNumber,
      this.textPlayeNumberColor,
      this.sliderWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 15,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      label,
                      style: TextStyle(color: textColor, fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      labelPlayer,
                      style: TextStyle(color: textPlayerColor, fontSize: fontSizePlayer),
                    ),
                    Text(
                      labelPlayerNumber,
                      style: TextStyle(color: textPlayeNumberColor, fontSize: fontSizePlayerNumber),
                    )
                  ],
                ),
                Image.asset(
                  icon,
                  height: iconSize,
                  color: iconColor,
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFF2D2D3C),
              child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Color(0xFF2D2D3C),
                    inactiveTrackColor: Color(0xFF2D2D3C),
                    trackShape: CustomTrackShape(),
                    trackHeight: 3.0,
                    thumbColor: Color(0xFF3FA9F5),
                    thumbShape: CustomSLiderThumbRect(5.0, 10, 1, 20.0),
                  ),
                  child: sliderWidget),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTrackShape extends RectangularSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSLiderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final int min;
  final int max;

  CustomSLiderThumbRect(this.thumbRadius, this.max, this.min, this.thumbHeight);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value}) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: thumbHeight * 1.2, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = Color(0xFF3FA9F5)
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
        style: new TextStyle(fontSize: thumbHeight * .3, fontWeight: FontWeight.w700, color: sliderTheme.thumbColor, height: 0.9),
        text: '${getValue(value)}');
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter = Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    double convertRadiusToSigma(double radius) {
      return radius * 0.57735 + 0.5;
    }

    canvas.drawRRect(rRect, paint);
    canvas.drawPath(
        Path()
          ..addRect(Rect.fromPoints(Offset(-15, -15), Offset(15.0 + 15, 15.0 + 15)))
          ..addOval(Rect.fromPoints(Offset(0, 0), Offset(15.0, 15.0)))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..color = Colors.black
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(3)));

    // tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return ((max) * (value)).round().toString();
  }
//
}
