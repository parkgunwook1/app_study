import 'package:flutter/material.dart';
import 'package:myapp/config/Palatee.dart';


class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> { 
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';



  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palatee.backgroundColor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('image/red.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 35, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60.0),
                      isSignupScreen?
                      RichText(
                        text: const TextSpan(
                            text: 'Welcome',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 15,
                              color: Colors.black45,
                            ),
                            children: [
                              TextSpan(
                                text: ' to My Chatting App',
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ):RichText(
                        text: const TextSpan(
                            text: '반갑다 박건욱이',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 15,
                              color: Colors.black45,
                            ),
                            children: [
                              TextSpan(
                                text: ' 또왔냐',
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                      const SizedBox(height: 10),
                      isSignupScreen?
                      const Text('Sign up to contineu',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 1.0)):
                      const Text('로그인 빠르게 해줘',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 1.0))
                    ],
                  ),
                ),
              ),
            ),
            //배경
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: 180,
              // right: 20,
              // left: 20,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 10,
                        blurStyle: BlurStyle.normal,
                        spreadRadius: 2,
                      ),
                    ]),
                height: isSignupScreen?300.0:230.0,
                width: MediaQuery.of(context).size.width - 40,
                //각 디바이스의 실제 너비를 구할수 있다.
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = false;  //로그인 클릭
                                // _height = 230.0;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen       // 삼항 조건연산자
                                          ? Palatee.activeColor
                                          : Palatee.textColor1),
                                ),
                                if (!isSignupScreen)
                                  Container(                       // 단어 밑줄 
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;  // 회원가입 클릭
                                // _height = 300.0;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen        //삼항 조건 연산
                                          ? Palatee.activeColor
                                          : Palatee.textColor1),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if(isSignupScreen)
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty || value.length<4){
                                    return '길이 4글자 이상 입력해라';
                                  }
                                  return null;
                                },
                                key: const ValueKey(1),
                                onSaved: (value){
                                  userName = value!;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.account_circle,  //내가 해결한 부분, prefix align을 해결했다.
                                      color: Palatee.iconColor),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palatee.textColor1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palatee.textColor1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35.0))),
                                  hintText: 'User name',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Palatee.textColor1
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                ),

                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty || !value.contains('@')){
                                    return '형식에 맞게 이메일 주소를 입력해주오';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  userEmail = value!;
                                },
                                key: const ValueKey(2),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email,  //내가 해결한 부분, prefix align을 해결했다.
                                      color: Palatee.iconColor),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palatee.textColor1,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(35.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palatee.textColor1,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(35.0))),
                                  hintText: 'e-mail',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Palatee.textColor1
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty || value.length<6){
                                    return '비밀번호는 6글자 이상 입력할것!!';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  userPassword = value!;
                                },
                                key: const ValueKey(3),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock,  //내가 해결한 부분, prefix align을 해결했다.
                                      color: Palatee.iconColor),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palatee.textColor1,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(35.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palatee.textColor1,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(35.0))),
                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Palatee.textColor1
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                ),

                              )
                            ],
                          ),
                        ),
                      ),
                      if(!isSignupScreen)
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value){
                                    if(value!.isEmpty || !value.contains('@')){
                                      return '형식에 맞게 이메일 주소를 입력해주오';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userEmail = value!;
                                  },
                                  key: const ValueKey(4),
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email,  //내가 해결한 부분, prefix align을 해결했다.
                                        color: Palatee.iconColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palatee.textColor1,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(35.0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palatee.textColor1,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(35.0))),
                                    hintText: 'e-mail',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palatee.textColor1
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  ),

                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  validator: (value){
                                    if(value!.isEmpty || value.length<6){
                                      return '비밀번호는 6글자 이상 입력할것!!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userPassword = value!;
                                  },
                                  key: const ValueKey(5),
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock,  //내가 해결한 부분, prefix align을 해결했다.
                                        color: Palatee.iconColor),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palatee.textColor1,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(35.0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palatee.textColor1,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(35.0))),
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palatee.textColor1
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            //텍스트폼 필드
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: isSignupScreen?450:380,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),

                    child: GestureDetector(
                      onTap: (){
                        _tryValidation();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                            colors: [
                              Colors.orange,
                              Colors.red,
                            ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        ),
                        child: const Icon(Icons.arrow_forward,
                        color: Colors.white),

                      ),
                    ),
                  ),
                )),
            //버튼
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: isSignupScreen? MediaQuery.of(context).size.height-125:MediaQuery.of(context).size.height-165,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text(isSignupScreen?'or Signup with':'회원이면 빠르게 로그인하자'),
                    const SizedBox(height: 10),
                    TextButton.icon(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, minimumSize: const Size(155, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          backgroundColor: Palatee.googleColor,
                        ),

                        icon: const Icon(Icons.add),
                        label: const Text('Google'))
                  ],

                )),
            //아래 구글 로그인
          ],
        ),
      ),
    );
  }
}