import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'dart:math' as math;

import 'package:kwayes/services/auth.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _obscureText = true;

  String _email = '';
  String _password = '';

  bool _emailWrong = false;

  bool _inactive = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, 'LoginIn'),
                strutStyle: StrutStyle(
                  forceStrutHeight: lang == 'ar' ? true : false,
                ),
                style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFF484451),
                    fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _emailWrong = true;
                            });
                            return getTranslated(context, 'LoginError');
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            setState(() {
                              _emailWrong = true;
                            });
                            return getTranslated(context, 'LoginError');
                          } else {
                            setState(() {
                              _emailWrong = false;
                            });
                            return null;
                          }
                        },
                        onChanged: (val) {
                          if (val != '') {
                            setState(() {
                              _inactive = true;
                              _email = val;
                            });
                          } else {
                            _inactive = false;
                            _email = val;
                          }
                        },
                        strutStyle: StrutStyle(
                          forceStrutHeight: lang == 'ar' ? true : false,
                        ),
                        style: TextStyle(
                            color: Color(0xFF484451),
                            fontSize: 16,
                            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto'),
                        decoration: InputDecoration(
                            suffixIcon: (_emailWrong)
                                ? Image.asset(
                                    'assets/images/icons/error.png',
                                  )
                                : null,
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFFF3131), width: 1)),
                            errorStyle: TextStyle(
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                fontSize: 12,
                                color: Color(0xFFFF3131)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF716B6B), width: 1)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF484451), width: 1)),
                            labelText: getTranslated(context, 'EmailAddress'),
                            labelStyle: TextStyle(
                                color: Color(0xFF716B6B),
                                fontSize: 16,
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto')),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return getTranslated(context, 'PasswordError');
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          if (val != '') {
                            setState(() {
                              _inactive = true;
                              _password = val;
                            });
                          } else {
                            setState(() {
                              _inactive = false;
                              _password = val;
                            });
                          }
                        },
                        obscureText: _obscureText,
                        strutStyle: StrutStyle(
                          forceStrutHeight: lang == 'ar' ? true : false,
                        ),
                        style: TextStyle(
                            color: Color(0xFF484451),
                            fontSize: 16,
                            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto'),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: _obscureText
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFFF3131), width: 1)),
                            errorStyle: TextStyle(
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                fontSize: 12,
                                color: Color(0xFFFF3131)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF716B6B), width: 1)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF484451), width: 1)),
                            labelText: getTranslated(context, 'Password'),
                            labelStyle: TextStyle(
                                color: Color(0xFF716B6B),
                                fontSize: 16,
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto')),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/ForgetPassowrd');
                            },
                            child: Text(
                              getTranslated(context, 'ForgetYourPassword'),
                              strutStyle: StrutStyle(
                                forceStrutHeight: lang == 'ar' ? true : false,
                              ),
                              style: TextStyle(
                                  color: Color(0xFF716B6B),
                                  fontSize: 12,
                                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto'),
                              textAlign: lang == 'ar'
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(
                          child: Container(
                            height: 72,
                            width: 315,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              gradient: LinearGradient(
                                  transform:
                                      GradientRotation(-180 * (math.pi / 180)),
                                  begin: Alignment(
                                      1.396263599395752, 0.2368917167186737),
                                  end: Alignment(
                                      -0.2368917167186737, 0.07294762879610062),
                                  colors: [
                                    Color.fromRGBO(
                                        149, 46, 191, 0.9800000190734863),
                                    Color.fromRGBO(214, 41, 118, 1)
                                  ]),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    )),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await _auth.signInWithEmailAndPassword(
                                        _email, _password);

                                    Navigator.pushNamed(context, '/Wrapper');
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getTranslated(context, 'LoginIn'),
                                        strutStyle: StrutStyle(
                                          forceStrutHeight:
                                              lang == 'ar' ? true : false,
                                        ),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontFamily:
                                                lang == 'ar' ? 'DIN' : 'Roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SvgPicture.asset((lang == 'ar')
                                          ? 'assets/images/icons/forward_outlined_ar.svg'
                                          : 'assets/images/icons/forward_outlined.svg'),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _inactive == false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: RichText(
                        textAlign:
                            lang == 'ar' ? TextAlign.right : TextAlign.left,
                        text: TextSpan(children: [
                          TextSpan(
                            text: getTranslated(context, 'NeedAnAccount'),
                            style: TextStyle(
                                color: Color(0xFFA3A3A3),
                                fontSize: 12,
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto'),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Navigator.pushNamed(context, '/SignUp'),
                            text: getTranslated(context, 'Signup'),
                            style: TextStyle(
                                color: Color(0xFFA229F2),
                                fontSize: 12,
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto'),
                          ),
                        ])),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
