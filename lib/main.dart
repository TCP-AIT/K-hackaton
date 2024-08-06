import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ice_d/ui/screens/alcohol_timer_page.dart';
import 'package:ice_d/ui/screens/safe_driving_page.dart';
import 'package:ice_d/ui/screens/setting_page.dart';
import 'package:ice_d/ui/widgets/bar_widgets.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'timer_provider.dart';

// 카메라 리스트 전역 변수 선언
List<CameraDescription> cameras = [];

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(
      MultiProvider(
      providers:
      [ChangeNotifierProvider(create: (_) =>AppState()),
        ChangeNotifierProvider(create: (_) => TimerProvider(0, 0))],
      // 사용 가능한 카메라 리스트 초기화
      child: MaterialApp(home: MyApp())
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // 페이지 리스트 초기화, SafeDrivingPage에 카메라 전달
    _pages = [
      AlcoholTimerPage(),
      SafeDrivingPage(camera:cameras.first),
      SettingPage(),
    ];
  }

  void _onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.setContext(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
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



