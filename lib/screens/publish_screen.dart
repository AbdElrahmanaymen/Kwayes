import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/api/firebase_api.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/model/ad.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PublishScreen extends StatefulWidget {
  final AdType type;
  final String path;

  PublishScreen({@required this.path, @required this.type});

  @override
  _PublishScreenState createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  int currentStep = 0;
  String category = '';
  String priceType = 'Free';
  String location = '';

  bool isCall = false;
  bool isMessage = false;

  bool isPublishing = false;
  bool isDone = false;

  UploadTask task;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        location = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    user = auth.currentUser;
    super.initState();
    getCurrentLocation();
  }

  String getRandString(int len) {
    var random = math.Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  Future publishBtn() async {
    setState(() {
      isPublishing = true;
    });
    String docId = getRandString(15);
    var file = File(widget.path);
    final fileName = basename(file.path);
    final destination = '${user.email}/ads/$docId/$fileName';
    task = FirebaseApi.uploadFile(destination, file);
    if (task == null) return;
    final snapshot = await task.whenComplete(() => null);
    final urlDownload = await snapshot.ref.getDownloadURL();

    await _firestore.collection("ads").doc(docId).set({
      'Address': location,
      'Category': category,
      'Date': DateTime.now(),
      'Description': descriptionController.text,
      'MediaType': widget.type == AdType.image ? 'Image' : 'Video',
      'Price': priceType == 'Free' ? priceType : priceController.text + '\$',
      'Sub Category': category,
      'Title': titleController.text,
      'User': user.email,
      'Call': isCall,
      'Message': isMessage,
      'Media': urlDownload
    });

    setState(() {
      isPublishing = false;
      isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return (isPublishing)
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : (isDone)
            ? Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: ImageIcon(
                      AssetImage('assets/images/icons/check-circle.png'),
                      size: 220,
                      color: Color(0xFF64D62F),
                    )),
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                              Navigator.pushNamed(context, '/Wrapper');
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
              )
            : SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme:
                            ColorScheme.light(primary: Color(0xFF64D62F))),
                    child: Stepper(
                      steps: getSteps(context, lang),
                      type: StepperType.horizontal,
                      currentStep: currentStep,
                      onStepContinue: () {
                        if (currentStep == getSteps(context, lang).length - 1) {
                        } else {
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      },
                      onStepCancel: () {
                        currentStep == 0
                            ? null
                            : setState(() {
                                currentStep -= 1;
                              });
                      },
                      controlsBuilder: (context,
                          {onStepCancel, onStepContinue}) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (currentStep == getSteps(context, lang).length - 1)
                                ? Container(
                                    height: 59,
                                    width: 258,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                          transform: GradientRotation(
                                              -180 * (math.pi / 180)),
                                          begin: Alignment(1.396263599395752,
                                              0.2368917167186737),
                                          end: Alignment(-0.2368917167186737,
                                              0.07294762879610062),
                                          colors: [
                                            Color.fromRGBO(149, 46, 191,
                                                0.9800000190734863),
                                            Color.fromRGBO(214, 41, 118, 1)
                                          ]),
                                      borderRadius:
                                          BorderRadius.circular(26.25),
                                    ),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(26.25),
                                            )),
                                        onPressed: publishBtn,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            getTranslated(
                                                context, 'PublishBtn'),
                                            strutStyle: StrutStyle(
                                              forceStrutHeight:
                                                  lang == 'ar' ? true : false,
                                            ),
                                            style: TextStyle(
                                                color: Color(0xFFFFF6F6),
                                                fontFamily: lang == 'ar'
                                                    ? 'DIN'
                                                    : 'Roboto',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  )
                                : Container(
                                    height: 59,
                                    width: 258,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFFA229F2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(26.25),
                                            )),
                                        onPressed: onStepContinue,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                                getTranslated(
                                                    context, 'NextBtn'),
                                                strutStyle: StrutStyle(
                                                  forceStrutHeight: lang == 'ar'
                                                      ? true
                                                      : false,
                                                ),
                                                style: TextStyle(
                                                    color: Color(0xFFFFF6F6),
                                                    fontSize: 20,
                                                    fontFamily: lang == 'ar'
                                                        ? 'DIN'
                                                        : 'Roboto',
                                                    fontWeight:
                                                        FontWeight.w500)))),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
  }

  List<Step> getSteps(BuildContext context, String lang) => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text(
              getTranslated(context, 'AdCategory'),
              strutStyle: StrutStyle(
                forceStrutHeight: lang == 'ar' ? true : false,
              ),
              style: TextStyle(
                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto', fontSize: 12),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'ChooseCatgory'),
                    strutStyle: StrutStyle(
                      forceStrutHeight: lang == 'ar' ? true : false,
                    ),
                    style: TextStyle(
                        fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Wrap(
                    children: [
                      categoryBtn(getTranslated(context, 'MenFilter'), lang),
                      categoryBtn(getTranslated(context, 'WomenFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'AninmalsFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'SmartphoneFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'MultimediaFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'MotorcyclesFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'DecorationFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'DecoratiRentalFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'HomeServicesFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'ChildrenFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'HomeAppliancesFilter'), lang),
                      categoryBtn(
                          getTranslated(context, 'CarsGarageFilter'), lang),
                      categoryBtn(getTranslated(context, 'JobsFilter'), lang),
                    ],
                  )
                ],
              ),
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text(
              getTranslated(context, 'AdInformation'),
              strutStyle: StrutStyle(
                forceStrutHeight: lang == 'ar' ? true : false,
              ),
              style: TextStyle(
                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto', fontSize: 12),
            ),
            content: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'ProductInformation'),
                    strutStyle: StrutStyle(
                      forceStrutHeight: lang == 'ar' ? true : false,
                    ),
                    style: TextStyle(
                        fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  buildTextField(getTranslated(context, 'ProductTitle'),
                      titleController, (value) {}, lang),
                  buildTextField(getTranslated(context, 'ProductDescription'),
                      descriptionController, (value) {}, lang),
                ],
              ),
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            title: Text(
              getTranslated(context, 'AdPrice'),
              strutStyle: StrutStyle(
                forceStrutHeight: lang == 'ar' ? true : false,
              ),
              style: TextStyle(
                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto', fontSize: 12),
            ),
            content: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'PriceChoice'),
                    strutStyle: StrutStyle(
                      forceStrutHeight: lang == 'ar' ? true : false,
                    ),
                    style: TextStyle(
                        fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/icons/dollar.png'),
                            size: 16,
                            color: Color(0xFFA229F2),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            getTranslated(context, 'Price'),
                            strutStyle: StrutStyle(
                              forceStrutHeight: lang == 'ar' ? true : false,
                            ),
                            style: TextStyle(
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xFFA229F2)),
                          )
                        ],
                      ),
                      Container(
                        width: 64,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          strutStyle: StrutStyle(
                            forceStrutHeight: lang == 'ar' ? true : false,
                          ),
                          style: TextStyle(
                              color: Color(0xFF716B6B),
                              fontSize: 16,
                              fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                              fontWeight: FontWeight.w500),
                          controller: priceController,
                          decoration: InputDecoration(
                            hintText: '00',
                            suffix: Text(
                              "\$",
                            ),
                            hintStyle: TextStyle(
                                color: Color(0xFF716B6B),
                                fontSize: 16,
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                fontWeight: FontWeight.w500),
                            contentPadding: EdgeInsets.all(0),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (priceType == 'Free') {
                              priceType = 'Paid';
                            } else {
                              priceType = 'Free';
                            }
                          });
                        },
                        child: priceType == 'Free'
                            ? Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF716B6B)),
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF2F2F2)),
                              )
                            : ImageIcon(
                                AssetImage('assets/images/icons/check.png'),
                                size: 16,
                                color: Color(0xFFA229F2),
                              ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/icons/free.png'),
                            size: 16,
                            color: Color(0xFFA229F2),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            getTranslated(context, 'Free'),
                            strutStyle: StrutStyle(
                              forceStrutHeight: lang == 'ar' ? true : false,
                            ),
                            style: TextStyle(
                                fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xFFA229F2)),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (priceType == 'Free') {
                              priceType = 'Paid';
                            } else {
                              priceType = 'Free';
                            }
                          });
                        },
                        child: priceType != 'Free'
                            ? Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF716B6B)),
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF2F2F2)),
                              )
                            : ImageIcon(
                                AssetImage('assets/images/icons/check.png'),
                                size: 16,
                                color: Color(0xFFA229F2),
                              ),
                      )
                    ],
                  )
                ],
              ),
            )),
        Step(
            state: currentStep > 3 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 3,
            title: Text(
              getTranslated(context, 'AdLocation'),
              strutStyle: StrutStyle(
                forceStrutHeight: lang == 'ar' ? true : false,
              ),
              style: TextStyle(
                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto', fontSize: 12),
            ),
            content: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'Location'),
                    strutStyle: StrutStyle(
                      forceStrutHeight: lang == 'ar' ? true : false,
                    ),
                    style: TextStyle(
                        fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icons/map.png',
                            width: 44,
                            height: 44,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            location,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xFF716B6B)),
                          )
                        ],
                      ),
                      Image.asset(
                        'assets/images/icons/pin_drop.png',
                        color: Color(0xFFA229F2),
                        width: 16.5,
                        height: 24,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    getTranslated(context, 'Contact'),
                    strutStyle: StrutStyle(
                      forceStrutHeight: lang == 'ar' ? true : false,
                    ),
                    style: TextStyle(
                        fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated(context, 'CallMeOption'),
                        strutStyle: StrutStyle(
                          forceStrutHeight: lang == 'ar' ? true : false,
                        ),
                        style: TextStyle(
                            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF716B6B)),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isCall = !isCall;
                          });
                        },
                        child: !isCall
                            ? Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF716B6B)),
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF2F2F2)),
                              )
                            : ImageIcon(
                                AssetImage('assets/images/icons/check.png'),
                                size: 16,
                                color: Color(0xFFA229F2),
                              ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated(context, 'AddMessageOption'),
                        strutStyle: StrutStyle(
                          forceStrutHeight: lang == 'ar' ? true : false,
                        ),
                        style: TextStyle(
                            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF716B6B)),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMessage = !isMessage;
                          });
                        },
                        child: !isMessage
                            ? Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF716B6B)),
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF2F2F2)),
                              )
                            : ImageIcon(
                                AssetImage('assets/images/icons/check.png'),
                                size: 16,
                                color: Color(0xFFA229F2),
                              ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ];

  Widget categoryBtn(String text, String lang) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              primary:
                  (category == text) ? Color(0xFFA229F2) : Color(0xFFA3A3A3),
              side: BorderSide(
                  color: (category == text)
                      ? Color(0xFFA229F2)
                      : Color(0xFFA3A3A3),
                  width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )),
          onPressed: () {
            setState(() {
              category = text;
            });
          },
          child: Text(
            text,
            strutStyle: StrutStyle(
              forceStrutHeight: lang == 'ar' ? true : false,
            ),
            style: TextStyle(
              fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          )),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      Function validate, String lang) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextFormField(
        validator: validate,
        strutStyle: StrutStyle(
          forceStrutHeight: lang == 'ar' ? true : false,
        ),
        style: TextStyle(
            color: Color(0xFF716B6B),
            fontSize: 16,
            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
            fontWeight: FontWeight.w500),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(0xFFA3A3A3),
            fontSize: 14,
            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
