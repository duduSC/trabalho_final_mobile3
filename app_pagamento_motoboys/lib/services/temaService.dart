import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaService {
  static const _tema = "isDark";
  final ValueNotifier<ThemeMode> temaNotifier = ValueNotifier(ThemeMode.light);

  TemaService() {
    _loadTema();
  }

  Future<void> _loadTema() async {
    final prefs = await SharedPreferences.getInstance();
    final isdarkMode = prefs.getBool(_tema) ?? false;
    temaNotifier.value = isdarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> _saveTema(bool isdarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_tema, isdarkMode);
  }

  void toggleTema() {
    final isDarkMode = temaNotifier.value == ThemeMode.dark;
    temaNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _saveTema(isDarkMode);
  }
}
