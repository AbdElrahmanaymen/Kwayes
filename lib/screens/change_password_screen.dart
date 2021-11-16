import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/services/auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  bool _obsecureText1 = true;
  bool _obsecureText2 = true;
  bool checkCurrentPasswordValid = true;

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ImageIcon(
                    AssetImage('assets/images/icons/Back_button.png'),
                    size: 20,
                    color: Color(0xFF484451),
                  ),
                ),
                Text(
                  "Change Password",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                      color: Color(0xFF484451)),
                ),
                Container(
                  width: 20,
                )
              ],
            ),
            SizedBox(
              height: 42,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildTextFieldNonValdiate(
                      getTranslated(context, 'OldPassword'),
                      oldpasswordController,
                      checkCurrentPasswordValid,
                      lang,
                      _obsecureText1,
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _obsecureText1 = !_obsecureText1;
                            });
                          },
                          icon: _obsecureText1
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off))),
                  buildTextField(getTranslated(context, 'NewPassword'),
                      newpasswordController, (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return getTranslated(context, 'PasswordError');
                    } else {
                      return null;
                    }
                  },
                      lang,
                      _obsecureText2,
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _obsecureText2 = !_obsecureText2;
                            });
                          },
                          icon: _obsecureText2
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off))),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF64D62F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          onPressed: () async {
                            setState(() async {
                              checkCurrentPasswordValid =
                                  await _auth.validateCurrentPassword(
                                      oldpasswordController.text);
                            });

                            if (_formKey.currentState.validate() &&
                                checkCurrentPasswordValid) {
                              _auth.updateUserPassword(
                                  newpasswordController.text);
                            }
                          },
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(getTranslated(context, 'SaveBtn'),
                                  strutStyle: StrutStyle(
                                    forceStrutHeight:
                                        lang == 'ar' ? true : false,
                                  ),
                                  style: TextStyle(
                                      color: Color(0xFFFFF6F6),
                                      fontSize: 14,
                                      fontFamily:
                                          lang == 'ar' ? 'DIN' : 'Roboto',
                                      fontWeight: FontWeight.w500)))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      Function validate, String lang, bool _obscureText, Widget obscure) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextFormField(
        validator: validate,
        obscureText: _obscureText,
        style: TextStyle(
            color: Color(0xFF716B6B),
            fontSize: 16,
            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
            fontWeight: FontWeight.w500),
        strutStyle: StrutStyle(
          forceStrutHeight: lang == 'ar' ? true : false,
        ),
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: obscure,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(0xFF484451),
            fontSize: 14,
            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  Widget buildTextFieldNonValdiate(
      String labelText,
      TextEditingController controller,
      bool validate,
      String lang,
      bool _obscureText,
      Widget obscure) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextFormField(
        obscureText: _obscureText,
        style: TextStyle(
            color: Color(0xFF716B6B),
            fontSize: 16,
            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
            fontWeight: FontWeight.w500),
        strutStyle: StrutStyle(
          forceStrutHeight: lang == 'ar' ? true : false,
        ),
        controller: controller,
        decoration: InputDecoration(
          errorText:
              validate ? null : getTranslated(context, 'CurrentPasswordError'),
          suffixIcon: obscure,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(0xFF484451),
            fontSize: 14,
            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
