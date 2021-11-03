import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/model/language.dart';
import 'dart:math' as math;

import 'package:kwayes/services/auth.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AuthService _auth = AuthService();
  List<Language> languages;
  Language selectedLang;
  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/logo/logo.png"),
            )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  height: 72,
                  width: 315,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(162, 41, 242, 0.25),
                          offset: Offset(0, 8),
                          blurRadius: 16)
                    ],
                    gradient: LinearGradient(
                        transform: GradientRotation(-180 * (math.pi / 180)),
                        begin: Alignment(1.396263599395752, 0.2368917167186737),
                        end:
                            Alignment(-0.2368917167186737, 0.07294762879610062),
                        colors: [
                          Color.fromRGBO(149, 46, 191, 0.9800000190734863),
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/Login');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated(context, 'LoginIn'),
                              strutStyle: StrutStyle(
                                forceStrutHeight: lang == 'ar' ? true : false,
                              ),
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                  fontWeight: FontWeight.w500),
                            ),
                            SvgPicture.asset((lang == 'ar')
                                ? 'assets/images/icons/forward_outlined_ar.svg'
                                : 'assets/images/icons/forward_outlined.svg'),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 72,
                    width: 315,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Color(0xFFA229F2),
                          side: BorderSide(color: Color(0xFFA229F2)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated(context, 'SignUp'),
                              strutStyle: StrutStyle(
                                forceStrutHeight: lang == 'ar' ? true : false,
                              ),
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                  fontWeight: FontWeight.w500),
                            ),
                            SvgPicture.asset(
                              (lang == 'ar')
                                  ? 'assets/images/icons/forward_outlined_purple_ar.svg'
                                  : 'assets/images/icons/forward_outlined_purple.svg',
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/SignUp');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    getTranslated(context, 'OrSignupWith'),
                    strutStyle: StrutStyle(
                      forceStrutHeight: lang == 'ar' ? true : false,
                    ),
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF716B6B),
                        fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        fontWeight: FontWeight.w500),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
