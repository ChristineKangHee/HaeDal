import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haedal/app_state.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);

  /*
  사용 방법
  Scaffold 에서 아래와 같이 사용

  bottomNavigationBar: const CustomNavigationBar(),
   */

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationProvider.selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.primaryContainer,
      unselectedItemColor: Colors.grey,
      onTap: (index) => navigationProvider.navigateToIndex(context, index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_rounded),
          label: '친구',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_rounded),
          label: '독서',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: '마이페이지',
        ),
      ],
    );
  }
}