import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'app.dart';
import 'theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  //////////////////// 세로 모드 고정 ////////////////////
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //////////////////// Firebase 연결 ////////////////////
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  KakaoSdk.init(
    nativeAppKey: '61dfe0fe1e4375a76b5c97938749086c',
    javaScriptAppKey: 'b6a12ba6c8d0fda7a0ecec4569921a1d',
  );


  //////////////////// 세로 모드 고정 ////////////////////
  runApp(
      MultiProvider(
        child: const MyApp(),
        providers: [
          ChangeNotifierProvider( // 테마 Provider / app_state.dart 존재
            create: (context) => ThemeProvider(context),
          ),
          ChangeNotifierProvider( // 바텀 네비게이션 Provider / app_state.dart 존재
            create: (context) => NavigationProvider(),
          ),
          ChangeNotifierProvider( // app state 관리. User정보 등등
              create: (context) => AppState()
          ),
        ],
      )

  );
}
