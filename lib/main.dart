import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'app.dart';
import 'theme/theme.dart';

void main() {
  //////////////////// 세로 모드 고정 ////////////////////
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
        ],
      )

  );
}
