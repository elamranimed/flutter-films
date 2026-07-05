import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  /// Current theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Update the theme mode and notify listeners.
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  /// Human-readable label for the current theme mode.
  String get themeModeLabel {
    switch (_themeMode) {
      case ThemeMode.system:
        return 'Système';
      case ThemeMode.light:
        return 'Clair';
      case ThemeMode.dark:
        return 'Sombre';
    }
  }
}
