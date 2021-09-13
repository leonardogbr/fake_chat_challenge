import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const appColor = 0xFF1a2437;
  static final primaryAppColor = MaterialColor(appColor, {
    50: Color(appColor).withOpacity(.1),
    100: Color(appColor).withOpacity(.2),
    200: Color(appColor).withOpacity(.3),
    300: Color(appColor).withOpacity(.4),
    400: Color(appColor).withOpacity(.5),
    500: Color(appColor).withOpacity(.6),
    600: Color(appColor).withOpacity(.7),
    700: Color(appColor).withOpacity(.8),
    800: Color(appColor).withOpacity(.9),
    900: Color(appColor).withOpacity(1),
  });

  static const Color c3a4965 = Color(0xff3a4965);
  static const Color c505f79 = Color(0xff505f79);
  static const Color cd2dfe6 = Color(0xffd2dfe6);
  static const Color ce7edf4 = Color(0xffe7edf4);
  static const Color c125ad5 = Color(0xff125ad5);
  static const Color c8fa2b5 = Color(0xff8fa2b5);
  static const Color cd8e3e9 = Color(0xffd8e3e9);
  static const Color c52c7d7 = Color(0xff52c7d7);

  static const TextStyle chatListTitleStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: c3a4965,
  );

  static const TextStyle chatListTrailingStyle = TextStyle(
    fontSize: 14,
    color: c505f79,
  );

  static const TextStyle chatDetailsAppBarTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle chatMessageDateStyle = TextStyle(
    color: c8fa2b5,
  );

  static const TextStyle inputHintStyle = TextStyle(
    fontWeight: FontWeight.w300,
    color: c8fa2b5,
  );

  static const TextStyle inputTextStyle = TextStyle(
    color: c505f79,
  );
}
