import 'package:flutter/material.dart';
import 'package:login_register/ui/custom_paint/flower_paint.dart';
import 'package:login_register/ui/custom_paint/slate.dart';
import 'package:login_register/utlities/app_colors.dart';
import 'package:login_register/utlities/gradient_raised_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double screenWidth = 0.0;
  double screenheight = 0.0;
  bool isSwitched = true;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  FocusNode emailNode = FocusNode();
  FocusNode passawordNode = FocusNode();
  bool loading = false;
  String _email;
  String _password;
  bool isObscurePassword = true;
  bool isContainsRequiredCharacter = false;
  bool isContainsAtLeastSpecialCharacter = false;
  bool isContainsUpperCaseCharacter = false;
  bool isContainsNumber = false;
  int requiredPasswordCharacter = 8;

  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passawordNode = FocusNode();
    emailNode = FocusNode();
    loading = false;
    passwordController.addListener(_onChangePassword);
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [kLighOrange2, kPurple])),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    //hiveImage(),
                    SizedBox(
                      height: 50,
                    ),
                    _existingLoginSwitch(),
                    SizedBox(
                      height: 10,
                    ),
                    _forgotPassword(),
                    SizedBox(
                      height: 10,
                    ),
                    _orDivider(),
                    SizedBox(
                      height: 20,
                    ),
                    _socialLogin(),
                  ],
                ),
              ),
            ),
          ),
          loading ? LoadingIndicator() : Container()
        ],
      ),
    );
  }

