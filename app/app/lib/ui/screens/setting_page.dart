import 'package:flutter/material.dart';
import 'package:ice_d/theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  bool settingSwtich1 = false;
  bool settingSwtich2 = false;
  bool settingSwtich3 = false;
  bool settingSwtich4 = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(child:
      Column(children: [ //#1
        Container(child: SizedBox(width:1, height:MediaQuery.of(context).size.height * 0.1)),
        TextBlack(string: "알코올 타이머", size: 16),
        Column(children: [
        Container(
            height:MediaQuery.of(context).size.height * 0.15,
            width:MediaQuery.of(context).size.width * 0.6,
            alignment:Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color:AppColors.black, width:2.5),
                borderRadius:BorderRadius.all(Radius.circular(10))),
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Row(

                  children: [
                    Expanded(child: Container(
                padding: EdgeInsets.only(left: 10),
          child: TextBlack(string: "소리", size: 16),
        ),),
                    SizedBox(width:1,height:1),
                    Switch(
                      value: settingSwtich1, onChanged: (value) {
                      setState(() {
                        print(value);
                        settingSwtich1 = value;
                      });
                    },activeColor: AppColors.black,),
                  ],

                ),
            SizedBox(width: 1, height:MediaQuery.of(context).size.height * 0.01),
            Row(

              children: [
                Expanded(child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: TextBlack(string: "진동", size: 16),
                ),),
                SizedBox(width:1,height:1),
                Switch(
                  value: settingSwtich2, onChanged: (value) {
                  setState(() {
                    print(value);
                    settingSwtich2 = value;
                  });
                },activeColor: AppColors.black,),
              ],

            )],),

        ),],),
        Container(child: SizedBox(width:1, height:MediaQuery.of(context).size.height * 0.05)),
        TextBlack(string: "안전운전 모드", size: 16),

        //#2
        Column(children: [
          Container(
            height:MediaQuery.of(context).size.height * 0.15,
            width:MediaQuery.of(context).size.width * 0.6,
            alignment:Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color:AppColors.black, width:2.5),
                borderRadius:BorderRadius.all(Radius.circular(10))),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(

                  children: [
                    Expanded(child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: TextBlack(string: "소리", size: 16),
                    ),),
                    SizedBox(width:1,height:1),
                    Switch(
                      value: settingSwtich3, onChanged: (value) {
                      setState(() {
                        print(value);
                        settingSwtich3 = value;
                      });
                    },activeColor: AppColors.black,),
                  ],

                ),
                SizedBox(width: 1, height:MediaQuery.of(context).size.height * 0.01),
                Row(

                  children: [
                    Expanded(child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: TextBlack(string: "진동", size: 16),
                    ),),
                    SizedBox(width:1,height:1),
                    Switch(
                      value: settingSwtich4, onChanged: (value) {
                      setState(() {
                        print(value);
                        settingSwtich4 = value;
                      });
                    },activeColor: AppColors.black,),
                  ],

                )],),

          ),],),

      ],), //#1



    ));
  }
}
// Divider(thickness: 1, height: 1, color:AppColors.black),