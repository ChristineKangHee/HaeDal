import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'theme.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  static late ThemeProvider _themeProvider;

  factory ThemeManager(BuildContext context) {
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return _instance;
  }

  ThemeManager._internal();

  // 현재 테마의 CustomColors 객체 반환
  static CustomColors get customColors {
    return _themeProvider.isLightTheme
        ? lightThemeGlobal.extension<CustomColors>()!
        : darkThemeGlobal.extension<CustomColors>()!;
  }

  // 현재 ThemeMode 반환
  static ThemeMode get currentThemeMode {
    return _themeProvider.themeMode;
  }
}
