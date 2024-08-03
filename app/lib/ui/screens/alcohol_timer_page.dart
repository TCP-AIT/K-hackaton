import 'package:flutter/material.dart';

import 'package:ice_d/theme.dart';
import 'package:ice_d/ui/widgets/alcohol_timer_timer.dart';
import 'package:ice_d/ui/widgets/alcohol_timer_form.dart';


class AlcoholTimerPage extends StatefulWidget {
  const AlcoholTimerPage({super.key});

  @override
  State<AlcoholTimerPage> createState() => _AlcoholTimerPageState();
}

class _AlcoholTimerPageState extends State<AlcoholTimerPage> {
  final formKey = GlobalKey<FormState>();
  bool isBtnActivated = false;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

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
                  child: AlcoholTimerWidget()
              ),
              const SizedBox(height: 38,),
              Form(
                key: formKey,
                child: AlcoholTimerForm(isBtnActivated: isBtnActivated),
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
                      //isBtnActivated = true;
                    } else {
                      //isBtnActivated = false;
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