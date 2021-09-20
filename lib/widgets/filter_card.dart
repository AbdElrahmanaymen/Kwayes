import 'package:flutter/material.dart';

class FilterCard extends StatelessWidget {
  FilterCard(this.text, this.image, this.lang, this.ontap);

  final String text;
  final String image;
  final String lang;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 112,
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                begin: Alignment(-4.393781338762892e-9, -1),
                end: Alignment(1, 6.106226635438361e-16),
                colors: [
                  Color.fromRGBO(0, 0, 0, 1).withOpacity(0.3),
                  Color.fromRGBO(0, 0, 0, 0).withOpacity(0.3)
                ]),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                text,
                strutStyle: StrutStyle(
                  forceStrutHeight: lang == 'ar' ? true : false,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: lang == 'ar' ? 'DIN' : 'Futura BdCn BT',
                  fontWeight: lang == 'ar' ? FontWeight.w500 : FontWeight.bold,
                  fontSize: lang == 'ar' ? 14 : 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
