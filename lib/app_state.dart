import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool _isTimerRunning = false;
  bool _isSending = false;
  bool _isTimerSoundOn = false;
  bool _isDriveSoundOn = false;
  BuildContext? _context;

  bool get isSending => _isSending;
  bool get isTimerRunning => _isTimerRunning;
  bool get isTimerSoundOn => _isTimerSoundOn;
  bool get isDriveSoundOn => _isDriveSoundOn;
  BuildContext get context => _context!;

  void setTimerRunning(bool value) {
    _isTimerRunning = value;
    notifyListeners();
  }

  void setSending(bool isSending) {
    _isSending = isSending;
    notifyListeners();
  }

  void setTimerSound(bool isTimerSoundOn) {
    _isTimerSoundOn = isTimerSoundOn;
    notifyListeners();
  }

  void setDriveSound(bool isDriveSoundOn) {
    _isDriveSoundOn = isDriveSoundOn;
    notifyListeners();
  }

  void setContext(BuildContext context) {
    _context = context;
  }
}