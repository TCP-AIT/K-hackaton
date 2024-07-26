import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/theme.dart';
import 'package:app/app_state.dart';
import 'package:app/timer_provider.dart';
import 'package:app/ui/widgets/alcohol_timer.dart';
import 'package:app/ui/widgets/drink_form.dart';


class AlcoholTimerPage extends StatefulWidget {
  AlcoholTimerPage({super.key});

  @override
  State<AlcoholTimerPage> createState() => _AlcoholTimerPageState();
}

class _AlcoholTimerPageState extends State<AlcoholTimerPage> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      backgroundColor: ColorStyles.swhite,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
          SizedBox(height: size.width * 0.15),
          SizedBox(
              width: size.width * 0.8,
              height: size.width * 0.8,
              child: Stack(alignment: Alignment.center, children: [
                Consumer<TimerProvider>(
                  builder: (context, timerProvider, child) {
                    final leftHour = timerProvider.leftHour;
                    final leftMin = timerProvider.leftMin;
                    final totalHour = timerProvider.hour;
                    final totalMin = timerProvider.min;
                    return AlcoholTimer(
                      totalTime: (totalMin! == 0 && totalHour! == 0)
                          ? 1
                          : 60 * totalHour! + totalMin,
                      leftTime: (totalMin == 0 && totalHour == 0)
                          ? 1
                          : 60 * leftHour + leftMin, // default = 0
                    );
                  },
                ),
                Consumer<AppState>(
                  builder: (context, appState, child) {
                    return appState.isTimerRunning
                        ? TimerTime(size, timerProvider)
                        : TimerText(size);
                  },
                )
              ])),
          SizedBox(height: size.width * 0.1),
          Consumer<AppState>(
            builder: (context, appState, child) {
              return appState.isTimerRunning
                  ? DrinkInfo()
                  : DrinkForm();
            },)
            // DrinkForm(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget TimerText(size) {
  return Container( //alcohol timer 로 빼기
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: ColorStyles.swhite,
    ),
    width: size.width * 0.5,
    height: size.width * 0.5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        text24w6("Did you drank?"),
        text16w4("please fill in the form below")
      ],
    ),
  );
}

Widget TimerTime(size, TimerProvider timerProvider) {
  return Consumer<TimerProvider>(builder: (context, timerProvider, child) {
    int leftHour = timerProvider.leftHour;
    int leftMin = timerProvider.leftMin;

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorStyles.swhite,
      ),
      width: size.width * 0.5,
      height: size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text32w6(leftHour.toString()),
          Container(
            height: 1,
            width: size.width * 0.5 * 0.15,
            color: ColorStyles.sblack,
          ),
          text32w6(leftMin.toString())
        ],
      ),
    );
  });
  // int? leftHour = timerProvider.hour;
  // int? leftMin = timerProvider.min;
  //

}

class DrinkInfo extends StatefulWidget {
  const DrinkInfo({super.key});

  @override
  State<DrinkInfo> createState() => _DrinkInfoState();
}

class _DrinkInfoState extends State<DrinkInfo> {
  String? _selectedUnit;
  String? _selectedDrink;
  String? _selectedHours;
  final numController = TextEditingController();

  Future<void> _loadDrinkInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedUnit = prefs.getString('unit');
      _selectedDrink = prefs.getString('drink');
      _selectedHours = prefs.getString('hours');
      numController.text = prefs.getString('num') ?? '';
    });
  }

  @override
  void initState() {
    _loadDrinkInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(builder: (context, timerProvider, child){
      final leftHour = timerProvider.leftHour;
      final leftMin = timerProvider.leftMin;

      return Column(children: [
        text24w6("You drank"),
        text24w6('${numController.text} $_selectedUnit'),
        text24w6('of $_selectedDrink'),
        text24w6('within $_selectedHours hours'),
        SizedBox(height: 20,),
        text24w6("so"),
        text24w6("you need to wait"),
        text24w6('${leftHour}h ${leftMin}m'),
        text24w6('to drive again')
        ],
      );
    }
  );
}}


