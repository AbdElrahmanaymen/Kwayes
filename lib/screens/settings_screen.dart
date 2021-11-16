import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/screens/change_password_screen.dart';
import 'package:kwayes/screens/edit_my_information_screen.dart';
import 'package:kwayes/screens/notification_control_screen.dart';
import 'package:kwayes/screens/report_screen.dart';
import 'package:kwayes/screens/terms_screen.dart';
import 'package:kwayes/services/auth.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _auth = AuthService();
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
                    AssetImage(lang == 'ar'
                        ? 'assets/images/icons/Back_button_ar.png'
                        : 'assets/images/icons/Back_button.png'),
                    size: 20,
                    color: Color(0xFF484451),
                  ),
                ),
                Text(
                  getTranslated(context, 'Settings'),
                  strutStyle: StrutStyle(
                    forceStrutHeight: lang == 'ar' ? true : false,
                  ),
                  style: TextStyle(
                      fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                      fontSize: 24,
                      color: Color(0xFF484451)),
                ),
                Container(
                  width: 20,
                )
              ],
            ),
            buildAccountOptionRow(
                context, getTranslated(context, 'EditMyInformation'), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext builder) =>
                          EditMyInformationScreen()));
            },
                ImageIcon(
                  AssetImage("assets/images/icons/edit.png"),
                  size: 16,
                  color: Color(0xFFA229F2),
                ),
                lang),
            buildAccountOptionRow(
                context, getTranslated(context, 'NotificationControl'), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext builder) =>
                          NotificationControlScreen()));
            },
                ImageIcon(
                  AssetImage("assets/images/icons/bell.png"),
                  size: 16,
                  color: Color(0xFFA229F2),
                ),
                lang),
            buildAccountOptionRow(context, getTranslated(context, 'TermsOfUse'),
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext builder) => TermsScreen()));
            },
                ImageIcon(
                  AssetImage("assets/images/icons/terms.png"),
                  size: 16,
                  color: Color(0xFFA229F2),
                ),
                lang),
            buildAccountOptionRow(
                context, getTranslated(context, 'ReportAProblem'), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext builder) => ReportScreen()));
            },
                ImageIcon(
                  AssetImage("assets/images/icons/report.png"),
                  size: 16,
                  color: Color(0xFFA229F2),
                ),
                lang),
            buildAccountOptionRow(
                context,
                getTranslated(context, 'ChangeLanguage'),
                () {},
                ImageIcon(
                  AssetImage("assets/images/icons/language.png"),
                  size: 16,
                  color: Color(0xFFA229F2),
                ),
                lang),
            buildAccountOptionRow(
                context, getTranslated(context, 'ChangePassword'), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext builder) =>
                          ChangePasswordScreen()));
            },
                ImageIcon(
                  AssetImage("assets/images/icons/information.png"),
                  size: 16,
                  color: Color(0xFFA229F2),
                ),
                lang),
            builOptionRow(context, getTranslated(context, 'SignOut'), () {
              _auth.signOut();
              Navigator.pushNamed(context, "/Wrapper");
            }, lang),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title,
      Function ontap, Widget icon, String lang) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              strutStyle: StrutStyle(
                forceStrutHeight: lang == 'ar' ? true : false,
              ),
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Color(0xFFA229F2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector builOptionRow(
      BuildContext context, String title, Function ontap, String lang) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              strutStyle: StrutStyle(
                forceStrutHeight: lang == 'ar' ? true : false,
              ),
              style: TextStyle(
                fontSize: 16,
                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                color: Color(0xFFA229F2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
