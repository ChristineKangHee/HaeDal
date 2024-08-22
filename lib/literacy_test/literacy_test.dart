import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haedal/theme/font.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../theme/theme.dart';
import '../theme/theme_manager.dart';

///////////////////////////////////////////////////////////////////////////
///////                    문해력 테스트 페이지                      ///////
///////////////////////////////////////////////////////////////////////////

class LiteracyTestScreen extends StatefulWidget {
  @override
  _LiteracyTestScreenState createState() => _LiteracyTestScreenState();
}

class _LiteracyTestScreenState extends State<LiteracyTestScreen> {
  final PageController _controller = PageController(); // 페이지 컨트롤러
  int _currentPage = 0; // 현재 페이지 인덱스
  String? _selectedOption; // 사용자가 선택한 옵션
  String? _writtenAnswer; // 사용자가 입력한 텍스트 (2번째 페이지용)

  //////////////////////////////////////////////////////////////////////
  ///////              문해력 테스트 질문 데이터                  ///////
  //////////////////////////////////////////////////////////////////////

  final List<Map<String, dynamic>> _pages = [
    {
      'number': '1. ',
      'questionType': 'image', // 이미지와 텍스트를 포함한 질문
      'question': '사진이 전하는 메시지로 맞는 것을 고르세요.',
      'imagePath': 'assets/image1.png',
      'options': [
        '그림자는 남자의 내면이 투영된 존재다.',
        '남자에게는 누군가 있다.',
        '그림자는 남자와 약속하고 있다.',
        '남자는 여름 휴가를 곧 떠날 예정이다.'
      ]
    },
    {
      'number': '2. ',
      'questionType': 'text', // 긴 텍스트 입력형 질문
      'question': '다음은 마을 이장이 긴급하게 방송한 내용입니다. 이장은 사람들에게 무엇을 조심하라고 알리는 것인지 다섯 글자로 적어주세요.',
      'text': '아야, 마을 이장입니다. 큰일 났습니다. 큰일, 그것도 아주아주 큰일이에요. 양계장 집 빅박사가 서울 사는 딸이 사고 났다고 돈을 빨리 보내라는 전화를 받아 돈을 보냈다고 합니다. 어 그런데 글쎄, 나쁜 놈들이 그 돈을 가로챘다고 하네요. 지금 경찰에서 조사하고 있다고 합니다. 그러니 특히 할머니, 할아버지들은 자식들이 전화를 해서 돈을 부치라고 하면 일단 의심하고 경찰서로 먼저 연락을 하길 바랍니다. 전화로 자식들 목소리를 똑같이 흉내 내서 사기 친다고 하니 모두 조심하겠습니다. 이상, 마을 이장이었습니다.'
    },
    {
      'number': '3. ',
      'questionType': 'multipleChoice', // 여러 개의 선택지가 있는 질문
      'question': '다음 대화에 가장 잘 어울리는 속담은 무엇인가요?',
      'dialogue': 'A : 면접 본 거 어떻게 됐어?\nB : 말도 마, 또 떨어졌어. 이번이 99번째 불합격이야.\nA : 힘내. 잘될 거야. 옛말에 ( )라고 했잖아.',
      'options': [
        '사람 위에 사람 없고 사람 밑에 사람 없다.',
        '한술 밥에 배부르랴.',
        '콩 심은 데 콩 나고, 팥 심은 데 팥 난다.',
        '원숭이도 나무에서 떨어진다.',
        '꼬리가 길면 밟힌다.',
        '밤이 깊어갈수록 새벽이 가까워온다.',
        '손바닥도 마주쳐야 소리가 난다.'
      ]
    },
    {
      'number': '4. ',
      'questionType': 'singleChoice', // 단일 선택형 질문
      'question': '최근 1년간 완독한 책은 몇 권인가요?',
      'options': [
        '0권',
        '1권~2권',
        '3권~5권',
        '6권~9권',
        '10권 이상'
      ]
    }
  ];

  //////////////////////////////////////////////////////////////////////
  ///////                   상태 관리 함수들                        ///////
  //////////////////////////////////////////////////////////////////////

