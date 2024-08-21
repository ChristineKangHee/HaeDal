import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haedal/theme/font.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../theme/theme.dart';
import '../theme/theme_manager.dart';

//////////////////////////////////////////////////////////////////////
///////                      튜토리얼 페이지                       ///////
//////////////////////////////////////////////////////////////////////

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  String? _selectedOption;

  //////////////////////////////////////////////////////////////////////
  ///////                  질문 내용 MAP 형식 정리                   ///////
  //////////////////////////////////////////////////////////////////////

  final List<Map<String, dynamic>> _pages = [
    {
      'number': '1. ',
      'title': '강희님의 문해력 이해 정도는 \n어디에 위치하나요?',
      'stage': ['입문자', '중수', '고수', '전문가'],
      'options': [
        '전체적으로 글과 문장의 맥락과 의미를 이해하는 것이 어려워요.',
        '개별 문장을 읽고 쓸 수 있으나 짧거나 긴 텍스트의 의미를 이해하는 것이 어려워요.',
        '대부분의 글이 다 이해는 가지만 가끔 어려운 어휘가 생기고 완전한 이해는 어려워요.',
        '웬만한 글은 이해하는데 어려움이 없어요.'
      ]
    },
    {
      'number': '2. ',
      'title': '문해력의 어려움을 겪는 이유가 \n무엇이라 생각하시나요?',
      'options': [
        '집중력 부족',
        '어휘력 부족',
        '복잡한 문장을 이해하기 어려움',
        '배경지식 부족',
        '읽기 습관 부족'
      ]
    },
    {
      'number': '3. ',
      'title': '학습 목적은 무엇인가요?',
      'options': [
        '어휘력 증진',
        '문서 이해력 개선',
        '자녀 교육용',
        '직장 업무 능력 향상',
        '원활한 정보 습득',
        '기타'
      ]
    },
  ];

  //////////////////////////////////////////////////////////////////////
  ///////                      상태 관리 함수                       ///////
  //////////////////////////////////////////////////////////////////////

  void _onOptionSelected(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      setState(() {
        _selectedOption = null;
        _currentPage++;
        _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      _showCompletionDialog();
    }
  }

  //////////////////////////////////////////////////////////////////////
  ///////                  튜토리얼 완료 팝업창                       ///////
  //////////////////////////////////////////////////////////////////////

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          contentPadding: EdgeInsets.all(24.0),
          content: Container(
            width: 340.w,
            height: 290.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '문해력 테스트를 바로\n시작하시겠습니까?',
                  textAlign: TextAlign.center,
                  style: pretendardSemiBold(context).copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => NextScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager.customColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: Text(
                      '문해력 테스트 시작',
                      style: pretendardSemiBold(context).copyWith(
                        color: ThemeManager.customColors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  height: 50.h,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                      ThemeManager.customColors.gray04,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: Text(
                      '다음에 할래요',
                      style: pretendardSemiBold(context).copyWith(
                        color: ThemeManager.customColors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //////////////////////////////////////////////////////////////////////
  ///////                    튜토리얼 전체 프레임                     ///////
  //////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 8.h,
              animateFromLastPercent: true,
              percent: (_currentPage + 1) / _pages.length,
              backgroundColor: customColors.gray05,
              progressColor: customColors.primary,
              barRadius: const Radius.circular(10),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _selectedOption = null;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return index == 0
                    ? _buildFirstPageContent(_pages[index])
                    : _buildPageContent(_pages[index]);
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: Container(
                  width: 351.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: _selectedOption != null
                        ? customColors.primary
                        : customColors.gray04,
                  ),
                  child: TextButton(
                    onPressed: _selectedOption != null ? _onNextPressed : null,
                    child: Text(
                      _currentPage == _pages.length - 1 ? '완료' : '다음',
                      style: pretendardSemiBold(context).copyWith(
                        color: customColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////
  ///////                      첫번째 페이지                        ///////
  //////////////////////////////////////////////////////////////////////

  Widget _buildFirstPageContent(Map<String, dynamic> pageData) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          width: 347.w,
          height: 100.h,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pageData['number'],
                style: pretendardSemiBold(context).copyWith(
                    color: customColors.black,
                    fontSize: 24
                ),
              ),
              Expanded(
                child: Text(
                  pageData['title'],
                  style: pretendardSemiBold(context).copyWith(
                      color: customColors.black,
                      fontSize: 24
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        ...List.generate(pageData['options'].length, (index) {
          final option = pageData['options'][index];
          final stage = pageData['stage'][index];
          bool isSelected = _selectedOption == option;
          return GestureDetector(
            onTap: () {
              _onOptionSelected(option);
            },
            child: Container(
              alignment: Alignment.center,
              width: 354.w,
              height: 70.h,
              padding: EdgeInsets.all(10.h),
              margin: EdgeInsets.fromLTRB(18.w, 8.w, 18.w, 8.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? customColors.primary!.withOpacity(0.2)
                    : customColors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: isSelected
                      ? customColors.primary!
                      : customColors.gray05!,
                  width: 2.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: isSelected
                        ? customColors.primary
                        : customColors.gray04,
                  ),
                  SizedBox(width: 10.w),
                  Container(
                      width: 50.w,
                      child: Text(stage,
                        style: pretendardSemiBold(context).copyWith(
                          fontSize: 16.sp,
                          color: isSelected
                              ? customColors.primary
                              : customColors.black,),
                      )
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      option,
                      style: pretendardMedium(context).copyWith(
                        fontSize: 14.sp,
                        color: isSelected
                          ? customColors.primary
                          : customColors.black,),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  //////////////////////////////////////////////////////////////////////
  ///////                      첫 페이지 제외                       ///////
  //////////////////////////////////////////////////////////////////////

  Widget _buildPageContent(Map<String, dynamic> pageData) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          width: 347.w,
          height: 100.h,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pageData['number'],
                style: pretendardSemiBold(context).copyWith(
                    color: customColors.black,
                    fontSize: 24
                ),
              ),
              Expanded(
                child: Text(
                  pageData['title'],
                  style: pretendardSemiBold(context).copyWith(
                      color: customColors.black,
                      fontSize: 24
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        ...pageData['options'].map<Widget>((option) {
          bool isSelected = _selectedOption == option;
          return GestureDetector(
            onTap: () {
              _onOptionSelected(option);
            },
            child: Container(
              alignment: Alignment.center,
              width: 354.w,
              height: 50.h,
              padding: EdgeInsets.all(10.h),
              margin: EdgeInsets.fromLTRB(18.w, 8.w, 18.w, 8.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? customColors.primary!.withOpacity(0.2)
                    : customColors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: isSelected
                      ? customColors.primary!
                      : customColors.gray05!,
                  width: 2.0,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? customColors.primary
                      : customColors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////////
///////                           임시                          ///////
//////////////////////////////////////////////////////////////////////

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('문해력 테스트 시작'),
      ),
    );
  }
}