//  Widget methods
  Widget hiveImage() {
    return Image.asset(
      'assets/images/hive.png',
      width: 230,
      height: 230,
    );
  }

  Widget _existingLoginSwitch() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            width: screenWidth * 0.7,
            height: 40,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              tabs: [
                Tab(
                  child: Text(
                    'Existing',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Tab(text: 'New'),
              ],
            ),
          ),
          Container(
            width: screenWidth * .8,
            height: screenheight * .65,
            margin: EdgeInsets.only(top: 10),
            child: TabBarView(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        hiveImage(),
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                          ),
                          child: Form(
                            key: _loginFormKey,
                            autovalidate: _autoValidate,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                emailFormField(),
                                SizedBox(
                                  height: 10,
                                ),
                                passwordFormField(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: screenWidth * 0.1,
                        child: LoginButton(context)),
                  ],
                ),
                Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _passwordGuideWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                          ),
                          child: Form(
                            key: _registerFormKey,
                            autovalidate: _autoValidate,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                emailFormField(),
                                SizedBox(
                                  height: 10,
                                ),
                                passwordFormField(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: screenWidth * 0.1,
                        child: RegisterButton(context)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _forgotPassword() {
    return Container(
      child: InkWell(
        onTap: () {
          debugPrint('clicked');
        },
        child: Text(
          'Forgot password?',
          style: TextStyle(decoration: TextDecoration.underline, fontSize: 15),
        ),
      ),
    );
  }

  Container _orDivider() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(.1),
                Colors.white.withOpacity(0.5)
              ],
            )),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              'Or',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 100,
            height: 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.1)
              ],
            )),
          ),
        ],
      ),
    );
  }

  Container _socialLogin() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {},
            mini: true,
            heroTag: 'fab_facebook',
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/facebook.png',
              width: 20,
              height: 20,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {},
            mini: true,
            heroTag: 'fab_google',
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/Google.png',
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle CustomTextStyle() {
    return TextStyle(color: Colors.black, fontSize: 15.0);
  }

  InputDecoration CustomTextDecoration(
      {String text, IconData icon, bool trailingicon = false}) {
    return InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        //alignLabelWithHint: true,
        //labelStyle: TextStyle(color: Colors.white30),
        //labelText: text,
        prefixIcon: Icon(icon, color: Colors.blueGrey[700]),
        suffixIcon: trailingicon
            ? IconButton(
                onPressed: () {
                  isObscurePassword = !isObscurePassword;
                  setState(() {});
                },
                icon: Icon(Icons.remove_red_eye),
                color: Colors.grey,
              )
            : null
//      enabledBorder: UnderlineInputBorder(
//          borderSide: BorderSide(color: Colors.blueGrey[700])),
//      focusedBorder:
//          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
//      errorBorder:
//          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        );
  }

  TextFormField passwordFormField() {
    return TextFormField(
      controller: passwordController,
      enabled: true,
      enableInteractiveSelection: true,
      obscureText: isObscurePassword,
      textInputAction: TextInputAction.done,
      style: CustomTextStyle(),
      focusNode: passawordNode,
      decoration: CustomTextDecoration(
          icon: Icons.lock, text: "Password", trailingicon: true),
      validator: (text) {
        return _validatePassword(value: text);
      },
      onSaved: (val) => _password = val,
    );
  }

  TextFormField emailFormField() {
    return TextFormField(
      enabled: true,
      enableInteractiveSelection: true,
      focusNode: emailNode,
      style: CustomTextStyle(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration:
          CustomTextDecoration(icon: Icons.email, text: "Email Address"),
      textCapitalization: TextCapitalization.none,
      onFieldSubmitted: (term) {
        emailNode.unfocus();
        FocusScope.of(context).requestFocus(passawordNode);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter email';
        } else if (!new RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return "Plase enter valid email";
        }
      },
      onSaved: (val) => _email = val,
    );
  }

  Widget LoginButton(BuildContext context) {
    return RaisedGradientButton(
        child: Text(
          'Login'.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        height: 80,
        width: screenWidth * 0.6,
        gradient: LinearGradient(
          colors: <Color>[kPruple, kLighOrange2],
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          final form = _loginFormKey.currentState;

          if (form.validate()) {
            form.save();
            print('email is $_email and password is $_password');
            setState(() {
              loading = true;
            });
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                loading = false;
              });
            });
          } else {
            setState(() {
              _autoValidate = true;
            });
          }
        });
  }

  Widget RegisterButton(BuildContext context) {
    return RaisedGradientButton(
        child: Text(
          'Register'.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        height: 80,
        width: screenWidth * 0.6,
        gradient: LinearGradient(
          colors: <Color>[kPruple, kLighOrange2],
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          final form = _registerFormKey.currentState;

          if (form.validate()) {
            form.save();
            print('email is $_email and password is $_password');
            setState(() {
              loading = true;
            });
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                loading = false;
              });
            });
          } else {
            setState(() {
              _autoValidate = true;
            });
          }
        });
  }

  Widget LoadingIndicator() {
    return Positioned(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(strokeWidth: 0.7),
          ),
        ),
      ),
    );
  }

  Widget _flowerPaint() {
    return CustomPaint(
      painter: FlowerPaint(),
      child: Center(
        child: Container(
          width: 230,
          height: 230,
        ),
      ),
    );
  }

  Widget _passwordGuidePainter() {
    return CustomPaint(
      child: Container(
        width: screenWidth * .7,
        height: 230,
      ),
      foregroundPainter: SlatePainter(),
    );
  }

  Widget _passwordGuideWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(16)),
