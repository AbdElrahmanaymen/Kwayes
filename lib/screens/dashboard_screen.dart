import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFfbfbfb),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Image.asset(
                        'assets/images/icons/filter.png',
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Image.asset('assets/images/icons/heart.png'),
                      onPressed: () {}),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFA3A3A3)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icons/search.png',
                            height: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            getTranslated(context, 'SearchTxt'),
                            strutStyle: StrutStyle(
                              forceStrutHeight: lang == 'ar' ? true : false,
                            ),
                            style: TextStyle(
                              color: Color(0xFFA3A3A3),
                              fontSize: 14,
                              fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Image.asset('assets/images/icons/share.png'),
                      onPressed: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
