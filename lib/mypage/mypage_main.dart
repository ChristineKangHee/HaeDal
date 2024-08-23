import 'package:flutter/material.dart';
import 'package:haedal/components/my_navigationbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haedal/theme/font.dart';
import 'package:haedal/theme/theme.dart';
import 'package:haedal/theme/theme_manager.dart';

class MyPageMain extends StatelessWidget {
  const MyPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              //////////////////////////////////////////////////////////////////////
              ///////                   프로필 상단 Stack 구조                   ///////
              //////////////////////////////////////////////////////////////////////

              Container(
                width: 1.sw,
                height: 300.h,
                color: customColors.green07,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 1.sw,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: customColors.white,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24))
                        ),
                      ),
                    ),

                    Container(
                      // color: customColors.secondary,
                      height: 200.h,
                      child: Column(
                        children: [
                          Text(
                            'Level 1',
                            style: pretendardBold(context).copyWith(color: customColors.green01, fontSize: 20)
                          ),
                          SizedBox(height: 10.h),
                          CircleAvatar(
                            radius: 55.w,
                            backgroundColor: customColors.primary,
                            child: CircleAvatar(
                              radius: 50.w,
                              backgroundImage: AssetImage('assets/images/profile_image.png'),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 80.h,
                        // color: customColors.gray02,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                '희',
                                style: pretendardSemiBold(context).copyWith(fontSize: 20)
                            ),
                            Text(
                                '@hhhui',
                                style: pretendardSemiBold(context).copyWith(color: customColors.gray03)
                            ),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        alignment: Alignment.topRight,
                        width: 120,
                        height: 150.h,
                        // color: customColors.green02,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Icon(Icons.settings_outlined, size: 24.w, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //////////////////////////////////////////////////////////////////////
              ///////                        Stack 종료                       ///////
              //////////////////////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildStatistic(context, '23일째', '학습일수'),
                        Container(
                            height: 26.h,
                            child: VerticalDivider(thickness: 1, color: customColors.gray05)
                        ),
                        buildStatistic(context, '13%', '상위 랭킹'),
                        Container(
                            height: 26.h,
                            child: VerticalDivider(thickness: 1, color: customColors.gray05)
                        ),
                        buildStatistic(context, '1,391', '경험치'),
                      ],
                    ),


                    SizedBox(height: 20.h),
                    RadarChartWidget(), // 학습 상태 분석 그래프를 위한 위젯 (가상으로 추가)
                    SizedBox(height: 10.h),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      ),
                      child: Text('학습상태 분석하기', style: TextStyle(fontSize: 16.sp)),
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildFeatureCard(context,'학습 현황', 'assets/images/target.png'),
                        buildFeatureCard(context,'관심 분야', 'assets/images/magic_wand.png'),
                      ],
                    ),

                    SizedBox(height: 20.h),
                    buildComingSoonSection('오답노트', '나만의 사전'),
                    SizedBox(height: 10.h),
                    buildFeatureCard(context,'구독 서비스', 'assets/images/subscription.png'),
                    SizedBox(height: 30.h),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////
  ///////                       학습 일수 등                        ///////
  //////////////////////////////////////////////////////////////////////

  Widget buildStatistic(BuildContext context ,String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: pretendardBold(context).copyWith(fontSize: 20),
        ),
        Text(
          label,
          style: pretendardRegular(context).copyWith(fontSize: 12)
        ),
      ],
    );
  }

  //////////////////////////////////////////////////////////////////////
  ///////                       학습 현황 등                        ///////
  //////////////////////////////////////////////////////////////////////

  Widget buildFeatureCard(BuildContext context, String label, String imagePath) {
    return Container(
      width: 170.w,
      height: 160.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(color: const Color(0xFFE9E9ED)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          SizedBox(height: 20.h),
          Text(label, style: pretendardMedium(context)),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////
  ///////                       Coming Soon                      ///////
  //////////////////////////////////////////////////////////////////////

  Widget buildComingSoonSection(String label1, String label2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(label1, style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
          Center(
            child: Text(
              'COMING SOON (VER 1.0)',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(label2, style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
///////                          차트                           ///////
//////////////////////////////////////////////////////////////////////

class RadarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      color: Colors.grey[200], // Placeholder for radar chart
      child: Center(
        child: Text(
          'Radar Chart Here',
          style: TextStyle(color: Colors.black54, fontSize: 16.sp),
        ),
      ),
    );
  }
}
