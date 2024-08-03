import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ice_d/theme.dart';
import 'alcohol_timer_form_field.dart';


class AlcoholTimerForm extends StatefulWidget {
  bool isBtnActivated = false;

  AlcoholTimerForm({super.key, required isBtnActivated});

  @override
  State<AlcoholTimerForm> createState() => _AlcoholTimerFormState();
}

class _AlcoholTimerFormState extends State<AlcoholTimerForm> {
  String _sex = '남성';
  double _sexWeight = 0;
  double _weight = 0;
  String _drink = '소주';
  double _alcohol = 0;
  double _drinkAmount = 0;
  String _time = '90분 내';
  double _timeNum = 0;


  final List<String> _drinks = ['소주', '맥주', '와인', '위스키'];
  final List<String> _times = ['90분 내', '2시간 내','3시간 내','4시간 내','5시간 내','6시간 내','7시간 내','8시간 내','9시간 내','10시간 내','11시간 내','12시간 내'];
  //final List<String> _defaultAlcohol = [];
  //todo _drinks 선택에 따라 _defaultAlcohol이 initial value에 보이게

  final List<String> _labels = ['성별', '몸무게', '주류 종류', '마신 양', '음주한 시간'];
  final List<String> _errorMsgs = ['','','','',''];

  double _calAlcohol(){
    if(_sex == '남성'){
      _sexWeight = 0.86;
    } else{
      _sexWeight = 0.64;
    }

    if(_time == '90분 내'){
      _timeNum = 1.5;
    }else{
      _timeNum = double.parse(_time.replaceAll('시간 내', ''));
    }

    double bac = ((_drinkAmount*_alcohol*0.7894*0.7)/(_weight*_sexWeight)-(0.015*_timeNum));

    return double.parse(bac.toStringAsFixed(3));
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final List<Widget> renderForm = [
      FormFieldToggle(sex: _sex, onErrorChanged: (String msg){setState((){_errorMsgs[0] = msg;});}),
      Row(children: [
        FormFieldText(value: _weight, label: '몸무게', onErrorChanged: (String msg){setState((){_errorMsgs[1] = msg;});}),
        const SizedBox(width: 4.0,),
        const TextMedium(string: 'kg', size: 16)],
      ),
      Row(
        children: [
          FormFieldDropdown(
              options: _drinks,
              value: _drink,
              onChanged: (String? newValue){
                setState((){
                  _drink = newValue!;
                })
                ;}),
          SizedBox(width: deviceWidth*0.03,),
          FormFieldText(value: _alcohol, label: '알코올 도수', onErrorChanged: (String msg){setState((){_errorMsgs[2] = msg;});}),
          const SizedBox(width: 4.0,),
          const TextMedium(string: '%', size: 16,)
        ],
      ),
      Row(
        children: [
          FormFieldText(value: _drinkAmount, label: '마신 양', onErrorChanged: (String msg){setState((){_errorMsgs[3] = msg;});}),
          SizedBox(width: deviceWidth*0.03,),
          const TextMedium(string: 'ml', size: 16,)
        ],
      ),
      FormFieldDropdown
        (options: _times,
          value: _time,
          width: deviceWidth*0.5,
          onChanged: (String? newValue){
            setState((){
              _time = newValue!;
            });
          }
        )
    ];

    return Column(
      children: [
        for(int i=0; i<5; i++)
          SizedBox(
            height: 70,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(left: deviceWidth*0.1, child: TextMedium(string: _labels[i], size: 20,)),
                Positioned(left: deviceWidth*0.4, child: renderForm[i]),
                Positioned(left: deviceWidth*0.4, top: 46,
                    child: TextRegular(
                      string: _errorMsgs[i],
                      size: 12,
                      color: Colors.red,
                    ))
              ],
            ),
          )
      ],
    );
  }
}

//todo errorMsg 띄우는 건 버튼 눌렀을 때에만 보이게..

