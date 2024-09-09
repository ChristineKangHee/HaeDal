import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'app.dart';
import 'theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //////////////////// 세로 모드 고정 ////////////////////
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //////////////////// Firebase 연결 ////////////////////
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
