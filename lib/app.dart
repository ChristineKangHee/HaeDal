
import 'package:flutter/material.dart';
import 'package:haedal/home/alarm_page.dart';
import 'package:haedal/home/shop.dart';
import 'package:haedal/literacy_test/literacy_test.dart';
import 'package:haedal/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'home.dart';
import 'login/login_page.dart';
import 'login/sign_up_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haedal/friend/friend_main.dart';
import 'package:haedal/reading/reading_main.dart';
import 'mypage/mypage_main.dart';
import 'tutorials/tutorial.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeManager(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
        // ScreenUtil 사용법
        // .w : width             ex: 170.w
        // .h : height            ex: 170.h
        // .sw : screenwidth      ex: 0.5.sw (screenwidth의 0.5배)
        // .sh : screenheight     ex: 0.6.sh (screenheight의 0.6배)
        // .sp : fontsize         ex: 12.sp

        /*

        ********************** 화면 전체 패딩 넣을 때 18.0 으로 넣을 것 **********************

                             padding: const EdgeInsets.all(18.0),

         ********************** 화면 전체 패딩 넣을 때 18.0 으로 넣을 것 **********************

         */



        designSize: Size(390, 844), // 기본 사이즈 설정

        child: MaterialApp(
        title: 'Flutter Demo',

        theme: themeProvider.lightTheme,
        // 라이트 테마
        darkTheme: themeProvider.darkTheme,
        // 다크 테마
        themeMode: themeProvider.themeMode,
        // 테마 모드 저장해 뒀다가 다시 킬때 사용

        initialRoute: '/login',
        // 시작 페이지를 / (MyHomePage로. 추후 스플래시 페이지로 바꾸고 로그인되있으면 바로 홈으로 넘어가는 플로우 구성)

        routes: { // route를 /를 통해 웹사이트 처럼 지정.
          '/login': (BuildContext context) => const LoginPage(),
          '/': (BuildContext context) => const MyHomePage(title: "title"),
          '/login/sign': (BuildContext context) => const SignUpPage(),
          '/friend': (BuildContext context) => const FriendMain(),
          '/mypage': (BuildContext context) => const MyPageMain(),
          '/reading': (BuildContext context) => const ReadingMain(),
          '/tutorial': (BuildContext context) => TutorialScreen(),
          '/literacy': (BuildContext context) => LiteracyTestScreen(),
          '/alarm' : (BuildContext context) => const AlarmPage(),
          '/shop' : (BuildContext context) => const ShopPage(),
        },
      )
    );
  }
}