import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
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
                  getTranslated(context, 'TermsOfUse'),
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
            Text(
              "Jorem Ipsum Dolor Sit Amet,\nConsectetur Adipiscing Elit.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF716B6B),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Volutpat nunc, malesuada ut scelerisque pharetra. Semper lacus, sed at sit. Sed bibendum scelerisque etiam interdum. Mi mauris velit dapibus mollis nunc, nascetur tellus cras justo. Elit interdum vulputate sed ullamcorper. Praesent vitae commodo elit, a odio sed risus ut scelerisque. Massa eget ut tempor, consequat. Tortor congue odio neque vivamus tellus feugiat eu. Ullamcorper aliquet tortor pretium, adipiscing risus purus massa. Ac et porttitor fames id et in. Hendrerit eget feugiat laoreet leo, cursus ultrices diam amet. Tellus tortor in hac in est bibendum quisque mauris. Vehicula ultrices vitae amet sed sagittis. Nisi, ultricies eget cursus neque. Est facilisi nisi, donec fringilla eget id nulla. Elementum urna quam pharetra amet, tristique duis lacus risus quis. Eget eget suspendisse sed mauris nulla. Morbi sed tincidunt mauris neque ultrices. Pellentesque dolor porta congue facilisis suspendisse sed eget sit nunc. Amet neque, lorem aliquam volutpat sed nunc enim lectus velit. Consectetur mauris scelerisque viverra aliquet nascetur suspendisse quis consectetur. Diam elit massa, cras turpis scelerisque turpis consequat. Nisl, dictum maecenas cras pulvinar.",
              style: TextStyle(
                  fontSize: 12, fontFamily: 'Roboto', color: Color(0xFFA3A3A3)),
            )
          ],
        ),
      ),
    );
  }
}
