import 'package:kwayes/screens/seller_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdDetails extends StatefulWidget {
  final String docId;
  final String videoUrl;

  AdDetails(this.docId, this.videoUrl);

  @override
  _AdDetailsState createState() =>
      _AdDetailsState(docId: docId, videoUrl: videoUrl);
}

class _AdDetailsState extends State<AdDetails>
    with SingleTickerProviderStateMixin {
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
    var addresses = await Geocoder.local.findAddressesFromQuery(address);
    var first = addresses.first;
    _googlecontroller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(first.coordinates.latitude, first.coordinates.longitude),
            zoom: 15),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      videoUrl,
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.play();
    _controller.setLooping(true);
    _controller.initialize();
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
                                    String email =
                                        snapshot.data.data()['Email'];
                                    String name = snapshot.data.data()['Name'];
                                    String photo =
                                        snapshot.data.data()['photo_url'];
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
        ),
      ),
    );
  }
}
