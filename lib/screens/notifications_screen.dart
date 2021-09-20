// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:kwayes/model/ad_minimized.dart';
// import 'package:kwayes/model/video_list_data.dart';
// import 'package:kwayes/services/ReusableVideoListController.dart';
// import 'package:kwayes/widgets/ad_minimized_video.dart';
// import 'package:kwayes/widgets/resuable_video_player.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // ReusableVideoListController videoListController;
  // List<VideoListData> dataList = [];
  // final ScrollController _scrollController = ScrollController();
  // int lastMilli = DateTime.now().millisecondsSinceEpoch;
  // bool _canBuildVideo = true;

  // List<AdMinimizedInfo> ads = [];

  // FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // loadAds() async {
  //   return _firestore
  //       .collection('ads')
  //       .orderBy('Date', descending: true)
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     for (var doc in snapshot.docs) {
  //       ads.add(AdMinimizedInfo(
  //           description: doc.data()['Description'], docId: doc.id));
  //     }
  //     setState(() {
  //       videoListController = ReusableVideoListController(count: ads.length);
  //     });

  //     _setupData();
  //   });
  // }

  // @override
  // void initState() {
  //   loadAds();
  //   super.initState();
  // }

  // void _setupData() {
  //   for (int index = 0; index < ads.length; index++) {
  //     dataList.add(VideoListData("Video $index",
  //         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
  //   }
  // }

  // bool _checkCanBuildVideo() {
  //   return _canBuildVideo;
  // }

  // @override
  // void dispose() {
  //   videoListController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Container(
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child: NotificationListener<ScrollNotification>(
      //           onNotification: (notification) {
      //             final now = DateTime.now();
      //             final timeDiff = now.millisecondsSinceEpoch - lastMilli;
      //             if (notification is ScrollUpdateNotification) {
      //               final pixelsPerMilli = notification.scrollDelta / timeDiff;
      //               if (pixelsPerMilli.abs() > 1) {
      //                 _canBuildVideo = false;
      //               } else {
      //                 _canBuildVideo = true;
      //               }
      //               lastMilli = DateTime.now().millisecondsSinceEpoch;
      //             }

      //             if (notification is ScrollEndNotification) {
      //               _canBuildVideo = true;
      //               lastMilli = DateTime.now().millisecondsSinceEpoch;
      //             }

      //             return true;
      //           },
      //           child: GridView.builder(
      //             scrollDirection: Axis.vertical,
      //             shrinkWrap: true,
      //             cacheExtent: 1000,
      //             addAutomaticKeepAlives: true,
      //             padding: const EdgeInsets.only(left: 10, right: 10),
      //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 mainAxisSpacing: 10,
      //                 crossAxisSpacing: 10,
      //                 childAspectRatio: 2 / 3),
      //             itemCount: dataList.length,
      //             controller: _scrollController,
      //             itemBuilder: (context, index) {
      //               VideoListData videoListData = dataList[index];
      //               return Hero(
      //                 tag: ads[index].docId,
      //                 child: ReusableVideoListWidget(
      //                   videoListData: videoListData,
      //                   videoListController: videoListController,
      //                   canBuildVideo: _checkCanBuildVideo,
      //                   docId: ads[index].docId,
      //                   index: index,
      //                   text: ads[index].description,
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
