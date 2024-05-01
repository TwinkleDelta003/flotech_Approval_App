import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'ColorConfig.dart';

class CustomText extends StatelessWidget {
  final String data;
  final double fSize;
  final Color fColor;
  final FontWeight fWeight;
  final TextAlign align;

  const CustomText(
      {Key key,
      @required this.data,
      this.fSize,
      this.fColor,
      this.fWeight,
      this.align})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: align,
      style: TextStyle(
          fontSize: fSize,
          color: fColor ?? ColorConfig.primaryAppColor,
          fontWeight: fWeight),
    );
  }
}

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback press;

  const CustomRichText(
      {@required this.firstText,
      @required this.secondText,
      @required this.press});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: firstText,
          style: TextStyle(color: ColorConfig.primaryAppColor, fontSize: 18),
          children: <TextSpan>[
            TextSpan(
                text: secondText,
                style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                recognizer: TapGestureRecognizer()..onTap = press)
          ]),
    );
  }
}
