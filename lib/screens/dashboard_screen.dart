import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/model/ad.dart';
import 'package:kwayes/screens/wishlist_screen.dart';
import 'package:kwayes/widgets/ad_minimized.dart';
import 'package:kwayes/widgets/filter_card.dart';
import 'package:kwayes/widgets/gradient_icon.dart';
import 'dart:math' as math;
import 'package:kwayes/widgets/navigation_drawer_widget.dart';

class DashBoardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  DashBoardScreen({@required this.scaffoldKey});
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String categorySelected = '';
  String query = '';

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User myUser;

  Stream<QuerySnapshot> loadAds() {
    return _firestore
        .collection('ads')
        .orderBy('Date', descending: true)
        .snapshots();
  }

  @override
  void initState() {
    myUser = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        backgroundColor: Colors.white,
        body: Builder(builder: (context) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Image.asset(
                          'assets/images/icons/filter.png',
                          width: 19,
                          height: 18,
                        ),
                        onPressed: () {
                          widget.scaffoldKey.currentState.openDrawer();
                        }),
                    IconButton(
                        icon: Image.asset(
                          'assets/images/icons/heart.png',
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext builder) =>
                                      WishListScreen()));
                        }),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            query = val;
                          });
                        },
                        style: TextStyle(
                          color: Color(0xFF716B6B),
                          fontSize: 14,
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        ),
                        strutStyle: StrutStyle(
                          forceStrutHeight: lang == 'ar' ? true : false,
                        ),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 25, right: 25),
                            hintText: getTranslated(context, 'SearchTxt'),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/images/icons/search.png',
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Color(0xFF716B6B),
                              fontSize: 14,
                              fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFFA3A3A3)),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFFA3A3A3)),
                              borderRadius: BorderRadius.circular(32),
                            )),
                      ),
                    ),
                    IconButton(
                        icon: Image.asset(
                          'assets/images/icons/share.png',
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
              (categorySelected == '')
                  ? Container(
                      height: 72,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          FilterCard(
                              getTranslated(context, 'MenFilter'),
                              'assets/images/backgrounds/men_style.png',
                              lang, () {
                            setState(() {
                              categorySelected = "Men's Fashion";
                            });
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          FilterCard(
                              getTranslated(context, 'WomenFilter'),
                              'assets/images/backgrounds/woman_style.png',
                              lang, () {
                            setState(() {
                              categorySelected = "Women's Style";
                            });
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          FilterCard(
                              getTranslated(context, 'SmartphoneFilter'),
                              'assets/images/backgrounds/smartphone.png',
                              lang, () {
                            setState(() {
                              categorySelected = "Smartphone";
                            });
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          FilterCard(
                              getTranslated(context, 'MultimediaFilter'),
                              'assets/images/backgrounds/multimedia.png',
                              lang, () {
                            setState(() {
                              categorySelected = "Multimedia";
                            });
                          }),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        IconButton(
                            icon: ImageIcon(
                              AssetImage(lang == 'ar'
                                  ? 'assets/images/icons/Back_button_ar.png'
                                  : 'assets/images/icons/Back_button.png'),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                categorySelected = '';
                              });
                            })
                      ],
                    ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: loadAds(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GradientIcon(
                                'assets/images/icons/empty.png',
                                50,
                                LinearGradient(
                                    transform: GradientRotation(
                                        -180 * (math.pi / 180)),
                                    begin: Alignment(
                                        1.396263599395752, 0.2368917167186737),
                                    end: Alignment(-0.2368917167186737,
                                        0.07294762879610062),
                                    colors: [
                                      Color.fromRGBO(
                                          149, 46, 191, 0.9800000190734863),
                                      Color.fromRGBO(214, 41, 118, 1)
                                    ]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                getTranslated(context, 'NoAds'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      List<AdInfo> ads = [];
                      List<AdInfo> sorted = [];
                      for (var doc in snapshot.data.docs) {
                        ads.add(AdInfo(
                            description: doc.data()['Description'],
                            docId: doc.id,
                            address: doc.data()['Address'],
                            isCall: doc.data()['Call'],
                            isLiked:
                                doc.data()['likes.${myUser.email}'] ?? false,
                            isMessage: doc.data()['Message'],
                            price: doc.data()['Price'],
                            subCategory: doc.data()['Sub Category'],
                            title: doc.data()['Title'],
                            user: doc.data()['User'],
                            mediaType: (doc.data()['MediaType'] == 'Video')
                                ? AdType.video
                                : AdType.image,
                            category: doc.data()['Category'],
                            media: doc.data()['Media']));
                      }
                      return Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2 / 3),
                          itemCount: ads.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: ads[index].docId,
                              child: AdMinizmized(
                                isCall: ads[index].isCall,
                                isMessage: ads[index].isMessage,
                                myUser: myUser.email,
                                isLiked: ads[index].isLiked,
                                media: ads[index].media,
                                docId: ads[index].docId,
                                description: ads[index].description,
                                address: ads[index].address,
                                category: ads[index].category,
                                price: ads[index].price,
                                subCategory: ads[index].subCategory,
                                title: ads[index].title,
                                type: ads[index].mediaType,
                                user: ads[index].user,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
            ],
          );
        }),
      ),
    );
  }
}
