import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
                  getTranslated(context, 'ReportAProblem'),
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
            SizedBox(
              height: 68,
            ),
            TextField(
              minLines: 2,
              maxLines: 10,
              style: TextStyle(
                fontSize: 14,
                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
              ),
              strutStyle: StrutStyle(
                forceStrutHeight: lang == 'ar' ? true : false,
              ),
              decoration: InputDecoration(
                  hintText: getTranslated(context, 'ReportHint'),
                  fillColor: Color(0xFFF2F2F2),
                  filled: true,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8A8888),
                    fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                  ),
                  contentPadding:
                      EdgeInsets.only(right: 30, top: 20, bottom: 20, left: 30),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF2F2F2),
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF2F2F2),
                      ),
                      borderRadius: BorderRadius.circular(15))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 100,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF64D62F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    onPressed: () async {},
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(getTranslated(context, 'SendBtn'),
                            strutStyle: StrutStyle(
                              forceStrutHeight: lang == 'ar' ? true : false,
                            ),
                            style: TextStyle(
                                color: Color(0xFFFFF6F6),
                                fontSize: 14,
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                fontWeight: FontWeight.w500)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
