import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/model/ad_minimized.dart';
import 'package:kwayes/model/video_list_data.dart';
import 'dart:math' as math;

import 'package:kwayes/services/ReusableVideoListController.dart';
import 'package:kwayes/services/firebase_storage.dart';
import 'package:kwayes/widgets/ad_minimized_image.dart';
import 'package:kwayes/widgets/ad_minimized_video.dart';

class SellerScreen extends StatefulWidget {
  final String email;
  final String name;
  final String photo;

  SellerScreen(this.email, this.name, this.photo);

  @override
  _SellerScreenState createState() =>
      _SellerScreenState(email: email, name: name, photo: photo);
}

class _SellerScreenState extends State<SellerScreen> {
  String email, name, photo;

  _SellerScreenState(
      {@required this.email, @required this.name, @required this.photo});

  ReusableVideoListController videoListController;
  List<VideoListData> dataList = [];
  final ScrollController _scrollController = ScrollController();
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  bool _canBuildVideo = true;

  List<AdMinimizedInfo> ads = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  loadAds() async {
    return _firestore
        .collection('ads')
        .where('User', isEqualTo: email)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
<<<<<<< HEAD
        var data = doc.data() as Map;
        ads.add(AdMinimizedInfo(
            description: data['Description'],
            docId: doc.id,
            video: data['Video'],
            url: (data['Video'] == true) ? data['Video 1'] : data['Photo 1']));
=======
        ads.add(AdMinimizedInfo(
            description: doc.data()['Description'],
            docId: doc.id,
            video: doc.data()['Video'],
            url: (doc.data()['Video'] == true)
                ? doc.data()['Video 1']
                : doc.data()['Photo 1']));
>>>>>>> 728352692394a5334eb2908d623c6819ff7c48ec
      }

      setState(() {
        videoListController = ReusableVideoListController(count: ads.length);
      });

      _setupData();
    });
  }

  void _setupData() async {
    for (int index = 0; index < ads.length; index++) {
      String url = await downloadUrl(ads[index].url);
      setState(() {
        dataList.add(VideoListData(url));
      });
    }
  }

  bool _checkCanBuildVideo() {
    return _canBuildVideo;
  }

  @override
  void initState() {
    loadAds();
    super.initState();
  }

  @override
  void dispose() {
    videoListController.dispose();
    super.dispose();
  }

  Stream<DocumentSnapshot> loadSellerInfo(email) {
    return _firestore.collection('users').doc(email).snapshots();
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
                                AssetImage(
                                    'assets/images/icons/add_friend.png'),
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {}),
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
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                final now = DateTime.now();
                final timeDiff = now.millisecondsSinceEpoch - lastMilli;
                if (notification is ScrollUpdateNotification) {
                  final pixelsPerMilli = notification.scrollDelta / timeDiff;
                  if (pixelsPerMilli.abs() > 1) {
                    _canBuildVideo = false;
                  } else {
                    _canBuildVideo = true;
                  }
                  lastMilli = DateTime.now().millisecondsSinceEpoch;
                }

                if (notification is ScrollEndNotification) {
                  _canBuildVideo = true;
                  lastMilli = DateTime.now().millisecondsSinceEpoch;
                }

                return true;
              },
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                cacheExtent: 1000,
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.only(left: 10, right: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 3),
                itemCount: dataList.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  VideoListData videoListData = dataList[index];
                  return Hero(
                    tag: ads[index].docId,
                    child: (ads[index].video)
                        ? AdMinimizedVideo(
                            videoListData: videoListData,
                            videoListController: videoListController,
                            canBuildVideo: _checkCanBuildVideo,
                            docId: ads[index].docId,
                            index: index,
                            text: ads[index].description,
                          )
                        : AdMinimizedImage(ads[index].description,
                            videoListData.videoUrl, ads[index].docId),
                  );
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
