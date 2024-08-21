import 'package:flutter/material.dart';
import 'package:haedal/components/my_navigationbar.dart';

class ReadingMain extends StatelessWidget {
  const ReadingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
