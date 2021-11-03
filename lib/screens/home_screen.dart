<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
import 'package:camera/camera.dart';
>>>>>>> parent of 80a976c (undo)
=======
import 'package:camera/camera.dart';
>>>>>>> parent of 80a976c (undo)
=======
import 'package:camera/camera.dart';
>>>>>>> parent of 80a976c (undo)
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
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======

import 'package:kwayes/widgets/navigation_drawer_widget.dart';
>>>>>>> parent of 80a976c (undo)
=======

import 'package:kwayes/widgets/navigation_drawer_widget.dart';
>>>>>>> parent of 80a976c (undo)
=======

import 'package:kwayes/widgets/navigation_drawer_widget.dart';
>>>>>>> parent of 80a976c (undo)

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomeScreen({@required this.cameras});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

>>>>>>> parent of 80a976c (undo)
=======
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

>>>>>>> parent of 80a976c (undo)
=======
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

>>>>>>> parent of 80a976c (undo)
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
<<<<<<< HEAD
<<<<<<< HEAD

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
=======
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(),
>>>>>>> parent of 80a976c (undo)
=======
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(),
>>>>>>> parent of 80a976c (undo)
=======
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(),
>>>>>>> parent of 80a976c (undo)
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> parent of 80a976c (undo)
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
<<<<<<< HEAD
<<<<<<< HEAD
                    builder: (BuildContext context) => AddScreen()));
=======
                    builder: (BuildContext context) => AddScreen(
                          cameras: cameras,
                        )));
>>>>>>> parent of 80a976c (undo)
=======
                    builder: (BuildContext context) => AddScreen(
                          cameras: cameras,
                        )));
>>>>>>> parent of 80a976c (undo)
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
<<<<<<< HEAD
<<<<<<< HEAD
      bottomNavigationBar: Container(
        height: 70,
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
=======
=======
>>>>>>> parent of 80a976c (undo)
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
        child: Container(
          height: 65,
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
<<<<<<< HEAD
>>>>>>> parent of 80a976c (undo)
=======
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
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
        child: Container(
          height: 65,
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
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
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
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
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
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
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
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
                      currentScreen = DashBoardScreen();
=======
                      currentScreen =
                          DashBoardScreen(scaffoldKey: _scaffoldKey);
>>>>>>> parent of 80a976c (undo)
                    });
                  },
=======
=======
>>>>>>> parent of 80a976c (undo)
                      currentScreen =
                          DashBoardScreen(scaffoldKey: _scaffoldKey);
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
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
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
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
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
                        end:
                            Alignment(-0.2368917167186737, 0.07294762879610062),
                        colors: [Colors.white, Colors.white]),
                  ),
<<<<<<< HEAD
>>>>>>> parent of 80a976c (undo)
                ),
                MaterialButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GradientIcon(
<<<<<<< HEAD
                        (currentTab == 1)
                            ? 'assets/images/icons/notification.png'
                            : 'assets/images/icons/notification_unselected.png',
=======
                        (currentTab == 2)
                            ? 'assets/images/icons/messages.png'
                            : 'assets/images/icons/messages_unselected.png',
>>>>>>> parent of 80a976c (undo)
                        24,
                        LinearGradient(
                            transform: GradientRotation(-180 * (math.pi / 180)),
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
                            end: Alignment(
                                -0.2368917167186737, 0.07294762879610062),
                            colors: [
<<<<<<< HEAD
                              (currentTab == 1)
                                  ? Color.fromRGBO(
                                      149, 46, 191, 0.9800000190734863)
                                  : Color(0xFF484451),
                              (currentTab == 1)
=======
                              (currentTab == 2)
                                  ? Color.fromRGBO(
                                      149, 46, 191, 0.9800000190734863)
                                  : Color(0xFF484451),
                              (currentTab == 2)
>>>>>>> parent of 80a976c (undo)
                                  ? Color.fromRGBO(214, 41, 118, 1)
                                  : Color(0xFF484451)
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GradientText(
<<<<<<< HEAD
                        getTranslated(context, 'NotificationNavigationBar'),
=======
                        getTranslated(context, 'MessageNavigationBar'),
>>>>>>> parent of 80a976c (undo)
                        TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                            fontWeight: FontWeight.w500),
                        gradient: LinearGradient(
                            transform: GradientRotation(-180 * (math.pi / 180)),
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
                            end: Alignment(
                                -0.2368917167186737, 0.07294762879610062),
                            colors: [
<<<<<<< HEAD
                              (currentTab == 1)
                                  ? Color.fromRGBO(
                                      149, 46, 191, 0.9800000190734863)
                                  : Color(0xFF484451),
                              (currentTab == 1)
=======
                              (currentTab == 2)
                                  ? Color.fromRGBO(
                                      149, 46, 191, 0.9800000190734863)
                                  : Color(0xFF484451),
                              (currentTab == 2)
>>>>>>> parent of 80a976c (undo)
                                  ? Color.fromRGBO(214, 41, 118, 1)
                                  : Color(0xFF484451)
                            ]),
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
<<<<<<< HEAD
                      currentTab = 1;
                      currentScreen = NotificationsScreen();
                    });
                  },
