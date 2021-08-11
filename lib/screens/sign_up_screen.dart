import 'dart:ui';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/services/auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;

  String _name = '';
  String _email = '';
  String _password = '';

  bool _inactive = false;

  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                getTranslated(context, 'SignUp'),
                strutStyle: StrutStyle(
                  forceStrutHeight: lang == 'ar' ? true : false,
                ),
                style: TextStyle(
                    fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                    color: Color(0xFF484451),
                    fontSize: 32,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(value)) {
                            return getTranslated(context, 'FullNameError');
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          if (val != '') {
                            setState(() {
                              _inactive = true;
                              _name = val;
                            });
                          } else {
                            setState(() {
                              _inactive = false;
                              _name = val;
                            });
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
                            suffixIcon: (_name != '')
                                ? RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                        .hasMatch(_name)
                                    ? Image.asset(
                                        'assets/images/icons/wrong.png')
                                    : Image.asset(
                                        'assets/images/icons/correct.png')
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
                            labelText: getTranslated(context, 'FullName'),
                            labelStyle: TextStyle(
                                color: Color(0xFF716B6B),
                                fontSize: 16,
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto')),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return getTranslated(context, 'EmailAddressError');
                          } else {
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
                            setState(() {
                              _inactive = false;
                              _email = val;
                            });
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
                            suffixIcon: (_email != '')
                                ? RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(_email)
                                    ? Image.asset(
                                        'assets/images/icons/correct.png')
                                    : SvgPicture.asset(
                                        'assets/images/icons/wrong.png')
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
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: (_password != '') ? 10 : 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // added line
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      icon: _obscureText
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off)),
                                  (_password != '')
                                      ? (_password.length > 8)
                                          ? Image.asset(
                                              'assets/images/icons/correct.png')
                                          : Image.asset(
                                              'assets/images/icons/wrong.png')
                                      : Container()
                                ],
                              ),
                            ),
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
                        child: RichText(
                            textAlign:
                                lang == 'ar' ? TextAlign.right : TextAlign.left,
                            text: TextSpan(children: [
                              TextSpan(
                                text: getTranslated(context, 'SignUpSubtitle'),
                                style: TextStyle(
                                    color: Color(0xFF716B6B),
                                    fontSize: 14,
                                    fontFamily:
                                        lang == 'ar' ? 'DIN' : 'Roboto'),
                              ),
                              TextSpan(
                                text: getTranslated(
                                    context, 'TermsAndConditions'),
                                style: TextStyle(
                                    color: Color(0xFFA229F2),
                                    fontSize: 14,
                                    fontFamily:
                                        lang == 'ar' ? 'DIN' : 'Roboto'),
                              ),
                              TextSpan(
                                text: getTranslated(context, 'AndTxt'),
                                style: TextStyle(
                                    color: Color(0xFF716B6B),
                                    fontSize: 14,
                                    fontFamily:
                                        lang == 'ar' ? 'DIN' : 'Roboto'),
                              ),
                              TextSpan(
                                text: getTranslated(context, 'PrivacyPolicy'),
                                style: TextStyle(
                                    color: Color(0xFFA229F2),
                                    fontSize: 14,
                                    fontFamily:
                                        lang == 'ar' ? 'DIN' : 'Roboto'),
                              ),
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          height: 72,
                          width: 315,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            gradient: LinearGradient(
                                begin: Alignment(1.0, 2.0),
                                end: Alignment(-1.0, -2.0),
                                transform: GradientRotation(math.pi / 4),
                                stops: [
                                  0.0,
                                  0.25,
                                  0.75,
                                  1
                                ],
                                colors: [
                                  Color(0xFF4F5BD5),
                                  Color(0xFFA72DAB),
                                  Color(0xFFD62976),
                                  Color(0xFFFA7E1E)
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
                                  var result =
                                      await _auth.registerWithEmailAndPassword(
                                          _email, _password);
                                  if (result != null) {
                                    await _firestore
                                        .collection('users')
                                        .doc(_email)
                                        .set({
                                      'Email': _email,
                                      'Name': _name,
                                      'photo_url': 'default/profile.png'
                                    });
                                  }

                                  Navigator.pushNamed(context, '/Wrapper');
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getTranslated(context, 'GetStartedBtn'),
                                      strutStyle: StrutStyle(
                                        forceStrutHeight:
                                            lang == 'ar' ? true : false,
                                      ),
                                      style: TextStyle(
                                          fontFamily:
                                              lang == 'ar' ? 'DIN' : 'Roboto',
                                          fontSize: 24,
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
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _inactive == false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          getTranslated(context, 'OrSignupWith'),
                          strutStyle: StrutStyle(
                            forceStrutHeight: lang == 'ar' ? true : false,
                          ),
                          style: TextStyle(
                              color: Color(0xFF716B6B),
                              fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(
                                'assets/images/icons/facebook_logo.svg'),
                            iconSize: 50,
                            onPressed: () async {
                              await _auth.signInWithFacebook();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                                'assets/images/icons/google_logo.svg'),
                            iconSize: 50,
                            onPressed: () async {
                              await _auth.signInWithGoogleSignIn();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                                'assets/images/icons/apple_logo.svg'),
                            iconSize: 50,
                            onPressed: () async {
                              await _auth.signInWithAppleSignIn();
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: [
                              TextSpan(
                                text: getTranslated(
                                    context, 'alreadyHaveAnAccount'),
                                style: TextStyle(
                                    color: Color(0xFFA3A3A3),
                                    fontSize: 12,
                                    fontFamily:
                                        lang == 'ar' ? 'DIN' : 'Roboto'),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.pushNamed(context, '/Login'),
                                text: getTranslated(context, 'LoginTxt'),
                                style: TextStyle(
                                    color: Color(0xFFA229F2),
                                    fontSize: 12,
                                    fontFamily:
                                        lang == 'ar' ? 'DIN' : 'Roboto'),
                              ),
                            ])),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
