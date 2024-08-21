import 'package:flutter/material.dart';
import 'package:haedal/components/my_navigationbar.dart';

class FriendMain extends StatelessWidget {
  const FriendMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child:
        SingleChildScrollView(
          child: Column(
            children: [
              Text(""),
            ],
          ),
        )
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
