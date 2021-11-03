import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/api/firebase_api.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/model/ad.dart';
import 'package:kwayes/screens/settings_screen.dart';
import 'package:kwayes/widgets/ad_minimized.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  Stream<QuerySnapshot> loadAds() {
    return _firestore
        .collection('ads')
        .orderBy('Date', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> loadLikedAds() {
    return _firestore
        .collection('ads')
        .where('likes.${user.email}', isEqualTo: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> loadMyInfo() {
    return _firestore.collection('users').doc(user.email).snapshots();
  }

  @override
  void initState() {
    user = auth.currentUser;
    loadMyInfo();
    super.initState();
  }

  int tab = 0;
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.logout))
=======
=======
>>>>>>> parent of 80a976c (undo)
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Image.asset(
                      'assets/images/icons/settings.png',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext builder) =>
                                  SettingsScreen()));
                    }),
              ],
            ),
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: loadMyInfo(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  String name = snapshot.data.data()['Name'];
                  String photUrl = snapshot.data.data()['photo_url'];
                  return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 155,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 43,
                              left: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                      center: Alignment(
                                          0.7, -0.6), // near the top right
                                      radius: 1,
                                      stops: <double>[
                                        0.4,
                                        1.0
                                      ],
                                      colors: [
                                        Color(0xFFE100FF),
                                        Color(0xFF22BFC9)
                                      ]),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 86,
                                    height: 86,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(photUrl))),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                          onTap: () async {
                                            final reuslt = await FilePicker
                                                .platform
                                                .pickFiles(
                                                    allowMultiple: false);
                                            if (reuslt == null) return;
                                            File file =
                                                File(reuslt.files.single.path);
                                            final dateTime = DateTime.now();
                                            final path =
                                                '${user.email}/profile/$dateTime';
                                            UploadTask task =
                                                FirebaseApi.uploadFile(
                                                    path, file);
                                            final snapshot = await task
                                                .whenComplete(() => null);
                                            final urlDownload = await snapshot
                                                .ref
                                                .getDownloadURL();
                                            if (task != null) {
                                              _firestore
                                                  .collection('users')
                                                  .doc(user.email)
                                                  .update({
                                                'photo_url': urlDownload
                                              });
                                            }
                                          },
                                          child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF484451),
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.photo_camera,
                                                size: 13,
                                                color: Colors.white,
                                              )))),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 110,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 158,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: DefaultTabController(
                                  length: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                32,
                                        child: TabBar(
                                            onTap: (index) {
                                              setState(() {
                                                tab = index;
                                              });
                                            },
                                            indicator: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                color: Colors.white),
                                            labelPadding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            unselectedLabelColor: Colors.white,
                                            labelColor: Color(0xFF716B6B),
                                            labelStyle: TextStyle(
                                                fontFamily: lang == 'ar'
                                                    ? 'DIN'
                                                    : 'Roboto',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            tabs: [
                                              Tab(
                                                text: getTranslated(
                                                    context, 'MyAds'),
                                              ),
                                              Tab(
                                                text: getTranslated(
                                                    context, 'SaleOnKwayes'),
                                              ),
                                              Tab(
                                                text: getTranslated(
                                                    context, 'Favourite'),
                                              ),
                                            ]),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                32,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.9,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: (lang == 'ar')
                                                ? BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(16),
                                                    bottomRight:
                                                        Radius.circular(16),
                                                    topRight: (tab != 0)
                                                        ? Radius.circular(16)
                                                        : Radius.circular(0),
                                                    topLeft: (tab != 2)
                                                        ? Radius.circular(16)
                                                        : Radius.circular(0),
                                                  )
                                                : BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(16),
                                                    bottomRight:
                                                        Radius.circular(16),
                                                    topRight: (tab != 2)
                                                        ? Radius.circular(16)
                                                        : Radius.circular(0),
                                                    topLeft: (tab != 0)
                                                        ? Radius.circular(16)
                                                        : Radius.circular(0),
                                                  )),
                                        child: TabBarView(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: StreamBuilder<
                                                      QuerySnapshot>(
                                                  stream: loadAds(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData ||
                                                        snapshot.data.docs
                                                                .length ==
                                                            0) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/icons/nothing.png",
                                                            width: 138,
                                                            height: 118,
                                                          ),
                                                          SizedBox(
                                                            height: 32,
                                                          ),
                                                          Text(
                                                            getTranslated(
                                                                context,
                                                                'ThereNothingHere'),
                                                            strutStyle:
                                                                StrutStyle(
                                                              forceStrutHeight:
                                                                  lang == 'ar'
                                                                      ? true
                                                                      : false,
                                                            ),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    lang == 'ar'
                                                                        ? 'DIN'
                                                                        : 'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xFFA3A3A3)),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            getTranslated(
                                                                context,
                                                                'ForNow'),
                                                            strutStyle:
                                                                StrutStyle(
                                                              forceStrutHeight:
                                                                  lang == 'ar'
                                                                      ? true
                                                                      : false,
                                                            ),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    lang == 'ar'
                                                                        ? 'DIN'
                                                                        : 'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xFFA3A3A3)),
                                                          )
                                                        ],
                                                      );
                                                    } else {
                                                      List<AdInfo> ads = [];
                                                      for (var doc in snapshot
                                                          .data.docs) {
                                                        ads.add(AdInfo(
                                                            description: doc
                                                                    .data()[
                                                                'Description'],
                                                            docId: doc.id,
                                                            address: doc.data()[
                                                                'Address'],
                                                            isCall: doc
                                                                .data()['Call'],
                                                            isLiked:
                                                                doc.data()['likes.${user.email}'] ??
                                                                    false,
                                                            isMessage: doc.data()[
                                                                'Message'],
                                                            price: doc.data()[
                                                                'Price'],
                                                            subCategory: doc
                                                                    .data()[
                                                                'Sub Category'],
                                                            title: doc
                                                                .data()['Title'],
                                                            user: doc.data()['User'],
                                                            mediaType: (doc.data()['MediaType'] == 'Video') ? AdType.video : AdType.image,
                                                            category: doc.data()['Category'],
                                                            media: doc.data()['Media']));
                                                      }
                                                      return GridView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                mainAxisSpacing:
                                                                    10,
                                                                crossAxisSpacing:
                                                                    10,
                                                                childAspectRatio:
                                                                    2 / 3),
                                                        itemCount: ads.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Hero(
                                                            tag: ads[index]
                                                                .docId,
                                                            child: AdMinizmized(
                                                              isCall: ads[index]
                                                                  .isCall,
                                                              isMessage: ads[
                                                                      index]
                                                                  .isMessage,
                                                              myUser:
                                                                  user.email,
                                                              isLiked:
                                                                  ads[index]
                                                                      .isLiked,
                                                              media: ads[index]
                                                                  .media,
                                                              docId: ads[index]
                                                                  .docId,
                                                              description: ads[
                                                                      index]
                                                                  .description,
                                                              address:
                                                                  ads[index]
                                                                      .address,
                                                              category:
                                                                  ads[index]
                                                                      .category,
                                                              price: ads[index]
                                                                  .price,
                                                              subCategory: ads[
                                                                      index]
                                                                  .subCategory,
                                                              title: ads[index]
                                                                  .title,
                                                              type: ads[index]
                                                                  .mediaType,
                                                              user: ads[index]
                                                                  .user,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/icons/nothing.png",
                                                  width: 138,
                                                  height: 118,
                                                ),
                                                SizedBox(
                                                  height: 32,
                                                ),
                                                Text(
                                                  getTranslated(context,
                                                      'ThereNothingHere'),
                                                  strutStyle: StrutStyle(
                                                    forceStrutHeight:
                                                        lang == 'ar'
                                                            ? true
                                                            : false,
                                                  ),
                                                  style: TextStyle(
                                                      fontFamily: lang == 'ar'
                                                          ? 'DIN'
                                                          : 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Color(0xFFA3A3A3)),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  getTranslated(
                                                      context, 'ForNow'),
                                                  strutStyle: StrutStyle(
                                                    forceStrutHeight:
                                                        lang == 'ar'
                                                            ? true
                                                            : false,
                                                  ),
                                                  style: TextStyle(
                                                      fontFamily: lang == 'ar'
                                                          ? 'DIN'
                                                          : 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Color(0xFFA3A3A3)),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: StreamBuilder<
                                                      QuerySnapshot>(
                                                  stream: loadLikedAds(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData ||
                                                        snapshot.data.docs
                                                                .length ==
                                                            0) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/icons/nothing.png",
                                                            width: 138,
                                                            height: 118,
                                                          ),
                                                          SizedBox(
                                                            height: 32,
                                                          ),
                                                          Text(
                                                            getTranslated(
                                                                context,
                                                                'ThereNothingHere'),
                                                            strutStyle:
                                                                StrutStyle(
                                                              forceStrutHeight:
                                                                  lang == 'ar'
                                                                      ? true
                                                                      : false,
                                                            ),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    lang == 'ar'
                                                                        ? 'DIN'
                                                                        : 'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xFFA3A3A3)),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            getTranslated(
                                                                context,
                                                                'ForNow'),
                                                            strutStyle:
                                                                StrutStyle(
                                                              forceStrutHeight:
                                                                  lang == 'ar'
                                                                      ? true
                                                                      : false,
                                                            ),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    lang == 'ar'
                                                                        ? 'DIN'
                                                                        : 'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xFFA3A3A3)),
                                                          )
                                                        ],
                                                      );
                                                    } else {
                                                      List<AdInfo> ads = [];
                                                      for (var doc in snapshot
                                                          .data.docs) {
                                                        ads.add(AdInfo(
                                                            description: doc
                                                                    .data()[
                                                                'Description'],
                                                            docId: doc.id,
                                                            address: doc.data()[
                                                                'Address'],
                                                            isCall: doc
                                                                .data()['Call'],
                                                            isLiked:
                                                                doc.data()['likes.${user.email}'] ??
                                                                    false,
                                                            isMessage: doc.data()[
                                                                'Message'],
                                                            price: doc.data()[
                                                                'Price'],
                                                            subCategory: doc
                                                                    .data()[
                                                                'Sub Category'],
                                                            title: doc
                                                                .data()['Title'],
                                                            user: doc.data()['User'],
                                                            mediaType: (doc.data()['MediaType'] == 'Video') ? AdType.video : AdType.image,
                                                            category: doc.data()['Category'],
                                                            media: doc.data()['Media']));
                                                      }

                                                      return GridView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                mainAxisSpacing:
                                                                    10,
                                                                crossAxisSpacing:
                                                                    10,
                                                                childAspectRatio:
                                                                    2 / 3),
                                                        itemCount: ads.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Hero(
                                                            tag: ads[index]
                                                                .docId,
                                                            child: AdMinizmized(
                                                              isCall: ads[index]
                                                                  .isCall,
                                                              isMessage: ads[
                                                                      index]
                                                                  .isMessage,
                                                              myUser:
                                                                  user.email,
                                                              isLiked:
                                                                  ads[index]
                                                                      .isLiked,
                                                              media: ads[index]
                                                                  .media,
                                                              docId: ads[index]
                                                                  .docId,
                                                              description: ads[
                                                                      index]
                                                                  .description,
                                                              address:
                                                                  ads[index]
                                                                      .address,
                                                              category:
                                                                  ads[index]
                                                                      .category,
                                                              price: ads[index]
                                                                  .price,
                                                              subCategory: ads[
                                                                      index]
                                                                  .subCategory,
                                                              title: ads[index]
                                                                  .title,
                                                              type: ads[index]
                                                                  .mediaType,
                                                              user: ads[index]
                                                                  .user,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }
              })
<<<<<<< HEAD
>>>>>>> parent of 80a976c (undo)
=======
>>>>>>> parent of 80a976c (undo)
        ],
      ),
    );
  }
}
