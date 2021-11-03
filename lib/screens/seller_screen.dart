import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/model/ad.dart';
import 'dart:math' as math;

import 'package:kwayes/widgets/ad_minimized.dart';
import 'package:kwayes/widgets/gradient_icon.dart';

class SellerScreen extends StatefulWidget {
  final String email;
  final String name;
  final String photo;
  final String myUser;
  final bool isFollowing;

  SellerScreen(
      this.email, this.name, this.photo, this.isFollowing, this.myUser);

  @override
  _SellerScreenState createState() => _SellerScreenState(
      email: email,
      name: name,
      photo: photo,
      isFollowing: isFollowing,
      myUser: myUser);
}

class _SellerScreenState extends State<SellerScreen> {
  String email, name, photo, myUser;

  bool isFollowing;

  _SellerScreenState(
      {@required this.email,
      @required this.name,
      @required this.photo,
      @required this.myUser,
      @required this.isFollowing});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final followersRef = FirebaseFirestore.instance.collection('followers');
  final followingRef = FirebaseFirestore.instance.collection('following');

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(email)
        .collection('userFollowers')
        .doc(myUser)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  Stream<QuerySnapshot> loadSellerAds() {
    return _firestore
        .collection('ads')
        .where('User', isEqualTo: email)
        .snapshots();
  }

  @override
  void initState() {
    checkIfFollowing();
    super.initState();
  }

  Stream<DocumentSnapshot> loadSellerInfo(email) {
    return _firestore.collection('users').doc(email).snapshots();
  }

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
    followersRef.doc(email).collection('userFollowers').doc(myUser).set({});
    followingRef.doc(myUser).collection('userFollowing').doc(email).set({});
  }

  handleUnfollowUser() {
    setState(() {
      isFollowing = false;
    });
    followersRef
        .doc(email)
        .collection('userFollowers')
        .doc(myUser)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    followingRef
        .doc(myUser)
        .collection('userFollowing')
        .doc(email)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 375,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(162, 41, 242, 0.25),
                      offset: Offset(0, 8),
                      blurRadius: 16)
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26.25),
                  bottomRight: Radius.circular(26.25),
                ),
                gradient: LinearGradient(
                    transform: GradientRotation(-180 * (math.pi / 180)),
                    begin: Alignment(1.396263599395752, 0.2368917167186737),
                    end: Alignment(-0.2368917167186737, 0.07294762879610062),
                    colors: [
                      Color.fromRGBO(149, 46, 191, 0.9800000190734863),
                      Color.fromRGBO(214, 41, 118, 1)
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: ImageIcon(
                              AssetImage('assets/images/icons/Back_button.png'),
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: loadSellerInfo(email),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        String status = snapshot.data.data()['Status'];
                        return Container(
                          width: 77,
                          height: 79,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(77, 77)),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 77,
                                  height: 77,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(photo),
                                        fit: BoxFit.fitWidth),
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(77, 77)),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 62.5,
                                left: 57.12,
                                child: Container(
                                  width: 16.54,
                                  height: 16.54,
                                  decoration: new BoxDecoration(
                                    color: (status == 'online')
                                        ? Color(0xFF64D62F)
                                        : Color(0xFFFAFAFB),
                                    shape: BoxShape.circle,
                                    border: new Border.all(
                                      color: Color(0xFFFAFAFB),
                                      width: 1.84,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                            fontFamily: 'Roboto'),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 22),
                    child: Container(
                      width: 144,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: ImageIcon(
                                AssetImage((isFollowing)
                                    ? 'assets/images/icons/check-circle.png'
                                    : 'assets/images/icons/add_friend.png'),
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                if (isFollowing) {
                                  handleUnfollowUser();
                                } else {
                                  handleFollowUser();
                                }
                              }),
                          IconButton(
                              icon: ImageIcon(
                                AssetImage('assets/images/icons/message.png'),
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: ImageIcon(
                                AssetImage('assets/images/icons/call.png'),
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {}),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text("Products",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 24)),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: loadSellerAds(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientIcon(
                            'assets/images/icons/empty.png',
                            50,
                            LinearGradient(
                                transform:
                                    GradientRotation(-180 * (math.pi / 180)),
                                begin: Alignment(
                                    1.396263599395752, 0.2368917167186737),
                                end: Alignment(
                                    -0.2368917167186737, 0.07294762879610062),
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
                            "No ads in the meantime.",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Futura BdCn BT',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<AdInfo> ads = [];
                    for (var doc in snapshot.data.docs) {
                      ads.add(AdInfo(
                          description: doc.data()['Description'],
                          docId: doc.id,
                          address: doc.data()['Address'],
                          isCall: doc.data()['Call'],
                          isLiked: doc.data()['likes.$myUser'] ?? false,
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
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            myUser: myUser,
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
                    );
                  }
                }),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
