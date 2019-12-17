import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

  class IconList extends StatelessWidget {
  static const String assetsDir = "assets/icons/";

  final String assetName;
  final double height;
  final double width;
  final Color color;

  IconList.close({this.height, this.width, this.color}) : assetName = assetsDir + "btn_close.svg";

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      color: color,
    );
  }
}
