import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:ice_d/theme.dart';

class AlcoholTimerWidget extends StatefulWidget {
  const AlcoholTimerWidget({super.key});

  @override
  State<AlcoholTimerWidget> createState() => _AlcoholTimerWidgetState();
}

class _AlcoholTimerWidgetState extends State<AlcoholTimerWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return PieChart(PieChartData(
      startDegreeOffset: -90,
      sections: [
        PieChartSectionData(
          value: 1,
          color: AppColors.grey,
          radius: deviceWidth*0.2,
          showTitle: false
        ),
        PieChartSectionData(
            value: 1,
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

