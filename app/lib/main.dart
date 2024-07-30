import 'package:flutter/material.dart';
import 'package:ice_d/ui/screens/alcohol_timer_page.dart';
import 'package:ice_d/ui/screens/navigation_page.dart';
import 'package:ice_d/ui/screens/self_check_page.dart';
import 'package:ice_d/ui/screens/setting_page.dart';
import 'package:ice_d/ui/widgets/bar_widgets.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AlcoholTimerPage(),
    NavigationPage(),
    //SelfCheckPage(), //제거
    SettingPage()
  ];

  void _onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      home: Scaffold(
        appBar: TopBar(),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
        )
      ),
    );
  }
}



