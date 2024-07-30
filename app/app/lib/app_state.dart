import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool _isTimerRunning = false;
  BuildContext? _context;

  bool get isTimerRunning => _isTimerRunning;
  BuildContext get context => _context!;

  void setTimerRunning(bool value) {
    _isTimerRunning = value;
    notifyListeners();
  }

  void setContext(BuildContext context) {
    _context = context;
  }
}