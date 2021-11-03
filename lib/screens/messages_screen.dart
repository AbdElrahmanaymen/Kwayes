import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: Colors.white,
=======
=======
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
    var lang = Localizations.localeOf(context).languageCode;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Center(
                  child: Text(
                getTranslated(context, 'MessageNavigationBar'),
                strutStyle: StrutStyle(
                  forceStrutHeight: lang == 'ar' ? true : false,
                ),
                style: TextStyle(
                    fontFamily: lang == 'ar' ? 'DIN' : 'Roboto', fontSize: 24),
              )),
            )
          ],
        ),
      ),
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
    );
  }
}
