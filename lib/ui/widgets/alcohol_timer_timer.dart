import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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

