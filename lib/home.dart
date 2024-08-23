import 'package:flutter/material.dart';
import 'package:haedal/theme/theme.dart';
import 'package:haedal/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:haedal/components/my_navigationbar.dart';
import 'package:haedal/theme/font.dart';
import 'app_state.dart';
import 'components/my_divider.dart';
import 'components/my_searchbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'home/alarm_page.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _isVisible = _scrollController.position.pixels > 200;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final customColors = Theme.of(context).extension<CustomColors>()!;

    final double currentProgress = 5000; // 현재 경험치
    final double goal = 10000; // 경험치 목표치
    double progressPercentage = currentProgress / goal; // 경험치 퍼센티지
    double remainProgress = goal - currentProgress; // 목표치까지 남은 경험치

    // 개별 device 의 width, height 설정 (이제 잘 안쓰긴함)
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      //////////////////////////////////////////////////////////////////////
      ///////                      Home App bar                      ///////
      //////////////////////////////////////////////////////////////////////
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          width: screenWidth,
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ZERO", style: pretendardSemiBold(context).copyWith(fontSize: 24),),
                Row(
                  children: [
                    Image.asset('assets/images/star.png'),
                    const SizedBox(width: 7,),
                    Text("1,391", style: pretendardMedium(context).copyWith(fontSize: 14, color: customColors.gray02),),
                  ],
                ),
                GestureDetector(
                  onTap: () {Navigator.pushNamed(context, '/shop');},
                  child: Row(
                    children: [
                      Image.asset('assets/images/shell.png'),
                      const SizedBox(width: 7,),
                      Text("235", style: pretendardMedium(context).copyWith(fontSize: 14, color: customColors.gray02)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.notifications_none_rounded),
                  onPressed: () => Navigator.pushNamed(context, '/alarm'),
                ),
              ],
            ),
          ),
        ),
      ),

      //////////////////////////////////////////////////////////////////////
      ///////                         Body                           ///////
      //////////////////////////////////////////////////////////////////////
      body: SingleChildScrollView(
        controller: _scrollController, // 스크롤 시 플로팅 버튼 나오게 하기 위함
        child: Container(
          color: customColors.primary, // 전체 화면 초록색으로 하기 위함
          child: Column(
            children: [
              //////////////////////////////////////////////////////////////////////
              ///////                       홈 상단 정보칸                      ///////
              //////////////////////////////////////////////////////////////////////
              Container(
                padding: EdgeInsets.fromLTRB(30,15,30,30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24)
                  ),
                  color: Colors.white,
                ),
                width: 1.sw,
                height: 270,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/otter.png"), //이미지 추후 파베에서 가져와도 될거같운뎅
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,0,0,0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("오늘도 학습을\n시작해볼까요?", style: pretendardSemiBold(context).copyWith(fontSize: 24),),
                              Text("다음 스텝으로\n넘어가기까지 남은 경험치", style: pretendardMedium(context).copyWith(fontSize: 15 ,color: customColors.gray02),),
                              Text("$remainProgress", style: pretendardSemiBold(context).copyWith(fontSize: 24)),
                            ],
                          ),
                        )
                      ],
                    ),
                    ///////////////////////////////   Progress Bar   ///////////////////////////////
                    Column(
                      children: [
                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              LinearPercentIndicator(
                                width: 0.7.sw,
                                animation: true,
                                lineHeight: 18,
                                animateFromLastPercent: true,
                                percent: progressPercentage, // 현재 페이지에 따른 진행 상황
                                backgroundColor: customColors.gray05,
                                progressColor: customColors.primary,
                                barRadius: const Radius.circular(10),
                              ),
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Color(0xFFFFBF1C), width: 2),
                                    color: Colors.white
                                ),
                                child: Image.asset("assets/images/wrapped_gift.png"),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 0.8.sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("$currentProgress 달성",style: pretendardMedium(context).copyWith(fontSize: 14, color: customColors.gray02),),
                              Text("목표 $goal",style: pretendardMedium(context).copyWith(fontSize: 14, color: customColors.gray02))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              //////////////////////////////////////////////////////////////////////
              ///////                         배너                            ///////
              //////////////////////////////////////////////////////////////////////
              SizedBox(height: 34,),

              //////////////////////////////////////////////////////////////////////
              ///////                        카테고리                          ///////
              //////////////////////////////////////////////////////////////////////
              SizedBox(height: 34,),

              //////////////////////////////////////////////////////////////////////
              ///////                      맞춤 추천 가게                       ///////
              //////////////////////////////////////////////////////////////////////
              SizedBox(height: 36,),

              //////////////////////////////////////////////////////////////////////
              ///////                      Top 3 랭킹                         ///////
              //////////////////////////////////////////////////////////////////////
              SizedBox(height: 2000,),


              //////////////////////////////////////////////////////////////////////
              ///////                      테마 변경 버튼                       ///////
              //////////////////////////////////////////////////////////////////////

              BigDivider(),
              Container(
                width: 50.w,
                height: 50.h,
                color: ThemeManager.customColors.primary,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/tutorial', (Route<dynamic> route) => false, );
                },
                child: const Text('Tutorial'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/literacy', (Route<dynamic> route) => false, );
                },
                child: const Text('Literacy Test'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                  child: const Text('Toggle Theme'),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: _isVisible ? FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward, color: Colors.black,),
      ) : null,

      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}



