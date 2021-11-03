<<<<<<< HEAD
import 'package:kwayes/screens/seller_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdDetails extends StatefulWidget {
  final String docId;
  final String videoUrl;

  AdDetails(this.docId, this.videoUrl);

  @override
  _AdDetailsState createState() =>
      _AdDetailsState(docId: docId, videoUrl: videoUrl);
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/model/ad.dart';
import 'package:kwayes/screens/chat_screen.dart';
import 'package:kwayes/screens/seller_screen.dart';
import 'package:kwayes/widgets/gradient_icon.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;

class AdDetails extends StatefulWidget {
  final String address,
      category,
      description,
      subCategory,
      price,
      title,
      user,
      media,
      docId;
  final bool isLiked, isCall, isMessage;
  final AdType type;
  final String myUser;
  AdDetails(
      {@required this.address,
      @required this.category,
      @required this.description,
      @required this.docId,
      @required this.media,
      @required this.isCall,
      @required this.isMessage,
      @required this.price,
      @required this.subCategory,
      @required this.title,
      @required this.user,
      @required this.isLiked,
      @required this.myUser,
      @required this.type});
  @override
  _AdDetailsState createState() => _AdDetailsState(isLiked: isLiked);
>>>>>>> parent of 80a976c (undo)
}

class _AdDetailsState extends State<AdDetails>
    with SingleTickerProviderStateMixin {
<<<<<<< HEAD
  String docId;
  String videoUrl;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> loadAdDetails(documentId) {
    return _firestore.collection('ads').doc(documentId).snapshots();
  }

  Stream<DocumentSnapshot> loadAdProfile(user) {
    return _firestore.collection('users').doc(user).snapshots();
  }

  _AdDetailsState({this.docId, this.videoUrl});

  VideoPlayerController _controller;

  bool selected = false;
  AnimationController controller;
  Animation<Offset> offset;

  bool open = false;

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);

  GoogleMapController _googlecontroller;

  void _onMapCreated(GoogleMapController _cntlr, String address) async {
    _googlecontroller = _cntlr;
    //final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await locationFromAddress(address);
    var first = addresses.first;
    _googlecontroller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(first.latitude, first.longitude), zoom: 15),
      ),
    );
  }
=======
  VideoPlayerController _videoController;

  bool isLiked = false;

  _AdDetailsState({@required this.isLiked});

  bool isFollowing = false;

  bool open = false;

  AnimationController controller;
  Animation<Offset> offset;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final followersRef = FirebaseFirestore.instance.collection('followers');
  final followingRef = FirebaseFirestore.instance.collection('following');

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);

  GoogleMapController _controller;
