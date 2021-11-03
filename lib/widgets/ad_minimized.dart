import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/model/ad.dart';
import 'package:kwayes/screens/ad_details.dart';
import 'package:video_player/video_player.dart';

class AdMinizmized extends StatefulWidget {
  final bool isLiked, isCall, isMessage;
  final String address,
      category,
      description,
      subCategory,
      price,
      title,
      user,
      media,
      myUser,
      docId;
  final AdType type;

  AdMinizmized(
      {@required this.address,
      @required this.category,
      @required this.description,
      @required this.docId,
      @required this.media,
      @required this.price,
      @required this.isCall,
      @required this.isMessage,
      @required this.subCategory,
      @required this.title,
      @required this.user,
      @required this.myUser,
      @required this.isLiked,
      @required this.type});

  @override
  _AdMinizmizedState createState() => _AdMinizmizedState();
}

class _AdMinizmizedState extends State<AdMinizmized> {
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _loadAd(media: widget.media, type: widget.type);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (_videoController.value.isPlaying) {
          _videoController?.pause();
        } else {
          _videoController?.play();
        }
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext builder) => AdDetails(
                      isCall: widget.isCall,
                      isMessage: widget.isMessage,
                      myUser: widget.myUser,
                      isLiked: widget.isLiked,
                      address: widget.address,
                      category: widget.category,
                      description: widget.description,
                      docId: widget.docId,
                      media: widget.media,
                      price: widget.price,
                      subCategory: widget.subCategory,
                      title: widget.title,
                      type: widget.type,
                      user: widget.user,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            (widget.type == AdType.image)
                ? AspectRatio(
                    aspectRatio: 2 / 3,
                    child: CachedNetworkImage(
                      imageUrl: widget.media,
                      fit: BoxFit.cover,
                    ),
                  )
                : AspectRatio(
                    aspectRatio: 2 / 3,
                    child: VideoPlayer(_videoController),
                  ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment(-4.393781338762892e-9, -1),
                    end: Alignment(1, 6.106226635438361e-16),
                    colors: [
                      Color.fromRGBO(0, 0, 0, 1).withOpacity(0.3),
                      Color.fromRGBO(0, 0, 0, 0).withOpacity(0.3)
                    ]),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadAd({AdType type, String media}) {
    switch (type) {
      case AdType.video:
        _videoController = null;
        _videoController?.dispose();
        _videoController = VideoPlayerController.network(media)
          ..initialize().then((_) {
            setState(() {});
            if (_videoController.value.isInitialized) {
              _videoController.setLooping(true);
            }
          });
        break;
      case AdType.image:
        break;
    }
  }
}
