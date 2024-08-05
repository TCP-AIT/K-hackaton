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
              Form(
                key: formKey,
                child: AlcoholTimerForm(key: alcoholTimerFormKey,isBtnActivated: isBtnActivated),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget TimerText(width) {
  return Container( //alcohol timer 로 빼기
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.white,
    ),
    width: width * 0.5,
    height: width * 0.5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextMedium(string: "Did you drank?", size: 16,),
        TextMedium(string: "please fill in the form below", size: 16,)
      ],
    ),
  );
}

Widget TimerTime(width, TimerProvider timerProvider) {
  return Consumer<TimerProvider>(builder: (context, timerProvider, child) {
    int leftHour = timerProvider.leftHour;
    int leftMin = timerProvider.leftMin;

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
      width: width * 0.5,
      height: width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextMedium(string: leftHour.toString(), size: 20,),
          Container(
            height: 1,
            width: width * 0.5 * 0.15,
            color: AppColors.black,
          ),
          TextMedium(string: leftMin.toString(), size: 20,),
        ],
      ),
    );
  });
  // int? leftHour = timerProvider.hour;
  // int? leftMin = timerProvider.min;
  //

}

// double _calAlcohol(){
//   return
// }

// form 입력 완? -> 버튼 활성화
// 버튼 누르면 알코올 계산해야 함. 계산은.. 일단 하려면 그 값들을 받아와야 하거든?
// alcohol_timer_form에 다 있는데 그 걔네들을 가져와야 해.? 그치 아님 그 form 파일에서 isBtnActivated 받아와서 거기서 계산하는 것도 괜찮을 듯?
// 결국 그 계산으로 필요한 거는 시간이니까 그리고 그 시간값만 넘기거나 뭐 그런 식으로 가면 될 거 같은데
// 버튼 활성화 && clicked? -> 타이머 활성화
// 타이머 활성화? -> 활성화된 타이머 표시 & 타이머 시작
// 타이머 끝? -> 타이머 비활성화