>>>>>>> parent of 80a976c (undo)

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _controller = VideoPlayerController.network(
      videoUrl,
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.play();
    _controller.setLooping(true);
    _controller.initialize();
=======
    _loadAd(type: widget.type, media: widget.media);
    checkIfFollowing();
>>>>>>> parent of 80a976c (undo)
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  @override
<<<<<<< HEAD
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: docId,
        child: StreamBuilder(
          stream: loadAdDetails(docId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String address = snapshot.data.data()['Address'];
              String category = snapshot.data.data()['Category'];
              String description = snapshot.data.data()['Description'];
              String subCategory = snapshot.data.data()['Sub Category'];
              String price = snapshot.data.data()['Price'];
              String title = snapshot.data.data()['Title'];
              String user = snapshot.data.data()['User'];

              return Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                            width: _controller.value.size?.width ?? 0,
                            height: _controller.value.size?.height ?? 0,
                            child: VideoPlayer(_controller))),
                  ),
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
                                  AssetImage(
                                      'assets/images/icons/Back_button.png'),
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
                                      AssetImage(
                                          'assets/images/icons/follow.png'),
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: ImageIcon(
                                      AssetImage(
                                          'assets/images/icons/heart_2.png'),
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: ImageIcon(
                                      AssetImage(
                                          'assets/images/icons/share_2.png'),
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: ImageIcon(
                                      AssetImage(
                                          'assets/images/icons/close.png'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    width: (MediaQuery.of(context).size.width -
                                            40) /
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
                                        onMapCreated: (val) {
                                          _onMapCreated(val, address);
                                        },
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
                                    //String email = data['Email'];
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
                                                              SellerScreen(
                                                                  user,
                                                                  name,
                                                                  photo)));
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
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        color:
                                                            Color(0xFFF4F1F1)),
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
                                                  onPressed: () {}),
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
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
=======
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      body: Hero(
        tag: widget.docId,
        child: Stack(
          children: [
            (widget.type == AdType.image)
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: widget.media,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: VideoPlayer(_videoController),
                  ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
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
                          AssetImage(lang == 'ar'
                              ? 'assets/images/icons/Back_button_ar.png'
                              : 'assets/images/icons/Back_button.png'),
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
                            icon: GradientIcon(
                              'assets/images/icons/follow.png',
                              20,
                              LinearGradient(
                                  transform:
                                      GradientRotation(-180 * (math.pi / 180)),
                                  begin: Alignment(
                                      1.396263599395752, 0.2368917167186737),
                                  end: Alignment(
                                      -0.2368917167186737, 0.07294762879610062),
                                  colors: [
                                    (isFollowing)
                                        ? Color.fromRGBO(
                                            149, 46, 191, 0.9800000190734863)
                                        : Colors.black,
                                    (isFollowing)
                                        ? Color.fromRGBO(214, 41, 118, 1)
                                        : Colors.black
                                  ]),
                            ),
                            onPressed: () {
                              if (isFollowing) {
                                handleUnfollowUser();
                              } else {
                                handleFollowUser();
                              }
                            }),
                        IconButton(
                            icon: GradientIcon(
                              'assets/images/icons/heart_2.png',
                              20,
                              LinearGradient(
                                  transform:
                                      GradientRotation(-180 * (math.pi / 180)),
                                  begin: Alignment(
                                      1.396263599395752, 0.2368917167186737),
                                  end: Alignment(
                                      -0.2368917167186737, 0.07294762879610062),
                                  colors: [
                                    (isLiked)
                                        ? Color.fromRGBO(
                                            149, 46, 191, 0.9800000190734863)
                                        : Colors.black,
                                    (isLiked)
                                        ? Color.fromRGBO(214, 41, 118, 1)
                                        : Colors.black
                                  ]),
                            ),
                            onPressed: handleLikeAd),
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
                                AssetImage('assets/images/icons/arrow_up.png'),
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
                          Text(getTranslated(context, 'AdSwipe'),
                              strutStyle: StrutStyle(
                                forceStrutHeight: lang == 'ar' ? true : false,
                              ),
                              style: TextStyle(
                                  fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
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
                          stream: loadAdProfile(widget.user),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              String name = snapshot.data.data()['Name'];
                              String photo = snapshot.data.data()['photo_url'];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                                        SellerScreen(
                                                            widget.user,
                                                            name,
                                                            photo,
                                                            isFollowing,
                                                            widget.myUser)));
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
                                              getTranslated(
                                                  context, 'ContactSeller'),
                                              strutStyle: StrutStyle(
                                                forceStrutHeight:
                                                    lang == 'ar' ? true : false,
                                              ),
                                              style: TextStyle(
                                                  fontFamily: lang == 'ar'
                                                      ? 'DIN'
                                                      : 'Roboto',
                                                  fontSize: 12,
                                                  color: Color(0xFFF4F1F1)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: widget.isMessage,
                                          child: IconButton(
                                              icon: ImageIcon(
                                                AssetImage(
                                                    'assets/images/icons/message.png'),
                                                size: 24,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                String chatRoomId =
                                                    getChatRoomId(widget.user,
                                                        widget.myUser);
                                                List<String> users = [
                                                  widget.user,
                                                  widget.myUser
                                                ];
                                                Map<String, dynamic>
                                                    chatRoomMap = {
                                                  "users": users,
                                                  "chatRoomId": chatRoomId,
                                                  "AdId": widget.docId
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
                                                                  widget.myUser,
                                                            )));
                                              }),
                                        ),
                                        Visibility(
                                          visible: widget.isCall,
                                          child: IconButton(
                                              icon: ImageIcon(
                                                AssetImage(
                                                    'assets/images/icons/call.png'),
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {}),
                                        ),
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
                          Text('${widget.category} > ${widget.subCategory}',
                              style: TextStyle(
                                  color: Color(0xFF716B6B),
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.title,
                                    style: TextStyle(
                                        color: Color(0xFFA229F2),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500)),
                                Text(widget.price,
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
                              width: (MediaQuery.of(context).size.width - 40) /
                                  1.5,
                              child: Text(widget.description,
                                  style: TextStyle(
                                    color: Color(0xFFA3A3A3),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(widget.address,
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
          ],
>>>>>>> parent of 80a976c (undo)
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

  void _loadAd({AdType type, String media}) {
    switch (type) {
      case AdType.video:
        _videoController = null;
        _videoController?.dispose();
        _videoController = VideoPlayerController.network(media)
          ..initialize().then((_) {
            setState(() {});
            if (_videoController.value.isInitialized) {
              _videoController.play();
              _videoController.setLooping(true);
            }
          });
        break;
      case AdType.image:
        break;
    }
  }

  void _onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;
    //final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await Geocoder.local.findAddressesFromQuery(widget.address);
    var first = addresses.first;
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(first.coordinates.latitude, first.coordinates.longitude),
            zoom: 15),
      ),
    );
  }

  Stream<DocumentSnapshot> loadAdProfile(user) {
    return _firestore.collection('users').doc(user).snapshots();
  }

  createChatroom(String chatRoomId, chatRoomMap) {
    _firestore.collection('ChatRoom').doc(chatRoomId).set(chatRoomMap);
  }

  checkIfFollowing() async {
    return followersRef
        .doc(widget.user)
        .collection('userFollowers')
        .doc(widget.myUser)
        .get()
        .then((doc) {
      setState(() {
        isFollowing = doc.exists;
      });
    });
  }

  handleLikeAd() {
    if (isLiked) {
      _firestore
          .collection('ads')
          .doc(widget.docId)
          .update({'likes.${widget.myUser}': false});
      setState(() {
        isLiked = false;
      });
    } else {
      _firestore
          .collection('ads')
          .doc(widget.docId)
          .update({'likes.${widget.myUser}': true});
      setState(() {
        isLiked = true;
      });
    }
  }

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
    followersRef
        .doc(widget.user)
        .collection('userFollowers')
        .doc(widget.myUser)
        .set({});
    followingRef
        .doc(widget.myUser)
        .collection('userFollowing')
        .doc(widget.user)
        .set({});
  }

  handleUnfollowUser() {
    setState(() {
      isFollowing = false;
    });
    followersRef
        .doc(widget.user)
        .collection('userFollowers')
        .doc(widget.myUser)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    followingRef
        .doc(widget.myUser)
        .collection('userFollowing')
        .doc(widget.user)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(2, 3).codeUnitAt(0) > b.substring(2, 3).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
>>>>>>> parent of 80a976c (undo)
}
