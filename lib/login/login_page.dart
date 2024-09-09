import 'package:flutter/material.dart';
import 'package:haedal/components/my_divider.dart';
import 'package:haedal/theme/font.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app_state.dart';
import '../components/my_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;  // 로딩 상태 관리 변수

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Google Sign-In
  Future<UserCredential> signInWithGoogle() async {
    await GoogleSignIn().signOut();  // 현재 로그인한 계정을 로그아웃
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Firestore에 사용자 정보 저장
    User? user = userCredential.user;
    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      DocumentSnapshot docSnapshot = await userDoc.get();

      if (!docSnapshot.exists) {
        // 문서가 존재하지 않으면 새로 생성
        await userDoc.set({
          'name': user.displayName,
          'email': user.email,
          'uid': user.uid,
          'status_message': 'I promise to take the test honestly before GOD.',
        }, SetOptions(merge: true));
      } else {
        // 문서가 존재하면 기존 상태 메시지를 가져옴
        String statusMessage = docSnapshot['status_message'] ?? 'I promise to take the test honestly before GOD.';
        await userDoc.set({
          'name': user.displayName,
          'email': user.email,
          'uid': user.uid,
          'status_message': statusMessage,
        }, SetOptions(merge: true));
      }
    }
    return userCredential;
  }



  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // Google 로그인 핸들러
    Future<void> _handleSignIn() async {
      setState(() {
        _isLoading = true;  // 로딩 상태 활성화
      });

      try {
        UserCredential userCredential = await signInWithGoogle();
        User? user = userCredential.user;
        if (user != null) {
          print('로그인 성공: ${user.email}');
          appState.setUser(user); // 앱 상태에 사용자 설정
          Navigator.pushNamed(context, '/');
        } else {
          print('로그인 실패');
        }
      } catch (e) {
        print('로그인 오류: $e');
      } finally {
        setState(() {
          _isLoading = false;  // 로딩 상태 비활성화
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          // GestureDetector를 통해 키보드 이외 영역 선택 시 키보드 사라짐 구현
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.2),
                Container(
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HaeDal',
                          textAlign: TextAlign.center,
                          style: pretendardBoldPrimary(context),
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
                          child: Icon(Icons.mail_outline_rounded, color: Theme.of(context).colorScheme.shadow,)),
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
                          child: Icon(Icons.lock_outline_rounded, color: Theme.of(context).colorScheme.shadow,)),
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
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: AutoLoginToggle(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
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

                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Button(
                        function: _handleSignIn,
                        title: '로그인',
                      ),
                    ),
                  ],
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
                      onTap: () {
                        Navigator.pushNamed(context, '/login/sign');
                      },
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
                  child: Text("또는 간편로그인하기", style: pretendardRegularSecond(context),),
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
                        onTap: () {
                          // function 내용
                          _handleSignIn();
                        },
                      ),
                      SizedBox(width: 12,),
                      GestureDetector(
                        child: Image.asset('assets/images/appleicon.png'),
                        onTap: () {
                          // function 내용
                        },
                      ),
                      SizedBox(width: 12,),
                      GestureDetector(
                        child: Image.asset('assets/images/facebookicon.png'),
                        onTap: () {
                          // function 내용
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
