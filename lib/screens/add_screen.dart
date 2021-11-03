<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
=======
=======
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/model/ad.dart';
import 'package:kwayes/screens/prepublish_screen.dart';

class AddScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  AddScreen({@required this.cameras});
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold();
=======
=======
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
  CameraController _cameraController;

  Future<void> cameraValue;

  bool isRecording = false;

  bool isCamerafront = false;

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CameraPreview(_cameraController));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 28,
                        color: Colors.white,
                      )),
                  GestureDetector(
                      onLongPress: () async {
                        _cameraController.startVideoRecording();
                        setState(() {
                          isRecording = true;
                        });
                      },
                      onLongPressUp: () async {
                        final path =
                            await _cameraController.stopVideoRecording();
                        setState(() {
                          isRecording = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrepublishScreen(
                                path: path.path,
                                type: AdType.video,
                              ),
                            ));
                      },
                      onTap: () {
                        if (!isRecording) takePhoto();
                      },
                      child: isRecording
                          ? Icon(
                              Icons.radio_button_on,
                              size: 70,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.panorama_fish_eye,
                              size: 70,
                              color: Colors.white,
                            )),
                  IconButton(
                      onPressed: () {
                        int cameraPos = isCamerafront ? 0 : 1;
                        _cameraController = CameraController(
                            widget.cameras[cameraPos], ResolutionPreset.high);
                        cameraValue = _cameraController.initialize();
                        setState(() {
                          isCamerafront = !isCamerafront;
                        });
                      },
                      icon: Icon(
                        Icons.flip_camera_ios,
                        size: 28,
                        color: Colors.white,
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                getTranslated(context, 'RecordingTxt'),
                strutStyle: StrutStyle(
                  forceStrutHeight: lang == 'ar' ? true : false,
                ),
                style: TextStyle(
                    fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                    fontSize: 14,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto() async {
    final path = await _cameraController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrepublishScreen(
            path: path.path,
            type: AdType.image,
          ),
        ));
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
  }
}
