import 'package:flutter/material.dart';
import 'package:app/theme.dart';
import 'package:app/ui/widgets/custom_radio.dart';
import 'package:collection/collection.dart'; // For sum extension on List

class SelfCheckPage extends StatefulWidget {
  const SelfCheckPage({Key? key}) : super(key: key);

  @override
  State<SelfCheckPage> createState() => _SelfCheckPageState();
}

class _SelfCheckPageState extends State<SelfCheckPage> {
  List<String> questions = [
    "술을 마신지 얼마나 지났습니까? (단위 : 3~4시간)",
    "지난 24시간 동안 몇 시간 수면을 취했습니까? (단위 : 2시간)",
    "수면의 질이 좋았습니까? 좋았다면 어느정도였습니까?",
    "카페인 등 각성제를 섭취하지 않았습니까?",
    "두통이나 어지러움이 없습니까?",
    "감정 상태가 안정적입니까?",
    "건강 상태가 양호합니까?",
  ];

  List<int> selectedAnswerIndex = List<int>.filled(16, 0); // Correct the length to match the number of questions
  List<Color> radioColors = <Color>[
    Color(0xffCCCCCC),
    Color(0xffAAAAAA),
    Color(0xff999999),
    Color(0xff777777),
    Color(0xff555555),
  ];

  Widget buildQuestion(int index, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          questions[index],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
                (answerIndex) => Row(
              children: [
                CustomRadio(
                  value: answerIndex,
                  groupValue: selectedAnswerIndex[index],
                  onChanged: (value) {
                    setState(() {
                      selectedAnswerIndex[index] = value!;
                    });
                  },
                  kOuterRadius: (answerIndex + 5).abs().toDouble() + 7,
                  kInnerRadius: (answerIndex + 5).abs().toDouble(),
                  color: radioColors[answerIndex],
                ),
                SizedBox(
                  width: size.width * 0.25 / 6,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Divider(color: AppColors.grey),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: size.width * 0.25),
              Text(
                "운전할 수 있나요?",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                "해당할수록 큰 동그라미(오른쪽)를 선택하세요",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: AppColors.black),
              ),
              SizedBox(height: size.width * 0.18),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
                child: Column(
                  children: List.generate(questions.length, (index) => buildQuestion(index, size)),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  _testResult(context, selectedAnswerIndex);
                  print(selectedAnswerIndex);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.black,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

void _testResult(BuildContext context, List<int> selectedAnswerIndex) {
  int score = ((selectedAnswerIndex.sum));

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("시험 결과", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          content: Text('$score.점. 20점보다 낮다면 조심해야 합니다.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  });
}
