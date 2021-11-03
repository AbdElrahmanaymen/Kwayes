import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/screens/Dashboard_screen.dart';
import 'package:kwayes/screens/messages_screen.dart';
import 'package:kwayes/screens/notifications_screen.dart';
import 'package:kwayes/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    DashBoardScreen(),
    NotificationsScreen(),
    MessagesScreen(),
    ProfileScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashBoardScreen();

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/icons/floatingButtonBackground.png'),
                    fit: BoxFit.contain)),
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: BottomAppBar(
                  notchMargin: 0,
                  shape: AutomaticNotchedShape(
                    RoundedRectangleBorder(),
                    StadiumBorder(
                      side: BorderSide(),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  (currentTab == 0)
                                      ? 'assets/images/icons/home.png'
                                      : 'assets/images/icons/home_unselected.png',
                                  height: 25,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  getTranslated(context, 'HomeNavigationBar'),
                                  style: TextStyle(
                                      color: (currentTab == 0)
                                          ? Color(0xFFD62976)
                                          : Color(0xFF484451),
                                      fontSize: 8,
                                      fontFamily:
                                          lang == 'ar' ? 'DIN' : 'Roboto',
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                currentTab = 0;
                                currentScreen = DashBoardScreen();
                              });
                            },
                          ),
                          MaterialButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  (currentTab == 1)
                                      ? 'assets/images/icons/notification.png'
                                      : 'assets/images/icons/notification_unselected.png',
                                  height: 25,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  getTranslated(
                                      context, 'NotificationNavigationBar'),
                                  style: TextStyle(
                                      color: (currentTab == 1)
                                          ? Color(0xFFD62976)
                                          : Color(0xFF484451),
                                      fontSize: 8,
                                      fontFamily:
                                          lang == 'ar' ? 'DIN' : 'Roboto',
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                currentTab = 1;
                                currentScreen = NotificationsScreen();
                              });
                            },
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          MaterialButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  (currentTab == 2)
                                      ? 'assets/images/icons/messages.png'
                                      : 'assets/images/icons/messages_unselected.png',
                                  height: 25,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  getTranslated(
                                      context, 'MessageNavigationBar'),
                                  style: TextStyle(
                                      color: (currentTab == 2)
                                          ? Color(0xFFD62976)
                                          : Color(0xFF484451),
                                      fontSize: 8,
                                      fontFamily:
                                          lang == 'ar' ? 'DIN' : 'Roboto',
                                      fontWeight: FontWeight.w500),
                                )
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
                                Image.asset(
                                  (currentTab == 3)
                                      ? 'assets/images/icons/profile.png'
                                      : 'assets/images/icons/profile_unselected.png',
                                  height: 25,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  getTranslated(
                                      context, 'ProfileNavigationBar'),
                                  style: TextStyle(
                                      color: (currentTab == 3)
                                          ? Color(0xFFD62976)
                                          : Color(0xFF484451),
                                      fontSize: 8,
                                      fontFamily:
                                          lang == 'ar' ? 'DIN' : 'Roboto',
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                currentTab = 3;
                                currentScreen = ProfileScreen();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
