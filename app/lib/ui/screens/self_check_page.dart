import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/widgets/custom_radio.dart';
import 'package:collection/collection.dart';

class SelfCheckPage extends StatefulWidget {
  const SelfCheckPage({Key? key}) : super(key: key);

  @override
  State<SelfCheckPage> createState() => _SelfCheckPageState();
}

class _SelfCheckPageState extends State<SelfCheckPage> {
  List<String> questions = [
    "얼마나 자주 술을 마십니까?",
    "술을 마시는 날은 보통 몇 잔을 마십니까?",
    "한 번 술좌석에서 6잔 이상을 마시는 횟수는 몇 번입니까?",
    "지난 1년간, 일단 술을 마시기 시작하여 자제가 안 된 적이 있습니까?",
    "지난 1년간, 과음 후 다음날 아침 정신을 차리기 위해 해장술을 마신 적이 있습니까?",
    "지난 1년간, 음주 후 술을 마신 것에 대해 후회한 적이 있습니까?",
    "지난 1년간, 술이 깬 후에 취중의 일을 기억할 수 없었던 적이 있습니까?",
  ];


  List<int> selectedAnswerIndex = List<int>.filled(7, 0); // 초기 선택값
  List<Color> radioColors = <Color>[
    Color(0xff4169E1),
    Color(0xff6787E7),
    Color(0xff8DA5ED),
    Color(0xffB3B3B3),
    Color(0xffF89DA5),
    Color(0xffF67C87),
    Color(0xffF45B69),

  ];

  Widget buildQuestion(int index, Size size) {
    return Column(
      children: [
        text16w4(
          questions[index],
        ),
        SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            7,
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
                  kOuterRadius: (answerIndex - 3).abs().toDouble() * 2 + 7,
                  kInnerRadius: (answerIndex - 3).abs().toDouble() * 2 + 4,
                  color: radioColors[answerIndex],
                ),
                SizedBox(
                  width: size.width*0.2/6,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Divider(
          color: ColorStyles.sgrey,
        )
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
              SizedBox(
                height: size.width * 0.25,
              ),
              Text(
                "Can I Drive?",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                "Test Yourself!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: ColorStyles.sblue),
              ),
              SizedBox(
                height: size.width * 0.18,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.1, right: size.width * 0.1),
                child: Column(
                  children: List.generate(
                      questions.length, (index) => buildQuestion(index, size)),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  _testResult(context, selectedAnswerIndex);
                  print(selectedAnswerIndex);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ));
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorStyles.sblue,
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}

// 7~49
// 28 35 42 49
// 정상 주의 경계 심각
// normal warning alert serious

void _testResult(BuildContext context, List<int> selectedAnswerIndex) {

  int score = ((selectedAnswerIndex.sum)*100/49).round();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: text24w6("Test Result"),
            content: text16w4('your score is $score. if you higher than 50, you need to be careful.'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: text16w4('OK'))
            ],
          );
        });
  });
}
