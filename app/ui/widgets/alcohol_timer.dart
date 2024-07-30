import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme.dart';

class AlcoholTimer extends StatefulWidget {
  final int totalTime;
  final int leftTime;

  const AlcoholTimer({super.key, required this.totalTime, required this.leftTime});

  @override
  State<AlcoholTimer> createState() => _AlcoholTimerState();
}

class _AlcoholTimerState extends State<AlcoholTimer> {
  late int totalTime;
  late int leftTime;

  @override
  void initState() {
    super.initState();
    totalTime = widget.totalTime;
    leftTime = widget.leftTime;
  }

  @override
  void didUpdateWidget(AlcoholTimer oldWidget) {
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
    final Size size = MediaQuery.of(context).size;

    return PieChart(PieChartData(
      startDegreeOffset: -90,
      sections: [
        PieChartSectionData(
          value: (totalTime - leftTime).toDouble(),
          color: ColorStyles.sgrey,
          radius: size.width * 0.15,
          showTitle: false,
        ),
        PieChartSectionData(
          value: leftTime.toDouble(),
          color: ColorStyles.sblue,
          radius: size.width * 0.15,
          showTitle: false,
        ),
      ],
      centerSpaceRadius: size.width * 0.25,
      centerSpaceColor: Colors.white,
    ));
  }
}




