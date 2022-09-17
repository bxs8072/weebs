import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

class ThemeTool {
  static const dark = "dark";
  static const light = "light";

  static Color primaryColor = Colors.red;
  static Color secondaryColor = Colors.blue;

  final BuildContext context;

  ThemeTool(this.context);

  bool get isDark => ThemeProvider.controllerOf(context).currentThemeId == dark;

  Color get appBarForegroundColor => isDark ? Colors.white : Colors.black;

  void get switchTheme => ThemeProvider.controllerOf(context).nextTheme();

  TextStyle get style => GoogleFonts.lato();
}
