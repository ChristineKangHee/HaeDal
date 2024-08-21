import 'package:flutter/material.dart';
import 'package:haedal/components/my_divider.dart';
import 'package:haedal/theme/font.dart';

import '../app_state.dart';
import '../components/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child:
          GestureDetector(
            //GestureDetector를 통해 키보드 이외 영역 선택 시 키보드 사라짐 구현
            onTap: () => FocusScope.of(context).unfocus,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: screenHeight * 0.2),
                  Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,0,0,0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'HaeDal',
                            textAlign: TextAlign.center,
                            style: pretendardBoldPrimary(context)
                          ),
                          Text(
                            '문해력 학습 앱',
                            textAlign: TextAlign.start,
                            style: pretendardLightLast(context),
                          )
                        ],
                      ),
                    ),
                  ),

                  //////////////////////////////////////////////////////////////////////
                  ///////                        이메일                            ///////
                  //////////////////////////////////////////////////////////////////////

                  SizedBox(height: screenHeight * 0.05),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Icon(Icons.mail_outline_rounded, color: Theme.of(context).colorScheme.shadow,)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline, // 원하는 색상으로 변경
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline, // 원하는 색상으로 변경
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline, // 원하는 색상으로 변경
                          ),
                        ),
                        filled: true,
                        labelText: '이메일',
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        hintText: 'ex. zero@gmail.com',
                      ),
                    ),
                  ),

                  //////////////////////////////////////////////////////////////////////
                  ///////                        비밀 번호                         ///////
                  //////////////////////////////////////////////////////////////////////

                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    child: TextField(
                      inputFormatters: [],
                      controller: _passwordController,

                      decoration: InputDecoration(
                        prefixIcon: Container(
                            margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Icon(Icons.lock_outline_rounded, color: Theme.of(context).colorScheme.shadow,)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline, // 원하는 색상으로 변경
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline, // 원하는 색상으로 변경
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline, // 원하는 색상으로 변경
                          ),
                        ),
                        filled: true,
                        labelText: '비밀번호',
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        hintText: '8자로 작성해주세요.',
                      ),

                      // maxLength: 8,
                      obscureText: true,
                    ),
                  ),

                  //////////////////////////////////////////////////////////////////////
                  ///////               자동로그인, 아이디/비밀번호 찾기                 ///////
                  //////////////////////////////////////////////////////////////////////

                  SizedBox(height: screenHeight * 0.015 / 2),
                  Container(
                    width: screenWidth,
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16,0,0,0),
                            child: AutoLoginToggle(),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,16,0),
                            child: Text("아이디/비밀번호 찾기", style: pretendardRegularSecond(context),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015 / 2),

                  //////////////////////////////////////////////////////////////////////
                  ///////                         로그인                           ///////
                  //////////////////////////////////////////////////////////////////////

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Button(
                      function: () {
                        Navigator.pushNamed(context, '/') ;
                        //function 은 상황에 맞게 재 정의 할 것.
                      },
                      title: '로그인',
                      // 버튼 안에 들어갈 텍스트.
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  //////////////////////////////////////////////////////////////////////
                  ///////                        회원가입                          ///////
                  //////////////////////////////////////////////////////////////////////

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '계정이 없으신가요? ',
                        style: pretendardSemiBoldSecond(context),
                      ),
                      GestureDetector(
                        onTap: (){ Navigator.pushNamed(context, '/login/sign') ;},
                        child: Text(
                          '회원가입',
                          style: pretendardSemiBoldPrimary(context),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.03),
                  const BigDivider(),
                  SizedBox(height: screenHeight * 0.03),

                  //////////////////////////////////////////////////////////////////////
                  ///////                       간편 로그인                         ///////
                  //////////////////////////////////////////////////////////////////////

                  Container(
                    alignment: AlignmentDirectional.center,
                      width: screenWidth,
                      child: Text("또는 간편로그인하기", style: pretendardRegularSecond(context),)
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  // ****간편 로그인 아이콘****
                  Container(
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Image.asset('assets/images/googleidcon.png'),
                          onTap: (){
                            // function 내용
                          },
                        ),
                        SizedBox(width: 12,),
                        GestureDetector(
                          child: Image.asset('assets/images/appleicon.png'),
                          onTap: (){
                            // function 내용
                          },
                        ),
                        SizedBox(width: 12,),
                        GestureDetector(
                          child: Image.asset('assets/images/facebookicon.png'),
                          onTap: (){
                            // function 내용
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        )
    );
  }
}