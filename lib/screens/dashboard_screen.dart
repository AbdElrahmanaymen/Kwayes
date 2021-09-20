import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/localization/localization_constants.dart';
import 'package:kwayes/model/ad_minimized.dart';
import 'package:kwayes/model/video_list_data.dart';
import 'package:kwayes/services/ReusableVideoListController.dart';
import 'package:kwayes/services/firebase_storage.dart';
import 'package:kwayes/widgets/ad_minimized_image.dart';
import 'package:kwayes/widgets/filter_card.dart';
import 'package:kwayes/widgets/ad_minimized_video.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  ReusableVideoListController videoListController;
  List<VideoListData> dataList = [];
  final ScrollController _scrollController = ScrollController();
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  bool _canBuildVideo = true;

  String categorySelected = '';
  String query = '';

  List<AdMinimizedInfo> ads = [];
  List<AdMinimizedInfo> sorted = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  loadAds() async {
    return _firestore
        .collection('ads')
        .orderBy('Date', descending: true)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map;

        ads.add(AdMinimizedInfo(
            description: data['Description'],
            docId: doc.id,
            video: data['Video'],
            category: data['Category'],
            url: (data['Video'] == true) ? data['Video 1'] : data['Photo 1']));
      }

      sorted = ads;

      setState(() {
        videoListController = ReusableVideoListController(count: sorted.length);
      });

      _setupData();
    });
  }

  @override
  void initState() {
    loadAds();
    super.initState();
  }

  void _setupData() async {
    dataList.clear();
    for (int index = 0; index < sorted.length; index++) {
      String url = await downloadUrl(sorted[index].url);
      setState(() {
        dataList.add(VideoListData(url));
      });
    }
  }

  bool _checkCanBuildVideo() {
    return _canBuildVideo;
  }

  @override
  void dispose() {
    videoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    onPressed: () {}),
                IconButton(
                    icon: Image.asset(
                      'assets/images/icons/heart.png',
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {}),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        query = val;
                      });
                      if (query == '' || query.isEmpty) {
                        setState(() {
                          sorted = ads;
                          videoListController =
                              ReusableVideoListController(count: sorted.length);
                        });
                        _setupData();
                      } else {
                        setState(() {
                          sorted = ads
                              .where((element) => element.description
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                          videoListController =
                              ReusableVideoListController(count: sorted.length);
                        });
                        _setupData();
                      }
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
                        contentPadding: EdgeInsets.only(left: 25),
                        hintText: getTranslated(context, 'SearchTxt'),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/icons/search.png',
                            // width: 24,
                            // height: 24,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xFF716B6B),
                          fontSize: 14,
                          fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFA3A3A3)),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFA3A3A3)),
                          borderRadius: BorderRadius.circular(32),
                        )),
                  ),
                ),
                // Container(
                //   height: 40,
                //   width: MediaQuery.of(context).size.width / 1.8,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Color(0xFFA3A3A3), width: 1),
                //     borderRadius: BorderRadius.circular(32),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 15),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           'assets/images/icons/search.png',
                //           width: 24,
                //           height: 24,
                //         ),
                //         SizedBox(
                //           width: 5,
                //         ),
                //         Text(
                //           getTranslated(context, 'SearchTxt'),
                //           strutStyle: StrutStyle(
                //             forceStrutHeight: lang == 'ar' ? true : false,
                //           ),
                //           style: TextStyle(
                //             color: Color(0xFFA3A3A3),
                //             fontSize: 14,
                //             fontFamily: lang == 'ar' ? 'DIN' : 'Roboto',
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
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
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      FilterCard(getTranslated(context, 'MenFilter'),
                          'assets/images/backgrounds/men_style.png', lang, () {
                        setState(() {
                          categorySelected = 'Men';
                          sorted = ads
                              .where((e) => e.category == categorySelected)
                              .toList();
                          videoListController =
                              ReusableVideoListController(count: sorted.length);
                        });
                        _setupData();
                      }),
                      SizedBox(
                        width: 10,
                      ),
                      FilterCard(
                          getTranslated(context, 'WomenFilter'),
                          'assets/images/backgrounds/woman_style.png',
                          lang, () {
                        setState(() {
                          categorySelected = 'Woman';
                          sorted = ads
                              .where((e) => e.category == categorySelected)
                              .toList();
                          videoListController =
                              ReusableVideoListController(count: sorted.length);
                        });
                        _setupData();
                      }),
                      SizedBox(
                        width: 10,
                      ),
                      FilterCard(getTranslated(context, 'SmartphoneFilter'),
                          'assets/images/backgrounds/smartphone.png', lang, () {
                        setState(() {
                          categorySelected = 'Smartphone';
                          sorted = ads
                              .where((e) => e.category == categorySelected)
                              .toList();
                          videoListController =
                              ReusableVideoListController(count: sorted.length);
                        });
                        _setupData();
                      }),
                      SizedBox(
                        width: 10,
                      ),
                      FilterCard(getTranslated(context, 'MultimediaFilter'),
                          'assets/images/backgrounds/multimedia.png', lang, () {
                        setState(() {
                          categorySelected = 'Multimedia';
                          sorted = ads
                              .where((e) => e.category == categorySelected)
                              .toList();
                          videoListController =
                              ReusableVideoListController(count: sorted.length);
                        });
                        _setupData();
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
                          AssetImage('assets/images/icons/Back_button.png'),
                          size: 20,
                          //color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            categorySelected = '';
                            sorted = ads;
                            videoListController = ReusableVideoListController(
                                count: sorted.length);
                          });
                          _setupData();
                        })
                  ],
                ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
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
                    tag: sorted[index].docId,
                    child: (sorted[index].video)
                        ? AdMinimizedVideo(
                            videoListData: videoListData,
                            videoListController: videoListController,
                            canBuildVideo: _checkCanBuildVideo,
                            docId: sorted[index].docId,
                            index: index,
                            text: sorted[index].description,
                          )
                        : AdMinimizedImage(sorted[index].description,
                            videoListData.videoUrl, sorted[index].docId),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
