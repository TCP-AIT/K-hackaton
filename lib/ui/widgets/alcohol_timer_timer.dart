import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import 'package:ice_d/app_state.dart';
import 'package:ice_d/timer_provider.dart';
import 'package:ice_d/theme.dart';

class AlcoholTimerWidget extends StatefulWidget {
  final int totalTime;
  final int leftTime;

  const AlcoholTimerWidget({super.key, required this.totalTime, required this.leftTime});

  @override
  State<AlcoholTimerWidget> createState() => _AlcoholTimerWidgetState();
}

class _AlcoholTimerWidgetState extends State<AlcoholTimerWidget> {
  late int totalTime;
  late int leftTime;

  @override
  void initState() {
    super.initState();
    totalTime = widget.totalTime;
    leftTime = widget.leftTime;
  }

  @override
  void didUpdateWidget(AlcoholTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalTime != widget.totalTime || oldWidget.leftTime != widget.leftTime) {
      setState(() {
        totalTime = widget.totalTime;
        leftTime = widget.leftTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return PieChart(PieChartData(
        startDegreeOffset: -90,
        sections: [
          PieChartSectionData(
              value:  (totalTime - leftTime).toDouble(),
              color: AppColors.grey,
              radius: deviceWidth*0.2,
              showTitle: false
          ),
          PieChartSectionData(
              value: leftTime.toDouble(),
              color: AppColors.mainColor,
              radius: deviceWidth*0.2,
              showTitle: false
          )
        ],
        centerSpaceRadius: deviceWidth*0.2,
        centerSpaceColor: AppColors.white
    ));
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
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextMedium(string: "술을 마셨나요?", size: 16, align: TextAlign.center,),
          TextMedium(string: "아래 빈 칸을 채워주세요.", size: 16, align: TextAlign.center)
        ],
      ),
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
          TextBlack(string: leftHour.toString(), size: width*0.5/4,),
          Container(
            height: 1,
            width: width * 0.5 * 0.15,
            color: AppColors.black,
          ),
          TextBlack(string: leftMin.toString(), size: width*0.5/4),
        ],
      ),
    );
  });
}


