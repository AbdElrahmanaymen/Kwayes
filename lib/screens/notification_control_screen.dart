import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class NotificationControlScreen extends StatefulWidget {
  @override
  _NotificationControlScreenState createState() =>
      _NotificationControlScreenState();
}

class _NotificationControlScreenState extends State<NotificationControlScreen> {
  bool toggleValue = false;
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
                  getTranslated(context, 'NotificationControl'),
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
              height: 42,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, 'RecieveMessages'),
                  strutStyle: StrutStyle(
                    forceStrutHeight: lang == 'ar' ? true : false,
                  ),
                  style: TextStyle(
                      fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                      fontSize: 16,
                      color: Color(0xFF484451)),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  height: 1,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          toggleValue ? Color(0xFFA229F2) : Color(0xFFA3A3A3)),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        child: InkWell(
                          onTap: toggleButton,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 1000),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return RotationTransition(
                                child: child,
                                turns: animation,
                              );
                            },
                            child: Icon(
                              Icons.circle,
                              color: toggleValue
                                  ? Color(0xFFA229F2)
                                  : Color(0xFFA3A3A3),
                              size: 35,
                              key: UniqueKey(),
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeIn,
                        top: 3,
                        left: toggleValue ? 60 : 0,
                        right: toggleValue ? 0 : 60,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, 'MySelectedAdsAsFavourites'),
                  strutStyle: StrutStyle(
                    forceStrutHeight: lang == 'ar' ? true : false,
                  ),
                  style: TextStyle(
                      fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                      fontSize: 16,
                      color: Color(0xFF484451)),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  height: 1,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          toggleValue ? Color(0xFFA229F2) : Color(0xFFA3A3A3)),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        child: InkWell(
                          onTap: toggleButton,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 1000),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return RotationTransition(
                                child: child,
                                turns: animation,
                              );
                            },
                            child: Icon(
                              Icons.circle,
                              color: toggleValue
                                  ? Color(0xFFA229F2)
                                  : Color(0xFFA3A3A3),
                              size: 35,
                              key: UniqueKey(),
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeIn,
                        top: 3,
                        left: toggleValue ? 60 : 0,
                        right: toggleValue ? 0 : 60,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
