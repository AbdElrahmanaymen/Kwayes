import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/model/ad.dart';
import 'package:kwayes/screens/publish_screen.dart';
import 'package:video_player/video_player.dart';

class PrepublishScreen extends StatefulWidget {
  final String path;
  final AdType type;

  PrepublishScreen({@required this.path, @required this.type});

  @override
  State<PrepublishScreen> createState() => _PrepublishScreenState();
}

class _PrepublishScreenState extends State<PrepublishScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((value) {
        if (_controller.value.isInitialized) {
          _controller.play();
          _controller.setLooping(true);
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return widget.type == AdType.image
        ? Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(widget.path)), fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  publishBtn(lang),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  VideoPlayer(_controller),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: publishBtn(lang))
                ],
              ),
            ),
          );
  }

  Widget publishBtn(String lang) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Container(
        height: 55,
        width: 241,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Color(0xFFA229F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21),
                )),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PublishScreen(path: widget.path, type: widget.type),
                  ));
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(getTranslated(context, 'PublishBtn'),
                    strutStyle: StrutStyle(
                      forceStrutHeight: lang == 'ar' ? true : false,
                    ),
                    style: TextStyle(
                        color: Color(0xFFFFF6F6),
                        fontSize: 16,
                        fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        fontWeight: FontWeight.w500)))),
      ),
    );
  }
}
