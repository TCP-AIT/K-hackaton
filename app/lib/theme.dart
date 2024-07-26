import 'package:flutter/material.dart';


class ColorStyles {
  static const Color sblue = Color(0xff4169E1);
  static const Color sblack = Color(0xff000000);
  static const Color sgrey = Color(0xffd9d9d9);
  static const Color swhite = Color(0xffffffff);
  static const Color sred = Color(0xffF45B69);
}

// w600
// 24, 32, 48
Widget text24w6(String string) {
  return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      child: Text(
        string,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: "Noto_Serif"),
        textAlign: TextAlign.center,
      ));
}

Widget text32w6(String string) {
  return Container(
    margin: EdgeInsets.only(top: 4, bottom: 4),
    child: Text(
      string,
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, fontFamily: "Noto_Serif"),
      textAlign: TextAlign.center,
    ),
  );
}

Widget text48w6(String string) {
  return Container(
    margin: EdgeInsets.only(top: 4, bottom: 4),
    child: Text(
      string,
      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600, fontFamily: "Noto_Serif"),
      textAlign: TextAlign.center,
    ),
  );
}

// w400
// 16
Widget text16w4(String string) {
  return Container(
    margin: EdgeInsets.only(top: 4, bottom: 4),
    child: Text(
      string,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Noto_Serif"),
      textAlign: TextAlign.center,
    ),
  );
}
