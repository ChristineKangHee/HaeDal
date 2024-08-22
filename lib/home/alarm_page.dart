import 'package:flutter/material.dart';
import 'package:haedal/theme/font.dart';
import 'package:haedal/components/my_navigationbar.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알람 내역', style: pretendardRegular(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFilterButtons(context),
            // Add your alarm history widgets here
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton(context, '전체'),
          _buildFilterButton(context, '주문/픽업'),
          _buildFilterButton(context, '혜택'),
          _buildFilterButton(context, '리뷰'),
          _buildFilterButton(context, '관심매장 소식'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: text == '전체' ? Color(0xFFF5A536) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Color(0xFFEDF1F7),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: text == '전체' ? Colors.white : Color(0xFFF5A536),
              fontSize: 14,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.70,
            ),
          ),
        ),
      ),
    );
  }
}