//          gradient: LinearGradient(
//              colors: [kPurple.withOpacity(0.2), kLighOrange2.withOpacity(0.3)],
//              stops: [0.2, 0.9],
//              begin: AlignmentDirectional.topStart,
//              end: AlignmentDirectional.bottomCenter)
      ),
      width: screenWidth * .7,
      height: 230,
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 160,
              width: screenWidth * .99,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            Positioned(
                left: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 160,
                  width: screenWidth * .63,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                character(),
                Container(
                  width: screenWidth * .63,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                _specialCharacter(),
                Container(
                  width: screenWidth * .63,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                _UpperCaseCharacter(),
                Container(
                  width: screenWidth * .63,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                _Number(),
                Container(
                  width: screenWidth * .63,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 50,
              top: 0,
              child: Container(
                width: 2,
                height: 500,
                color: Colors.pinkAccent,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container character() {
    return Container(
      height: 16,
      width: screenWidth * .63,
      padding: EdgeInsets.only(left: 50),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          AnimatedDefaultTextStyle(
              child: Text(
                '8 Character',
              ),
              style: TextStyle(
                  fontSize: 17,
                  color: isContainsRequiredCharacter ? Colors.grey : kPurple,
                  fontWeight: isContainsRequiredCharacter
                      ? FontWeight.normal
                      : FontWeight.bold),
              duration: Duration(milliseconds: 300)),
          AnimatedContainer(
            margin: EdgeInsets.only(top: 5),
            duration: Duration(milliseconds: 400),
            height: 4,
            width: isContainsRequiredCharacter ? screenWidth * .25 : 0,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
          )
        ],
      ),
    );
  }

  Container _specialCharacter() {
    return Container(
      height: 16,
      width: screenWidth * .63,
      padding: EdgeInsets.only(left: 50),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          AnimatedDefaultTextStyle(
              child: Text(
                '1 Special Character',
              ),
              style: TextStyle(
                  fontSize: 17,
                  color:
                      isContainsAtLeastSpecialCharacter ? Colors.grey : kPurple,
                  fontWeight: isContainsAtLeastSpecialCharacter
                      ? FontWeight.normal
                      : FontWeight.bold),
              duration: Duration(milliseconds: 300)),
          AnimatedContainer(
            margin: EdgeInsets.only(top: 5),
            duration: Duration(milliseconds: 400),
            height: 4,
            width: isContainsAtLeastSpecialCharacter ? screenWidth * .38 : 0,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
          )
        ],
      ),
    );
  }

  Container _UpperCaseCharacter() {
    return Container(
      height: 18,
      width: screenWidth * .63,
      padding: EdgeInsets.only(left: 50),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          AnimatedDefaultTextStyle(
              child: Text(
                '1 Upper Case',
              ),
              style: TextStyle(
                  fontSize: 17,
                  color: isContainsUpperCaseCharacter ? Colors.grey : kPurple,
                  fontWeight: isContainsUpperCaseCharacter
                      ? FontWeight.normal
                      : FontWeight.bold),
              duration: Duration(milliseconds: 300)),
          AnimatedContainer(
            margin: EdgeInsets.only(top: 5),
            duration: Duration(milliseconds: 400),
            height: 4,
            width: isContainsUpperCaseCharacter ? screenWidth * .26 : 0,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
          )
        ],
      ),
    );
  }

  Container _Number() {
    return Container(
      height: 18,
      width: screenWidth * .63,
      padding: EdgeInsets.only(left: 50),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          AnimatedDefaultTextStyle(
              child: Text(
                '1 Number',
              ),
              style: TextStyle(
                  fontSize: 17,
                  color: isContainsNumber ? Colors.grey : kPurple,
                  fontWeight:
                      isContainsNumber ? FontWeight.normal : FontWeight.bold),
              duration: Duration(milliseconds: 300)),
          AnimatedContainer(
            margin: EdgeInsets.only(top: 5),
            duration: Duration(milliseconds: 400),
            height: 4,
            width: isContainsNumber ? screenWidth * .2 : 0,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
          )
        ],
      ),
    );
  }

  void _onChangePassword() {
    _validatePassword(value: passwordController.text, isRepaint: true);
  }

  String _validatePassword({String value, bool isRepaint = false}) {
    if (value.isEmpty) {
      return 'Please enter password';
    }

    if (value.length < requiredPasswordCharacter) {
      if (isRepaint) {
        setState(() {
          isContainsRequiredCharacter = false;
        });
      }
      return 'Password must be $requiredPasswordCharacter digit';
    } else {
      if (isRepaint) {
        setState(() {
          isContainsRequiredCharacter = true;
        });
      }
    }

    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      if (isRepaint) {
        setState(() {
          isContainsAtLeastSpecialCharacter = true;
        });
      }
    } else {
      if (isRepaint) {
        setState(() {
          isContainsAtLeastSpecialCharacter = false;
        });
      }
      return 'Password must contain at least 1 special character';
    }

    if (value.contains(RegExp(r'[A-Z]'))) {
      if (isRepaint) {
        setState(() {
          isContainsUpperCaseCharacter = true;
        });
      }
    } else {
      if (isRepaint) {
        setState(() {
          isContainsUpperCaseCharacter = false;
        });
      }
      return 'Password must contain at least 1 Upper Case character';
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      if (isRepaint) {
        setState(() {
          isContainsNumber = true;
        });
      }
    } else {
      if (isRepaint) {
        setState(() {
          isContainsNumber = false;
        });
      }
      return 'Password must contain at least 1 Number';
    }
  }
}
