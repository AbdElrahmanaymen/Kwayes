import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class NavigationDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      getTranslated(context, 'DrawerHeader'),
                      strutStyle: StrutStyle(
                        forceStrutHeight: lang == 'ar' ? true : false,
                      ),
                      style: TextStyle(
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontSize: 24,
                          color: Color(0xFF484451)),
                    ),
                    Image.asset(
                      'assets/images/icons/filter.png',
                      width: 20,
                      height: 18,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Color(0xFF484451),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated(context, 'SortBy'),
                      strutStyle: StrutStyle(
                        forceStrutHeight: lang == 'ar' ? true : false,
                      ),
                      style: TextStyle(
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF484451)),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Text(
                      getTranslated(context, 'Location'),
                      strutStyle: StrutStyle(
                        forceStrutHeight: lang == 'ar' ? true : false,
                      ),
                      style: TextStyle(
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF484451)),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Text(
                      getTranslated(context, 'Price'),
                      strutStyle: StrutStyle(
                        forceStrutHeight: lang == 'ar' ? true : false,
                      ),
                      style: TextStyle(
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF484451)),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Text(
                      getTranslated(context, 'Distance'),
                      strutStyle: StrutStyle(
                        forceStrutHeight: lang == 'ar' ? true : false,
                      ),
                      style: TextStyle(
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF484451)),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Text(
                      getTranslated(context, 'ChooseCity'),
                      strutStyle: StrutStyle(
                        forceStrutHeight: lang == 'ar' ? true : false,
                      ),
                      style: TextStyle(
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF484451)),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width - 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF64D62F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                          onPressed: () async {},
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
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Text(
                        getTranslated(context, 'ResetFilter'),
                        strutStyle: StrutStyle(
                          forceStrutHeight: lang == 'ar' ? true : false,
                        ),
                        style: TextStyle(
                            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Color(0xFF716B6B)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
