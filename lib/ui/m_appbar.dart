
import 'package:flutter/material.dart';
import 'package:flutter_app_tusa/ui/icon_list.dart';
import 'package:flutter_app_tusa/ui/m_colors.dart';



class MAppBar extends AppBar {
  //Apply shared styles to all app bar

  static final double _elevation = 0.0;
  static final Color _backgroundColor = MColors.transparent;
  static final Brightness _brightness = Brightness.light; //to show black status bar in iOS
  static final IconThemeData _iconTheme = IconThemeData(
    color: MColors.black,
  );
  // Function drawerMenuButtonOnPressed;

  // For common page, back button icon. *Android & iOS has different back icon by default:  '<-' & '<'

  MAppBar.forOthersWithCloseButton({Key key, @required BuildContext context})
      : super(
      key: key,
      elevation: _elevation,
      backgroundColor: _backgroundColor,
      brightness: _brightness,
      iconTheme: _iconTheme,
      leading: IconButton(
        padding: EdgeInsets.only(left:20),
        icon: IconList.close(width: 25, height: 25),
        onPressed: () {
          Navigator.pop(context, true);
        },
      ));

}
