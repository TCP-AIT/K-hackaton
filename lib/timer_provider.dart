import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'app_state.dart';
import 'theme.dart';

class TimerProvider with ChangeNotifier {
  int leftHour;
  int leftMin;
  int? hour;
  int? min;
  Timer? _timer;
  bool _isPlayingSound = false;
  final AudioPlayer player = AudioPlayer();

  TimerProvider(this.leftHour, this.leftMin) {
    setTimer(leftHour, leftMin);
  }

  //todo 제출 전 seconds -> minutes로 변경
  void startTimer(AppState appState) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (leftHour == 0 && leftMin == 0) {
        print('time ended');
        _alertTimeEnded(appState.context);
        appState.setTimerRunning(false);
        _timer?.cancel();
        print(appState.isTimerSoundOn);

        if(appState.isTimerSoundOn){
          await player.play(AssetSource('sounds/alarm_sound.mp3'));
          player.setVolume(5.0);
          _isPlayingSound = true;
        }
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
                    onPressed: () async {
                      if(_isPlayingSound){
                        await player.stop();
                        _isPlayingSound = false;
                        print(_isPlayingSound);
                      };
                      Navigator.of(context).pop();
                    },
                    child: TextMedium(string: 'OK', size: 16,))
              ],
            );
          });
    });
  }
}

void _controlSound(bool isPlayingSound) async {
  final AudioPlayer player = AudioPlayer();
  await player.play(AssetSource('sounds/alarm_sound.mp3'));
  player.setVolume(5.0);
  isPlayingSound = true;
}

void _stopSound(bool isPlayingSound) async {
  print(isPlayingSound);
  if(isPlayingSound){
    final AudioPlayer player = AudioPlayer();
    await player.stop();
    isPlayingSound = false;
    print(isPlayingSound);
  }
}