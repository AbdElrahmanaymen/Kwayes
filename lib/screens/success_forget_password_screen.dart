import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';

class SucccessForgetPasswordScreen extends StatefulWidget {
  @override
  _SucccessForgetPasswordScreenState createState() =>
      _SucccessForgetPasswordScreenState();
}

class _SucccessForgetPasswordScreenState
    extends State<SucccessForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: CirclePainter(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getTranslated(context, 'SentTxt'),
                      strutStyle: StrutStyle(
                        forceStrutHeight: lang == 'ar' ? true : false,
                      ),
                      style: TextStyle(
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          color: Color(0xFF64D62F),
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.done,
                      color: Color(0xFF64D62F),
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(getTranslated(context, 'SentSubtitle'),
                strutStyle: StrutStyle(
                  forceStrutHeight: lang == 'ar' ? true : false,
                ),
                style: TextStyle(
                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                  color: Color(0xFFA3A3A3),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Container(
              height: 72,
              width: 315,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Color(0xff64D62F),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Welcome');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      getTranslated(context, 'DoneBtn'),
                      strutStyle: StrutStyle(
                        forceStrutHeight: lang == 'ar' ? true : false,
                      ),
                      style: TextStyle(
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = Color(0xff64D62F)
    ..strokeWidth = 5
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  final _shadowpaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 5
    ..style = PaintingStyle.stroke
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 3, size.width, size.height),
      _shadowpaint,
    );
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
