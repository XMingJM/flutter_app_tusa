import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class MColors {


  static const Color transparent = Color(0x00000000);
  static const Color jet = Color(0xFF212121);
  static const Color asher = Color(0xFF666666);
  static const Color sterling = Color(0xFF979797);
  static const Color brown = Color(0xFFAD884C);
  static const Color grey = Color(0xFF1C3549);

  static const Color red = Color(0xFFE42313);
  static const Color black = Color(0xFF231F20);

  static const Color flamingo = Color(0xFFF7BEBD); //pink
  static const Color prussian = Color(0xFF24344A); //black blue  tnco primary color
  static const Color ivory = Color(0xFFF1E2C8); //brownish
  static const Color olive = Color(0xFF1F3433); //dark grey
  static const Color white = Color(0xFFFFFFFF);

  static Map<int, Color> primaryMaterialColorMap = {
    50: Color.fromRGBO(36, 52, 74, .1),
    100: Color.fromRGBO(36, 52, 74, .2),
    200: Color.fromRGBO(36, 52, 74, .3),
    300: Color.fromRGBO(36, 52, 74, .4),
    400: Color.fromRGBO(36, 52, 74, .5),
    500: Color.fromRGBO(36, 52, 74, .6),
    600: Color.fromRGBO(36, 52, 74, .7),
    700: Color.fromRGBO(36, 52, 74, .8),
    800: Color.fromRGBO(36, 52, 74, .9),
    900: Color.fromRGBO(36, 52, 74, 1),
  };

  static MaterialColor materialColorPrimary = MaterialColor(0xFF24344A, primaryMaterialColorMap);

}
