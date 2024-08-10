import 'package:flutter/material.dart';

// color theme
class AppColors {
  static const Color mainColor = Color(0xff44B678);
  static const Color accentColor = Color(0xff05F7C0);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color grey = Color(0xffD9D9D9);
}

// font theme
class TextBlack extends StatelessWidget {
  final String string;
  final double size;
  final Color color;

  const TextBlack({super.key, required this.string, required this.size, this.color = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontFamily:'NotoSans',
          fontWeight: FontWeight.w900),
    );
  }
}
class TextMedium extends StatelessWidget {
  final String string;
  final double size;
  final Color color;
  final TextAlign align;

  const TextMedium({super.key, required this.string, required this.size, this.color = AppColors.black, this.align = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontFamily:'NotoSans',
          fontWeight: FontWeight.w500),
      textAlign: align,
    );
  }
}
class TextRegular extends StatelessWidget {
  final String string;
  final double size;
  final Color color;

  const TextRegular({super.key, required this.string, required this.size, this.color = AppColors.black});

  @override
  Widget build(BuildContext context) {

    return Text(
      string,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontFamily:'NotoSans',
          fontWeight: FontWeight.w400),
    );
  }
}

//icons
class AppIcons {
  static String get safeDrivingOff => 'assets/icons/safe_driving_black_32.png';
  static String get safeDrivingOn => 'assets/icons/safe_driving_accent_32.png';
  static String get alcoholTimerPageOff => 'assets/icons/alcohol_timer_black_24.png';
  static String get alcoholTimerPageOn => 'assets/icons/alcohol_timer_accent_24.png';
  static String get navigationPageOff => 'assets/icons/navigation_black_24.png';
  static String get navigationPageOn => 'assets/icons/navigation_accent_24.png';
  static String get settingPageOff => 'assets/icons/settings_black_24.png';
  static String get settingPageOn => 'assets/icons/settings_accent_24.png';
}

