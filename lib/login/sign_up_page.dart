import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _id = '';
  String _password = '';
  String _confirm = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: this._formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 80.0),
              //Username 검사
              TextFormField(
                onSaved: (value){
                  setState(() {
                    _id = value as String;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Username';
                  }
                  //글자 분할 후 갯수 세기. 글자 검사까지
                  RegExp letterRegExp = RegExp(r'[a-zA-Z]');
                  RegExp digitRegExp = RegExp(r'[0-9]');
                  Iterable<Match> letterMatches = letterRegExp.allMatches(value);
                  Iterable<Match> digitMatches = digitRegExp.allMatches(value);
                  if(letterMatches.length < 3 || digitMatches.length < 3){
                    return 'Username is invalid';
                  }
                },
                keyboardType: TextInputType.text,
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 12.0),
              //Password 검사
              TextFormField(
                onSaved: (value){
                  setState(() {
                    _password = value as String;
                  });
                },
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please enter Password';
                  }
                },
                onChanged: (value) => _password,
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
              //Confirm Password 검사
              TextFormField(
                onSaved: (value){
                  setState(() {
                    _confirm = value as String;
                  });
                },
                onChanged: (value) => _confirm,
                //password와 confirm password가 일치하는지 검사
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please enter Password';
                  }
                  if(_confirmController.text!=_passwordController.text){
                    return 'Confirm Password doesn\'t match Password';
                  }
                },
                controller: _confirmController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
              //email 검사
              TextFormField(
                onSaved: (value){
                  setState(() {
                    _email = value as String;
                  });
                },
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please enter Email Address';
                  }
                  // 하는김에 이메일도 구현해봤습니다.
                  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',);
                  if (!emailRegExp.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Email Address',
                ),
                obscureText: false,
              ),
              const SizedBox(height: 12.0),
              //제출 버튼. 검사 후 pop을 통해 login page로
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('SIGN UP'),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
