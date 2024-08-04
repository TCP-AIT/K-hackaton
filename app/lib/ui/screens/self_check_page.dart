import 'package:flutter/material.dart';
import 'package:ice_d/theme.dart';

class SelfCheckPage extends StatefulWidget {
  const SelfCheckPage({super.key});

  @override
  State<SelfCheckPage> createState() => _SelfCheckPageState();
}

class _SelfCheckPageState extends State<SelfCheckPage> {
  @override
  int Checker1 = 0;
  int Checker2 = 0;
  int Checker3 = 0;
  int Checker4 = 0;
  int Checker5 = 0;
  int Checker6 = 0;
  int Checker7 = 0;
  int Checker8 = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          children: [
            SizedBox(width:1, height:MediaQuery.of(context).size.width * 0.05),
            TextBlack(string: "음주운전 질문", size: 24),
            SizedBox(width:1, height:MediaQuery.of(context).size.width * 0.02),
            Divider(),
            Column(children: [
              TextBlack(string: "술 질문 1", size: 16), ///

              Column(children: [],),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextBlack(string: "아니다 |", size: 16),
                  SizedBox(width:MediaQuery.of(context).size.width * 0.015, height:1),

                Radio<int> (
                  value : 1,
                  groupValue:Checker1,
                  onChanged: (value) {
                    setState(() {

                      Checker1 = value!;
                    });
                  },

                ),

                SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                Radio<int> (
                  value : 2,
                  groupValue:Checker1,
                  onChanged: (value) {
                    setState(() {

                      Checker1 = value!;
                    });
                  },

                ),
                  SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                Radio<int> (
                  value : 3,
                  groupValue:Checker1,
                  onChanged: (value) {
                    setState(() {

                      Checker1 = value!;
                    });
                  },

                ),
                  SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                Radio<int> (
                  value : 4,
                  groupValue:Checker1,
                  onChanged: (value) {
                    setState(() {

                      Checker1 = value!;
                    });
                  },

                ),
                  SizedBox(width:MediaQuery.of(context).size.width * 0.015, height:1),
                  TextBlack(string: "| 그렇다", size: 16),
              ],),
              Divider(),

              Column(children: [
                TextBlack(string: "술 질문 2", size: 16), ///

                Column(children: [],),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextBlack(string: "아니다 |", size: 16),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.015, height:1),

                    Radio<int> (
                      value : 1,
                      groupValue:Checker2,
                      onChanged: (value) {
                        setState(() {

                          Checker2 = value!;
                        });
                      },

                    ),

                    SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                    Radio<int> (
                      value : 2,
                      groupValue:Checker2,
                      onChanged: (value) {
                        setState(() {

                          Checker2 = value!;
                        });
                      },

                    ),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                    Radio<int> (
                      value : 3,
                      groupValue:Checker2,
                      onChanged: (value) {
                        setState(() {

                          Checker2 = value!;
                        });
                      },

                    ),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                    Radio<int> (
                      value : 4,
                      groupValue:Checker2,
                      onChanged: (value) {
                        setState(() {

                          Checker2 = value!;
                        });
                      },

                    ),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.015, height:1),
                    TextBlack(string: "| 그렇다", size: 16),
                  ],),
                Divider(),


            ],),

              Column(children: [
                TextBlack(string: "술 질문 3", size: 16), ///

                Column(children: [],),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextBlack(string: "아니다 |", size: 16),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.015, height:1),

                    Radio<int> (
                      value : 1,
                      groupValue:Checker3,
                      onChanged: (value) {
                        setState(() {

                          Checker3 = value!;
                        });
                      },

                    ),

                    SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                    Radio<int> (
                      value : 2,
                      groupValue:Checker3,
                      onChanged: (value) {
                        setState(() {

                          Checker3 = value!;
                        });
                      },

                    ),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                    Radio<int> (
                      value : 3,
                      groupValue:Checker3,
                      onChanged: (value) {
                        setState(() {

                          Checker3 = value!;
                        });
                      },

                    ),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.02, height:1),

                    Radio<int> (
                      value : 4,
                      groupValue:Checker3,
                      onChanged: (value) {
                        setState(() {

                          Checker3 = value!;
                        });
                      },

                    ),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.015, height:1),
                    TextBlack(string: "| 그렇다", size: 16),
                  ],),
                Divider(),


              ],),// 한 덩어리





        ],)
    ])
    );
  }
}
