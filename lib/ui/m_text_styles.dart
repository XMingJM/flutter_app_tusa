
import 'package:flutter/widgets.dart';
import 'package:flutter_app_tusa/ui/m_colors.dart';

abstract class MTextStyles {
  static const String mainFontFamily = 'NeuzeitGrotesk';

  static const TextStyle mainTextStyle = TextStyle(
    color:MColors.red,
    fontSize: 18,
    fontFamily: mainFontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle headerTextStyle = TextStyle(
    color: MColors.jet,
    fontSize: 28,
    fontFamily: mainFontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
}