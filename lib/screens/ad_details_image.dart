import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwayes/screens/chat_screen.dart';
import 'package:kwayes/screens/seller_screen.dart';

class AdDetailsImage extends StatefulWidget {
  final String docId;
  final String imageUrl;

  AdDetailsImage(this.docId, this.imageUrl);

  @override
  _AdDetailsImageState createState() =>
      _AdDetailsImageState(docId: docId, imageUrl: imageUrl);
}

class _AdDetailsImageState extends State<AdDetailsImage>
    with SingleTickerProviderStateMixin {
  String docId;
  String imageUrl;
  _AdDetailsImageState({@required this.docId, @required this.imageUrl});
  String address, category, description, subCategory, price, title, user;
  bool selected = false;
  AnimationController controller;
  Animation<Offset> offset;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User myUser;

  bool open = false;

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);

  GoogleMapController _controller;

  void _onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;
    //final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await locationFromAddress(address);
    var first = addresses.first;
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(first.latitude, first.longitude), zoom: 15),
      ),
    );
  }

  loadAdDetails() async {
    return _firestore
        .collection('ads')
        .doc(docId)
        .get()
        .then((DocumentSnapshot snapshot) {
      var data = snapshot.data() as Map;

      setState(() {
        address = data['Address'];
        category = data['Category'];
        description = data['Description'];
        subCategory = data['Sub Category'];
        price = data['Price'];
        title = data['Title'];
        user = data['User'];
      });
    });
  }

  createChatroom(String chatRoomId, chatRoomMap) {
    _firestore.collection('ChatRoom').doc(chatRoomId).set(chatRoomMap);
  }

  Stream<DocumentSnapshot> loadAdProfile(user) {
    return _firestore.collection('users').doc(user).snapshots();
  }

  @override
  void initState() {
    myUser = auth.currentUser;
    super.initState();
    loadAdDetails();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: docId,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10),
                  child: Row(
                    mainAxisAlignment: (open)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: open,
                        child: IconButton(
                            icon: ImageIcon(
                              AssetImage('assets/images/icons/Back_button.png'),
                              size: 20,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                open = !open;
                              });
                              switch (controller.status) {
                                case AnimationStatus.completed:
                                  controller.reverse();
                                  break;
                                case AnimationStatus.dismissed:
                                  controller.forward();
                                  break;
                                default:
                              }
                            }),
                      ),
                      Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: ImageIcon(
                                  AssetImage('assets/images/icons/follow.png'),
                                  size: 20,
                                  color: Colors.black,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: ImageIcon(
                                  AssetImage('assets/images/icons/heart_2.png'),
                                  size: 20,
                                  color: Colors.black,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: ImageIcon(
                                  AssetImage('assets/images/icons/share_2.png'),
                                  size: 20,
                                  color: Colors.black,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: ImageIcon(
                                  AssetImage('assets/images/icons/close.png'),
                                  size: 14,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: offset,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 110),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 343,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(
                                    112, 107, 107, 0.23999999463558197),
                                offset: Offset(0, 4),
                                blurRadius: 20)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$category > $subCategory',
                                style: TextStyle(
                                    color: Color(0xFF716B6B),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500)),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(title,
                                      style: TextStyle(
                                          color: Color(0xFFA229F2),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500)),
                                  Text(price,
                                      style: TextStyle(
                                          color: Color(0xFFA229F2),
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        1.5,
                                child: Text(description,
                                    style: TextStyle(
                                      color: Color(0xFFA3A3A3),
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(address,
                                  style: TextStyle(
                                      color: Color(0xFF716B6B),
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: 158,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                        target: _initialcameraposition),
                                    myLocationButtonEnabled: false,
                                    mapToolbarEnabled: false,
                                    zoomControlsEnabled: false,
                                    zoomGesturesEnabled: false,
                                    tiltGesturesEnabled: false,
                                    rotateGesturesEnabled: false,
                                    scrollGesturesEnabled: false,
                                    mapType: MapType.normal,
                                    onMapCreated: _onMapCreated,
                                    myLocationEnabled: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: !open,
                        child: Column(
                          children: [
                            IconButton(
                                icon: ImageIcon(
                                  AssetImage(
                                      'assets/images/icons/arrow_up.png'),
                                  size: 24,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    open = !open;
                                  });
                                  switch (controller.status) {
                                    case AnimationStatus.completed:
                                      controller.reverse();
                                      break;
                                    case AnimationStatus.dismissed:
                                      controller.forward();
                                      break;
                                    default:
                                  }
                                }),
                            Text('For more information swipe up',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 11.58,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Container(
                          height: 63,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white.withOpacity(0.5)),
                          child: StreamBuilder<DocumentSnapshot>(
                            stream: loadAdProfile(user),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data.data() as Map;
                                String name = data['Name'];
                                String photo = data['photo_url'];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              builder) =>
                                                          SellerScreen(user,
                                                              name, photo)));
                                            },
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(photo),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                'contact seller',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                    color: Color(0xFFF4F1F1)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              icon: ImageIcon(
                                                AssetImage(
                                                    'assets/images/icons/message.png'),
                                                size: 24,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                String chatRoomId =
                                                    getChatRoomId(
                                                        user, myUser.email);
                                                List<String> users = [
                                                  user,
                                                  myUser.email
                                                ];
                                                Map<String, dynamic>
                                                    chatRoomMap = {
                                                  "users": users,
                                                  "chatRoomId": chatRoomId,
                                                  "AdId": docId
                                                };
                                                createChatroom(
                                                    chatRoomId, chatRoomMap);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                builder) =>
                                                            ChatScreen(
                                                              chatRoomId:
                                                                  chatRoomId,
                                                              myUser:
                                                                  myUser.email,
                                                            )));
                                              }),
                                          IconButton(
                                              icon: ImageIcon(
                                                AssetImage(
                                                    'assets/images/icons/call.png'),
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {}),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(2, 3).codeUnitAt(0) > b.substring(2, 3).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