<<<<<<< HEAD
                ),
                Container(
                  child: GradientIcon(
                    'assets/images/icons/messages.png',
                    24,
                    LinearGradient(
                        transform: GradientRotation(-180 * (math.pi / 180)),
                        begin: Alignment(1.396263599395752, 0.2368917167186737),
                        end:
                            Alignment(-0.2368917167186737, 0.07294762879610062),
                        colors: [Colors.white, Colors.white]),
                  ),
                ),
=======
                ),
                Container(
                  child: GradientIcon(
                    'assets/images/icons/messages.png',
                    24,
                    LinearGradient(
                        transform: GradientRotation(-180 * (math.pi / 180)),
                        begin: Alignment(1.396263599395752, 0.2368917167186737),
                        end:
                            Alignment(-0.2368917167186737, 0.07294762879610062),
                        colors: [Colors.white, Colors.white]),
                  ),
                ),
>>>>>>> parent of 80a976c (undo)
=======
                      currentTab = 2;
                      currentScreen = MessagesScreen();
                    });
                  },
                ),
>>>>>>> parent of 80a976c (undo)
=======
                ),
>>>>>>> parent of 80a976c (undo)
                MaterialButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GradientIcon(
<<<<<<< HEAD
<<<<<<< HEAD
                        (currentTab == 2)
                            ? 'assets/images/icons/messages.png'
                            : 'assets/images/icons/messages_unselected.png',
=======
                        (currentTab == 3)
                            ? 'assets/images/icons/profile.png'
                            : 'assets/images/icons/profile_unselected.png',
>>>>>>> parent of 80a976c (undo)
=======
                        (currentTab == 2)
                            ? 'assets/images/icons/messages.png'
                            : 'assets/images/icons/messages_unselected.png',
>>>>>>> parent of 80a976c (undo)
                        24,
                        LinearGradient(
                            transform: GradientRotation(-180 * (math.pi / 180)),
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
                            end: Alignment(
                                -0.2368917167186737, 0.07294762879610062),
                            colors: [
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> parent of 80a976c (undo)
                              (currentTab == 2)
                                  ? Color.fromRGBO(
                                      149, 46, 191, 0.9800000190734863)
                                  : Color(0xFF484451),
                              (currentTab == 2)
<<<<<<< HEAD
=======
                              (currentTab == 3)
                                  ? Color.fromRGBO(
                                      149, 46, 191, 0.9800000190734863)
                                  : Color(0xFF484451),
                              (currentTab == 3)
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
                                  ? Color.fromRGBO(214, 41, 118, 1)
                                  : Color(0xFF484451)
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GradientText(
<<<<<<< HEAD
<<<<<<< HEAD
                        getTranslated(context, 'MessageNavigationBar'),
=======
                        getTranslated(context, 'ProfileNavigationBar'),
>>>>>>> parent of 80a976c (undo)
=======
                        getTranslated(context, 'MessageNavigationBar'),
>>>>>>> parent of 80a976c (undo)
                        TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                            fontWeight: FontWeight.w500),
                        gradient: LinearGradient(
                            transform: GradientRotation(-180 * (math.pi / 180)),
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
                            end: Alignment(
                                -0.2368917167186737, 0.07294762879610062),
                            colors: [
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> parent of 80a976c (undo)
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
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
                            end: Alignment(
                                -0.2368917167186737, 0.07294762879610062),
                            colors: [
<<<<<<< HEAD
=======
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
                              (currentTab == 3)
                                  ? Color.fromRGBO(
                                      149, 46, 191, 0.9800000190734863)
                                  : Color(0xFF484451),
                              (currentTab == 3)
                                  ? Color.fromRGBO(214, 41, 118, 1)
                                  : Color(0xFF484451)
                            ]),
                      ),
<<<<<<< HEAD
<<<<<<< HEAD
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
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
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
=======
>>>>>>> parent of 80a976c (undo)
=======
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
                            begin: Alignment(
                                1.396263599395752, 0.2368917167186737),
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
>>>>>>> parent of 80a976c (undo)
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
      ),
    );
  }
}
