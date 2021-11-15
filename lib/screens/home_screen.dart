import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/main.dart';
import 'package:kwayes/screens/Dashboard_screen.dart';
import 'package:kwayes/screens/add_screen.dart';
import 'package:kwayes/screens/messages_screen.dart';
import 'package:kwayes/screens/notifications_screen.dart';
import 'package:kwayes/screens/profile_screen.dart';
import 'package:kwayes/widgets/gradient_icon.dart';
import 'package:kwayes/widgets/gradient_text.dart';
import 'dart:math' as math;

import 'package:kwayes/widgets/navigation_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomeScreen({@required this.cameras});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int currentTab = 0;
  final List<Widget> screens = [
    DashBoardScreen(
      scaffoldKey: _scaffoldKey,
    ),
    NotificationsScreen(),
    MessagesScreen(),
    ProfileScreen()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashBoardScreen(scaffoldKey: _scaffoldKey);

  @override
  void initState() {
    user = auth.currentUser;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _myStatus('online');
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  _myStatus(String status) {
    _firestore.collection('users').doc(user.email).update({'Status': status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _myStatus('online');
    } else {
      _myStatus('offline');
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton(
          child: Container(
            width: 62,
            height: 62,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(162, 41, 242, 0.25),
                    offset: Offset(0, 8),
                    blurRadius: 16)
              ],
              gradient: LinearGradient(
                  transform: GradientRotation(-180 * (math.pi / 180)),
                  begin: Alignment(1.396263599395752, 0.2368917167186737),
                  end: Alignment(-0.2368917167186737, 0.07294762879610062),
                  colors: [
                    Color.fromRGBO(149, 46, 191, 0.9800000190734863),
                    Color.fromRGBO(214, 41, 118, 1)
                  ]),
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddScreen(
                          cameras: cameras,
                        )));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              MaterialButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientIcon(
                      (currentTab == 0)
                          ? 'assets/images/icons/home.png'
                          : 'assets/images/icons/home_unselected.png',
                      24,
                      LinearGradient(
                          transform: GradientRotation(-180 * (math.pi / 180)),
                          begin:
                              Alignment(1.396263599395752, 0.2368917167186737),
                          end: Alignment(
                              -0.2368917167186737, 0.07294762879610062),
                          colors: [
                            (currentTab == 0)
                                ? Color.fromRGBO(
                                    149, 46, 191, 0.9800000190734863)
                                : Color(0xFF484451),
                            (currentTab == 0)
                                ? Color.fromRGBO(214, 41, 118, 1)
                                : Color(0xFF484451)
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GradientText(
                      getTranslated(context, 'HomeNavigationBar'),
                      TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontWeight: FontWeight.w500),
                      gradient: LinearGradient(
                          transform: GradientRotation(-180 * (math.pi / 180)),
                          begin:
                              Alignment(1.396263599395752, 0.2368917167186737),
                          end: Alignment(
                              -0.2368917167186737, 0.07294762879610062),
                          colors: [
                            (currentTab == 0)
                                ? Color.fromRGBO(
                                    149, 46, 191, 0.9800000190734863)
                                : Color(0xFF484451),
                            (currentTab == 0)
                                ? Color.fromRGBO(214, 41, 118, 1)
                                : Color(0xFF484451)
                          ]),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 0;
                    currentScreen = DashBoardScreen(scaffoldKey: _scaffoldKey);
                  });
                },
              ),
              MaterialButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientIcon(
                      (currentTab == 1)
                          ? 'assets/images/icons/notification.png'
                          : 'assets/images/icons/notification_unselected.png',
                      24,
                      LinearGradient(
                          transform: GradientRotation(-180 * (math.pi / 180)),
                          begin:
                              Alignment(1.396263599395752, 0.2368917167186737),
                          end: Alignment(
                              -0.2368917167186737, 0.07294762879610062),
                          colors: [
                            (currentTab == 1)
                                ? Color.fromRGBO(
                                    149, 46, 191, 0.9800000190734863)
                                : Color(0xFF484451),
                            (currentTab == 1)
                                ? Color.fromRGBO(214, 41, 118, 1)
                                : Color(0xFF484451)
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GradientText(
                      getTranslated(context, 'NotificationNavigationBar'),
                      TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontWeight: FontWeight.w500),
                      gradient: LinearGradient(
                          transform: GradientRotation(-180 * (math.pi / 180)),
                          begin:
                              Alignment(1.396263599395752, 0.2368917167186737),
                          end: Alignment(
                              -0.2368917167186737, 0.07294762879610062),
                          colors: [
                            (currentTab == 1)
                                ? Color.fromRGBO(
                                    149, 46, 191, 0.9800000190734863)
                                : Color(0xFF484451),
                            (currentTab == 1)
                                ? Color.fromRGBO(214, 41, 118, 1)
                                : Color(0xFF484451)
                          ]),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 1;
                    currentScreen = NotificationsScreen();
                  });
                },
              ),
              Container(
                child: GradientIcon(
                  'assets/images/icons/messages.png',
                  24,
                  LinearGradient(
                      transform: GradientRotation(-180 * (math.pi / 180)),
                      begin: Alignment(1.396263599395752, 0.2368917167186737),
                      end: Alignment(-0.2368917167186737, 0.07294762879610062),
                      colors: [Colors.white, Colors.white]),
                ),
              ),
              MaterialButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientIcon(
                      (currentTab == 2)
                          ? 'assets/images/icons/messages.png'
                          : 'assets/images/icons/messages_unselected.png',
                      24,
                      LinearGradient(
                          transform: GradientRotation(-180 * (math.pi / 180)),
                          begin:
                              Alignment(1.396263599395752, 0.2368917167186737),
                          end: Alignment(
                              -0.2368917167186737, 0.07294762879610062),
                          colors: [
                            (currentTab == 2)
                                ? Color.fromRGBO(
                                    149, 46, 191, 0.9800000190734863)
                                : Color(0xFF484451),
                            (currentTab == 2)
                                ? Color.fromRGBO(214, 41, 118, 1)
                                : Color(0xFF484451)
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GradientText(
                      getTranslated(context, 'MessageNavigationBar'),
                      TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontWeight: FontWeight.w500),
                      gradient: LinearGradient(
                          transform: GradientRotation(-180 * (math.pi / 180)),
                          begin:
                              Alignment(1.396263599395752, 0.2368917167186737),
                          end: Alignment(
                              -0.2368917167186737, 0.07294762879610062),
                          colors: [
                            (currentTab == 2)
                                ? Color.fromRGBO(
                                    149, 46, 191, 0.9800000190734863)
                                : Color(0xFF484451),
                            (currentTab == 2)
                                ? Color.fromRGBO(214, 41, 118, 1)
                                : Color(0xFF484451)
                          ]),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 2;
                    currentScreen = MessagesScreen();
                  });
                },
              ),
              MaterialButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientIcon(
                      (currentTab == 3)
                          ? 'assets/images/icons/profile.png'
                          : 'assets/images/icons/profile_unselected.png',
                      24,
                      LinearGradient(
                          transform: GradientRotation(-180 * (math.pi / 180)),
                          begin:
                              Alignment(1.396263599395752, 0.2368917167186737),
                          end: Alignment(
                              -0.2368917167186737, 0.07294762879610062),
                          colors: [
                            (currentTab == 3)
                                ? Color.fromRGBO(
                                    149, 46, 191, 0.9800000190734863)
                                : Color(0xFF484451),
                            (currentTab == 3)
                                ? Color.fromRGBO(214, 41, 118, 1)
                                : Color(0xFF484451)
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GradientText(
                      getTranslated(context, 'ProfileNavigationBar'),
                      TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                          fontWeight: FontWeight.w500),
                      gradient: LinearGradient(
                          transform: GradientRotation(-180 * (math.pi / 180)),
                          begin:
                              Alignment(1.396263599395752, 0.2368917167186737),
                          end: Alignment(
                              -0.2368917167186737, 0.07294762879610062),
                          colors: [
                            (currentTab == 3)
                                ? Color.fromRGBO(
                                    149, 46, 191, 0.9800000190734863)
                                : Color(0xFF484451),
                            (currentTab == 3)
                                ? Color.fromRGBO(214, 41, 118, 1)
                                : Color(0xFF484451)
                          ]),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 3;
                    currentScreen = ProfileScreen();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
