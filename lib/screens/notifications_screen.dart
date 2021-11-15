import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
                child: Text(
              getTranslated(context, 'NotificationNavigationBar'),
              strutStyle: StrutStyle(
                forceStrutHeight: lang == 'ar' ? true : false,
              ),
              style: TextStyle(
                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto', fontSize: 24),
            )),
          )
        ],
      ),
    );
  }
}
