import 'package:flutter/material.dart';
import 'package:haedal/components/my_navigationbar.dart';

class MyPageMain extends StatelessWidget {
  const MyPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
