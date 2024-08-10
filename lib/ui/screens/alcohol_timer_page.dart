import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ice_d/theme.dart';
import 'package:ice_d/ui/widgets/alcohol_timer_timer.dart';
import 'package:ice_d/ui/widgets/alcohol_timer_form.dart';
import 'package:ice_d/app_state.dart';
import 'package:ice_d/timer_provider.dart';



class AlcoholTimerPage extends StatefulWidget {
  const AlcoholTimerPage({super.key});

  @override
  State<AlcoholTimerPage> createState() => _AlcoholTimerPageState();
}

class _AlcoholTimerPageState extends State<AlcoholTimerPage> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<AlcoholTimerFormState> alcoholTimerFormKey = GlobalKey<AlcoholTimerFormState>();
  bool isBtnActivated = false;
  double? alcohol = 0;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final timerProvider = Provider.of<TimerProvider>(context);


    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20,),
              SizedBox(
                  width: deviceWidth*0.8,
                  height: deviceWidth*0.8,
                  child: Stack(alignment: Alignment.center, children: [
                    Consumer<TimerProvider>(
                      builder: (context, timerProvider, child) {
                        final leftHour = timerProvider.leftHour;
                        final leftMin = timerProvider.leftMin;
                        final totalHour = timerProvider.hour;
                        final totalMin = timerProvider.min;
                        return AlcoholTimerWidget(
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
                            ? TimerTime(deviceWidth, timerProvider)
                            : TimerText(deviceWidth);
                      },
                    )
                  ])),
              const SizedBox(height: 38,),
              Consumer<AppState>(
                builder: (context, appState, child) {
                  return appState.isTimerRunning
                      ? AlcoholTimerText()
                      : Column(children: [Form(
                    key: formKey,
                    child: AlcoholTimerFormWidget(key: alcoholTimerFormKey,isBtnActivated: isBtnActivated),
                    onChanged: (){
                      setState(() {
                        isBtnActivated = formKey.currentState!.validate();
                      });
                    },
                  ),
                    const SizedBox(height: 38,),
                    ElevatedButton(
                        onPressed: () async {
                          if (isBtnActivated){
                            formKey.currentState!.save();
                            alcohol = alcoholTimerFormKey.currentState?.calAlcohol();
                            context.read<AppState>().setTimerRunning(true);
                            print(alcohol);

                            final timerProvider = Provider.of<TimerProvider>(context, listen: false);
                            final appState = Provider.of<AppState>(context, listen: false);
                            int leftHour = (alcohol! / 0.015).floor();
                            int leftMin = (((alcohol! / 0.015) - leftHour) * 60).floor();
                            timerProvider.setTimer(leftHour, leftMin);
                            timerProvider.startTimer(appState);
                          } else {

                          }
                        },
                        child: TextRegular(string: '타이머 시작', size: 20,),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith((state){
                            if (isBtnActivated) {
                              return AppColors.mainColor;
                            }
                            else{
                              return AppColors.grey;
                            }
                          },
                          ),)
                    )],);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}



class AlcoholTimerText extends StatefulWidget {
  const AlcoholTimerText({super.key});

  @override
  State<AlcoholTimerText> createState() => _AlcoholTimerTextState();
}

class _AlcoholTimerTextState extends State<AlcoholTimerText> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, timerProvider, child) {
        final leftHour = timerProvider.leftHour;
        final leftMin = timerProvider.leftMin;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextMedium(string: '운전 가능할 때까지', size: 32, align: TextAlign.center,),
            TextBlack(string: '${leftHour}시간 $leftMin분', size: 64,),
            TextMedium(string: '남았습니다.', size: 32, align: TextAlign.center,),
          ],
        );
      },
    );
  }
}
