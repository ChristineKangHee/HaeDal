import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haedal/theme/font.dart';
import 'package:haedal/theme/theme_manager.dart';

import '../theme/theme.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      //////////////////////////////////////////////////////////////////////
      ///////                       App bar                          ///////
      //////////////////////////////////////////////////////////////////////
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.green),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        iconTheme: IconThemeData(
          color: customColors.primary, // 아이콘 전체 색을 기본적으로 primary로 만듦. 이걸로 Navigator.pop 아이콘 색이 primary가 됌.
        ),
        title: Text(
          '상점',
          style: pretendardExtraBold(context).copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Image.asset('assets/images/shell.png'),
              SizedBox(width: 11),
              Text(
                '235',
                style: pretendardMedium(context).copyWith(fontSize: 14, color: customColors.gray02)
              ),
              SizedBox(width: 30),
            ],
          ),
        ],
      ),
      //////////////////////////////////////////////////////////////////////
      ///////                         body                           ///////
      //////////////////////////////////////////////////////////////////////
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '아이템',
                style: pretendardBold(context),
              ),
              SizedBox(height: 10.h),
              //////////////////////////////////////////////////////////////////////
              ///////                      Item Card                         ///////
              //////////////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildItemCard(context, '힌트 3개', '10', 'assets/images/key.png'),
                  buildItemCard(context, '힌트 6개', '15', 'assets/images/key.png'),
                  buildItemCard(context, '힌트 10개', '25', 'assets/images/key.png'),
                ],
              ),
              SizedBox(height: 20,),
              // Spacer(),
              //////////////////////////////////////////////////////////////////////
              ///////                      COMING SOON                       ///////
              //////////////////////////////////////////////////////////////////////
              Container(
                width: double.infinity,
                height: 0.7.sh,
                color: Colors.grey[400],
                child: Center(
                  child: Text(
                    'COMING SOON (VER 1.0)',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////
  ///////                      Item Card                         ///////
  //////////////////////////////////////////////////////////////////////
  /*
  아래와 같이, 아이템 명, 가격, 아이템 이미지 링크 순서로 넣어주면 된다.

  buildItemCard(context, '힌트 3개', '10', 'assets/images/key.png'),

   */

  Widget buildItemCard(BuildContext context,String title, String price, String imagePath) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Container(
      width: 0.25.sw,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(color: Color(0xFFE9E9ED)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image.asset(imagePath, width: 48.w),
          SizedBox(height: 8.h),
          Text(title, style: pretendardMedium(context).copyWith(fontSize: 12 , color: customColors.gray02)),
          SizedBox(height: 8.h),
          Container(
            width: 66.w,
            height: 27.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(31), border: Border.all(color: Color(0xFFE9E9ED))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/shell.png', width: 16.w),
                SizedBox(width: 5.w),
                Text(
                  price,
                  style: pretendardMedium(context).copyWith(fontSize: 14, color: customColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
