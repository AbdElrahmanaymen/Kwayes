import 'package:flutter/material.dart';
import 'package:kwayes/screens/ad_details_image.dart';

class AdMinimizedImage extends StatelessWidget {
  AdMinimizedImage(this.text, this.image, this.docId);

  final String text;
  final String image;
  final String docId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext builder) =>
                    AdDetailsImage(docId, image)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
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
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
