import 'dart:async';
import 'package:flutter/material.dart';

import 'app_state.dart';
import 'theme.dart';

class TimerProvider with ChangeNotifier {
  int leftHour;
  int leftMin;
  int? hour;
  int? min;
  Timer? _timer;

  TimerProvider(this.leftHour, this.leftMin) {
    setTimer(leftHour, leftMin);
  }

  //todo 제출 전 seconds -> minutes로 변경
  void startTimer(AppState appState) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (leftHour == 0 && leftMin == 0) {
        _alertTimeEnded(appState.context);
        appState.setTimerRunning(false);
        _timer?.cancel();
        print("timer ended");
      } else {
        if (leftMin == 0) {
          leftHour--;
          leftMin = 59;
        } else {
          leftMin--;
        }
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void setTimer(int hours, int minutes) {
    leftHour = hours;
    leftMin = minutes;
    hour = hours;
    min = minutes;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _alertTimeEnded(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: TextMedium(string: 'Time is ended. Now you can drive again!', size: 16),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: TextMedium(string: 'OK', size: 16,))
              ],
            );
          });
    });
  }
}
