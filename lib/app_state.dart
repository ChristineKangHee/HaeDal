import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'home.dart';
import 'friend/friend_main.dart';
import 'mypage/mypage_main.dart';
import 'reading/reading_main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState with ChangeNotifier {
  ////////////////// User 세팅 //////////////////
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}


class NavigationProvider with ChangeNotifier { // Bottom Navigation Bar를 Provider를 통해 전체 상태관리함.
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void navigateToIndex(BuildContext context, int index) { // index 별 페이지 정의.
    setSelectedIndex(index);
    switch (index) {
      case 0:
        _navigateWithoutAnimation(context, '/'); // home
        break;
      case 1:
        _navigateWithoutAnimation(context, '/friend'); // friend main page
        break;
      case 2:
        _navigateWithoutAnimation(context, '/reading'); // reading main page
        break;
      case 3:
        _navigateWithoutAnimation(context, '/mypage'); // mypage main
        break;
    }
  }

  void _navigateWithoutAnimation(BuildContext context, String routeName) { // 페이지 이동할때 생기는 애니메이션 효과 제거
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => _getPageByRouteName(context, routeName),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
          (route) => false,
    );
  }

  Widget _getPageByRouteName(BuildContext context, String routeName) { // 페이지 Get
    switch (routeName) {
      case '/':
        return const MyHomePage(title: "title");
      case '/friend':
        return FriendMain();
      case '/reading':
        return const ReadingMain();
      case '/mypage':
        return const MyPageMain();
      default:
        return const MyHomePage(title: "title");
    }
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isLightTheme = true;

  ThemeProvider(BuildContext context);

  bool get isLightTheme => _isLightTheme;

  ThemeData get lightTheme => lightThemeGlobal;
  ThemeData get darkTheme => darkThemeGlobal;

  ThemeMode get themeMode => _isLightTheme ? ThemeMode.light : ThemeMode.dark;

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }
}



class AutoLoginToggle extends StatefulWidget {
  @override
  _AutoLoginToggleState createState() => _AutoLoginToggleState();
}

class _AutoLoginToggleState extends State<AutoLoginToggle> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
          activeColor: Theme.of(context).colorScheme.primary,
          checkColor: Colors.white,
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        const Text(
          '자동 로그인',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
