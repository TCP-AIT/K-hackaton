import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ice_d/theme.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool settingTimerSound = false;
  bool settingTimerVib = false;
  bool settingDriveSound = false;
  bool settingDriveVib = false;

  //final AudioCache _audioCache = AudioCache(prefix: 'assets/sound/');
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      settingTimerSound = prefs.getBool('settingTimerSound') ?? false;
      settingTimerVib = prefs.getBool('settingTimerVib') ?? false;
      settingDriveSound = prefs.getBool('settingDriveSound') ?? false;
      settingDriveVib = prefs.getBool('settingDriveVib') ?? false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _playSound() async {
    if (settingTimerSound || settingDriveSound) {
      //_audioCache.play(UrlSource('sound_normal.mp3'));
      player.play(AssetSource('sounds/basic_alarm.wav'));
    }
  }

  void _vibrate() async {
    if (settingTimerVib || settingDriveVib) {
      Vibration.vibrate(duration: 500);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            TextMedium(string: "알코올 타이머", size: 16),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black, width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: TextMedium(string: "소리", size: 16),
                            ),
                          ),
                          Switch(
                            value: settingTimerSound,
                            onChanged: (value) {
                              setState(() {
                                settingTimerSound = value;
                              });
                              _saveSetting('settingTimerSound', value);
                              if (value) _playSound();
                            },
                            activeColor: AppColors.black,
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: TextMedium(string: "진동", size: 16),
                            ),
                          ),
                          Switch(
                            value: settingTimerVib,
                            onChanged: (value) {
                              setState(() {
                                settingTimerVib = value;
                              });
                              _saveSetting('settingTimerVib', value);
                              if (value) _vibrate();
                            },
                            activeColor: AppColors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextMedium(string: "안전운전 모드", size: 16),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black, width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: TextMedium(string: "소리", size: 16),
                            ),
                          ),
                          Switch(
                            value: settingDriveSound,
                            onChanged: (value) {
                              setState(() {
                                settingDriveSound = value;
                              });
                              _saveSetting('settingDriveSound', value);
                              if (value) _playSound();
                            },
                            activeColor: AppColors.black,
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: TextMedium(string: "진동", size: 16),
                            ),
                          ),
                          Switch(
                            value: settingDriveVib,
                            onChanged: (value) {
                              setState(() {
                                settingDriveVib = value;
                              });
                              _saveSetting('settingDriveVib', value);
                              if (value) _vibrate();
                            },
                            activeColor: AppColors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}