import 'package:app/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import 'theme.dart';
import 'app_state.dart';
import 'package:app/ui/screens/safe_driving_page.dart';
import 'package:app/ui/screens/alcohol_timer_page.dart';
import 'package:app/ui/screens/self_check_page.dart';

//todo selfcheckpage 부분 -> done
//todo safe driving page -> yet
//todo alcohol timer 파란색으로 시작하게 -> done

//todo overlay -> safe_driving_page에서 하면 될 듯. 검색하면 뭐 더 나올 거 같아
//todo background -> 혹시 gpt에 물어볼까봐, 물어보면 아마  flutter는 background service 지원 안 한다고 할텐데, https://pub.dev/packages/flutter_background_service 이게 최근에 나온 건가봐 그래서 아무튼.. 이 부분은 하다가 잘 안 되면 콜해 같이 해보자 (pm 8:00에 밥약 있어서 그 전에 해주시면 감사할 거 같습니다..)



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  late CameraDescription frontCamera;
  for (var camera in cameras) {
    if (camera.lensDirection == CameraLensDirection.front) {
      frontCamera = camera;
      break;
    }
  }
  runApp(MultiProvider(
      providers:
      [ChangeNotifierProvider(create: (_) =>AppState()),
      ChangeNotifierProvider(create: (_) => TimerProvider(0, 0))],

      child: MaterialApp(home: MyApp(camera: frontCamera)))
  );
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.setContext(context);

    return MaterialApp(
      title: 'PageView Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Noto_Serif',
        scaffoldBackgroundColor: ColorStyles.swhite,
      ),
      home: PageViews(camera: camera),
    );
  }
}


class PageViews extends StatelessWidget {
  final CameraDescription camera;

  const PageViews({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          AlcoholTimerPage(), // 이거 AlcoholTimerPage로 해서 넣기. 현재느 -1만 들어가있음
          SafeDrivingPage(camera: camera,),
          SelfCheckPage()
        ],
      )
      ,
    );
  }
}





