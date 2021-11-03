import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'dart:math' as math;

import 'package:kwayes/services/auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String _email = '';

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, 'ForgotPassword'),
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
                child: Text(
                  getTranslated(context, 'ForgotPasswordSubtitle'),
                  strutStyle: StrutStyle(
                    forceStrutHeight: lang == 'ar' ? true : false,
                  ),
                  style: TextStyle(
                    fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                    color: Color(0xFFA3A3A3),
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  onChanged: (val) {
                    if (val != '') {
                      setState(() {
                        _email = val;
                      });
                    } else {
                      setState(() {
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
                    fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                  ),
                  decoration: InputDecoration(
                      suffixIcon: (_email != '')
                          ? RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_email)
                              ? Image.asset('assets/images/icons/correct.png')
                              : Image.asset('assets/images/icons/wrong.png')
                          : null,
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF716B6B), width: 1)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF484451), width: 1)),
                      labelText: getTranslated(context, 'EmailAddress'),
                      labelStyle: TextStyle(
                        color: Color(0xFF716B6B),
                        fontSize: 16,
                        fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Opacity(
                    opacity:
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_email)
                            ? 0.5
                            : 1,
                    child: Container(
                      height: 72,
                      width: 315,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                            if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_email)) {
                              await _auth.resetPassword(_email);
                              Navigator.pushNamed(
                                  context, '/SucccessForgetPassowrd');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              getTranslated(context, 'SendBtn'),
                              strutStyle: StrutStyle(
                                forceStrutHeight: lang == 'ar' ? true : false,
                              ),
                              style: TextStyle(
                                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ),
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
