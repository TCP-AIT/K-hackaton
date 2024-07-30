import 'package:flutter/material.dart';
import '../../theme.dart';
import 'form_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:app/ui/screens/size_info.dart';
import 'package:app/app_state.dart';
import 'package:app/timer_provider.dart';

class DrinkForm extends StatefulWidget {

  const DrinkForm({super.key,});

  @override
  State<DrinkForm> createState() => _DrinkFormState();
}

class _DrinkFormState extends State<DrinkForm> {
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

  Future<void> _uploadDrinkInfo(
      String unit, String drink, String hours, String num) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('unit', unit);
      prefs.setString('drink', drink);
      prefs.setString('hours', hours);
      prefs.setString('num', num);
    });
  }

  Future<void> _checkInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('sex') == null || prefs.getString('weight') == '') {
      _alertSize(context);
    } else {
      if (prefs.getString('unit') == null ||
          prefs.getString('drink') == null ||
          prefs.getString('hours') == null ||
          prefs.getString('num') == '') {
        _alertDrink(context);
      } else {
        await _uploadDrinkInfo(_selectedUnit!, _selectedDrink!, _selectedHours!,
            numController.text);
        double alcohol = _calAlcohol(
            prefs.getString('num')!,
            prefs.getString('unit')!,
            prefs.getString('drink')!,
            prefs.getString('weight')!,
            prefs.getString('sex')!,
            prefs.getString('hours')!);
        //widget.onCalculateEnded(alcohol);

        if (alcohol<=0){
          alcohol = 0;
        }

        final timerProvider = Provider.of<TimerProvider>(context, listen: false);
        final appState = Provider.of<AppState>(context, listen: false);
        int leftHour = (alcohol / 0.015).floor();
        int leftMin = (((alcohol / 0.015) - leftHour) * 60).floor();
        timerProvider.setTimer(leftHour, leftMin);
        timerProvider.startTimer(appState);
      }
    }
  }

  double _calAlcohol(String numStr, String unitStr, String drinkStr,
      String weightStr, String sexStr, String hourStr) {
    int num = int.parse(numStr);
    int unit;
    int alcohol;
    int weight = int.parse(weightStr);
    double sex;
    int hour = int.parse(hourStr);

    if (unitStr == 'soju cups(50ml)') {
      unit = 50;
    } else if (unitStr == 'beer cups(225ml)') {
      unit = 225;
    } else if (unitStr == 'bottles(360ml)') {
      unit = 360;
    } else {
      unit = 700;
    }

    if (drinkStr == 'soju(15%)') {
      alcohol = 15;
    } else if (drinkStr == 'beer(5%)') {
      alcohol = 5;
    } else if (drinkStr == 'wine(12%)') {
      alcohol = 12;
    } else {
      alcohol = 40;
    }

    if (sexStr == 'man') {
      sex = 0.86;
    } else {
      sex = 0.64;
    }
    //
    double bac = ((0.7 * num * unit * alcohol * 0.01 * 0.7894 ) / (weight * sex * 10)) - 0.015 * (hour-1.5); // 90분 후의 알코올 도수임.
    return double.parse(bac.toStringAsFixed(3));
  }

  void _alertSize(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: text16w4('please enter your size info.'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: text16w4('OK'))
            ],
          );
        });
  }

  void _alertDrink(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: text16w4('please enter your drink info.'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: text16w4('OK'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _loadDrinkInfo();
  }

  @override
  void dispose() {
    numController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        text32w6("I drank"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textFormField(size.width * 0.1, size, numController),
            const SizedBox(
              width: 20,
            ),
            dropDownBtn([
              'soju cups(50ml)',
              'beer cups(225ml)',
              'bottles(360ml)',
              'wine bottles(700ml)'
            ], _selectedUnit, (newValue) {
              setState(() {
                _selectedUnit = newValue;
              });
            }, size, size.width * 0.6, size.width*0.15),
          ],
        ),
        text32w6("of"),
        dropDownBtn(['soju(15%)', 'beer(5%)', 'wine(12%)', 'whiskey(40%)'],
            _selectedDrink, (newValue) {
          setState(() {
            _selectedDrink = newValue;
          });
        }, size, size.width * 0.8, null),
        text32w6("within"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dropDownBtn(
                ['2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
                _selectedHours, (newValue) {
              setState(() {
                _selectedHours = newValue;
              });
            }, size, size.width * 0.3, null),
            SizedBox(
              width: 20,
            ),
            text32w6("hours"),
          ],
        ),
        SizedBox(
          height: size.width * 0.07,
        ),
        OutlinedButton(
            // submit btn
            onPressed: () {
              _checkInfo();
              context.read<AppState>().setTimerRunning(true);
            },
            style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text('Submit')),
        SizedBox(
          height: size.width * 0.07,
        ),
        TextButton(
            // size info btn
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SizeInfo()));
            },
            child: const Text("You can change your size info in here")),
      ],
    );
  }
}
