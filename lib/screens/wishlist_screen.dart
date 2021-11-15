import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
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
                  getTranslated(context, 'MyWishList'),
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
          ],
        ),
      ),
    );
  }
}