  // 사용자가 옵션을 선택했을 때 호출되는 함수
  void _onOptionSelected(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  // '다음' 버튼을 눌렀을 때 호출되는 함수
  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      setState(() {
        _selectedOption = null; // 다음 페이지로 넘어가면 선택 초기화
        _currentPage++;
        _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      // 마지막 페이지에서는 완료 다이얼로그를 보여줌
      _showCompletionDialog();
    }
  }

  //////////////////////////////////////////////////////////////////////
  ///////                     테스트 완료 팝업창                     ///////
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
          contentPadding: EdgeInsets.fromLTRB(24,24,24,12),
          content: Container(
            width: 340.w,
            height: 310,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/pencil.png"),
                SizedBox(height: 24),
                Text(
                  '정말 제출하시겠습니까?',
                  textAlign: TextAlign.center,
                  style: pretendardSemiBold(context).copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 24),
                Text(
                    '제출 이후 수정이 불가능해요.'
                ),
                SizedBox(height: 24),
                // 문해력 테스트 시작 버튼
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: 50,
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
                            '취소',
                            style: pretendardSemiBold(context).copyWith(
                              color: ThemeManager.customColors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: 50,
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
                            '확인',
                            style: pretendardSemiBold(context).copyWith(
                              color: ThemeManager.customColors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //////////////////////////////////////////////////////////////////////
  ///////                문해력 테스트 화면 빌드                    ///////
  //////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("문해력 테스트", style: pretendardExtraBold(context).copyWith(fontSize: 20),),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          // 진행률을 표시하는 LinearPercentIndicator
          child: LinearPercentIndicator(
            animation: true,
            lineHeight: 8.h,
            animateFromLastPercent: true,
            percent: (_currentPage + 1) / _pages.length, // 현재 페이지에 따른 진행 상황
            backgroundColor: customColors.gray05,
            progressColor: customColors.primary,
            barRadius: const Radius.circular(10),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // PageView를 이용해 각 페이지를 표시
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(), // 스크롤로 페이지 전환 방지
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _selectedOption = null; // 페이지 변경 시 선택 초기화
                  _writtenAnswer = null; // 작성한 답변 초기화
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _buildPageContent(_pages[index]);
              },
            ),
          ),
          // 하단의 네비게이션 버튼
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
                    color: _selectedOption != null || (_currentPage == 1 && _writtenAnswer != null && _writtenAnswer!.isNotEmpty)
                        ? customColors.primary // 답변이 선택되거나 작성된 경우 활성화된 버튼 색상
                        : customColors.gray04, // 그렇지 않은 경우 비활성화된 버튼 색상
                  ),
                  child: TextButton(
                    onPressed: (_selectedOption != null || (_currentPage == 1 && _writtenAnswer != null && _writtenAnswer!.isNotEmpty))
                        ? _onNextPressed
                        : null,
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
  ///////                  페이지별 콘텐츠 빌드                   ///////
  //////////////////////////////////////////////////////////////////////

  // 각 페이지의 콘텐츠를 빌드하는 함수
  Widget _buildPageContent(Map<String, dynamic> pageData) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    switch (pageData['questionType']) {
      case 'image':
        return _buildImageQuestion(pageData); // 이미지 질문 타입
      case 'text':
        return _buildTextQuestion(pageData); // 텍스트 입력 질문 타입
      case 'multipleChoice':
        return _buildMultipleChoiceQuestion(pageData); // 다중 선택 질문 타입
      case 'singleChoice':
        return _buildSingleChoiceQuestion(pageData); // 단일 선택 질문 타입
      default:
        return Container();
    }
  }

  // 이미지와 함께 선택지를 고르는 질문 빌드
  Widget _buildImageQuestion(Map<String, dynamic> pageData) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 347.w,

            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pageData['number'],
                  style: pretendardSemiBold(context).copyWith(
                      color: customColors.black,
                      fontSize: 20
                  ),
                ),
                Expanded(
                  child: Text(
                    pageData['question'],
                    style: pretendardBold(context).copyWith(
                        color: customColors.black,
                        fontSize: 20
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(pageData['imagePath'], width: 250.w, height: 200.h), // 이미지 표시
          const SizedBox(height: 20),
          ...List.generate(pageData['options'].length, (index) {
            final option = pageData['options'][index];
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
                  style: pretendardMedium(context).copyWith(
                      fontSize: 14.sp,
                      color: isSelected
                          ? customColors.primary
                          : customColors.black),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // 텍스트 입력 질문 빌드
  Widget _buildTextQuestion(Map<String, dynamic> pageData) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,0,20,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 347.w,

              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pageData['number'],
                    style: pretendardSemiBold(context).copyWith(
                        color: customColors.black,
                        fontSize: 20
                    ),
                  ),
                  Expanded(
                    child: Text(
                      pageData['question'],
                      style: pretendardBold(context).copyWith(
                          color: customColors.black,
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: customColors.green07,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                pageData['text'],
                style: pretendardRegular(context)
                    .copyWith(fontSize: 16.sp, color: customColors.black),
              ),
            ),
            const SizedBox(height: 20),
            // 사용자가 직접 입력하는 텍스트 필드
            TextField(
              onChanged: (value) {
                setState(() {
                  _writtenAnswer = value;
                });
              },
              maxLines: null,
              style: pretendardMedium(context)
                  .copyWith(fontSize: 16.sp, color: customColors.black),
              decoration: InputDecoration(
                hintText: '작성하기',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: customColors.gray05!,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: customColors.primary!,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 다중 선택 질문 빌드
  Widget _buildMultipleChoiceQuestion(Map<String, dynamic> pageData) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 347.w,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pageData['number'],
                style: pretendardSemiBold(context).copyWith(
                    color: customColors.black,
                    fontSize: 20
                ),
              ),
              Expanded(
                child: Text(
                  pageData['question'],
                  style: pretendardBold(context).copyWith(
                      color: customColors.black,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20,0,20,10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: customColors.green07,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              pageData['dialogue'],
              style: pretendardRegular(context)
                  .copyWith(fontSize: 16.sp, color: customColors.black),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(pageData['options'].length, (index) {
                  final option = pageData['options'][index];
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
                        style: pretendardMedium(context).copyWith(
                            fontSize: 14.sp,
                            color: isSelected
                                ? customColors.primary
                                : customColors.black),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        )
      ],
    );
  }

  // 단일 선택 질문 빌드
  Widget _buildSingleChoiceQuestion(Map<String, dynamic> pageData) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 347.w,

            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pageData['number'],
                  style: pretendardSemiBold(context).copyWith(
                      color: customColors.black,
                      fontSize: 20
                  ),
                ),
                Expanded(
                  child: Text(
                    pageData['question'],
                    style: pretendardBold(context).copyWith(
                        color: customColors.black,
                        fontSize: 20
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(pageData['options'].length, (index) {
            final option = pageData['options'][index];
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
                  style: pretendardMedium(context).copyWith(
                      fontSize: 14.sp,
                      color: isSelected
                          ? customColors.primary
                          : customColors.black),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
///////                      결과 화면 정의                       ///////
//////////////////////////////////////////////////////////////////////

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text:
              TextSpan(
                style: pretendardBold(context).copyWith(fontSize: 24),
                children: <TextSpan>[
                  const TextSpan(text: "강희"),
                  const TextSpan(text: " 님은\n"),
                  const TextSpan(text: "\n", style: TextStyle(fontSize: 16)),
                  const TextSpan(text: "상위 "),
                  TextSpan(text: "7%", style: TextStyle(color: ThemeManager.customColors.primary)),
                  const TextSpan(text: "의\n"),
                  const TextSpan(text: "\n", style: TextStyle(fontSize: 16)),
                  const TextSpan(text: "문해력을 가지고 있으시네요!\n"),
                  const TextSpan(text: "\n", style: TextStyle(fontSize: 16)),
                  const TextSpan(text: '🔎\n', style: TextStyle(fontSize: 96),),
                  const TextSpan(text: "\n"),
                  TextSpan(text: '이제 본격적으로 문해력을 기르러 가볼까요?\n\n', style: pretendardBold(context).copyWith(color: ThemeManager.customColors.gray02, fontSize: 16),),
                ]
              ),
            ),

            Container(
              width: 351.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: ThemeManager.customColors.primary
              ),
              child: TextButton(
                onPressed: (){

                },
                child: Text("학습 시작하기",
                  style: pretendardSemiBold(context).copyWith(color: ThemeManager.customColors.white,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
