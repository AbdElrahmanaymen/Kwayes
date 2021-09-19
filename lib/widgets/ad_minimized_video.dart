import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:kwayes/model/video_list_data.dart';
import 'package:kwayes/services/ReusableVideoListController.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:kwayes/screens/ad_details.dart';

class AdMinimizedVideo extends StatefulWidget {
  final VideoListData videoListData;
  final ReusableVideoListController videoListController;
  final Function canBuildVideo;
  final String docId;
  final int index;
  final String text;

  const AdMinimizedVideo(
      {Key key,
      this.videoListData,
      this.videoListController,
      this.canBuildVideo,
      this.docId,
      this.index,
      this.text})
      : super(key: key);

  @override
  _AdMinimizedVideoState createState() => _AdMinimizedVideoState();
}

class _AdMinimizedVideoState extends State<AdMinimizedVideo> {
  VideoListData get videoListData => widget.videoListData;
  BetterPlayerController controller;
  StreamController<BetterPlayerController>
      betterPlayerControllerStreamController = StreamController.broadcast();
  bool _initialized = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerControllerStreamController.close();
    super.dispose();
  }

  void _setupController() {
    if (controller == null) {
      controller = widget.videoListController.getBetterPlayerController();
      if (controller != null) {
        controller.setupDataSource(BetterPlayerDataSource.network(
            videoListData.videoUrl,
            cacheConfiguration:
                BetterPlayerCacheConfiguration(useCache: true)));
        controller.setControlsEnabled(false);
        controller.setOverriddenAspectRatio(2 / 3);

        controller.setVolume(0);
        if (widget.index == 0) {
          controller.play();
        }
        controller.setLooping(true);

        if (!betterPlayerControllerStreamController.isClosed) {
          betterPlayerControllerStreamController.add(controller);
        }
        controller.addEventsListener(onPlayerEvent);
      }
    }
  }

  void _freeController() {
    if (!_initialized) {
      _initialized = true;
      return;
    }
    if (controller != null && _initialized) {
      controller.removeEventsListener(onPlayerEvent);
      widget.videoListController.freeBetterPlayerController(controller);
      controller.pause();
      controller = null;
      if (!betterPlayerControllerStreamController.isClosed) {
        betterPlayerControllerStreamController.add(null);
      }
      _initialized = false;
    }
  }

  void onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      videoListData.lastPosition = event.parameters["progress"] as Duration;
    }
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (videoListData.lastPosition != null) {
        controller.seekTo(videoListData.lastPosition);
      }
      if (videoListData.wasPlaying) {
        controller.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (controller.isPlaying()) {
          controller.pause();
        } else {
          controller.play();
        }
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext builder) =>
                    AdDetails(widget.docId, videoListData.videoUrl)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            VisibilityDetector(
              key: Key(hashCode.toString() + DateTime.now().toString()),
              onVisibilityChanged: (info) {
                if (!widget.canBuildVideo()) {
                  _timer?.cancel();
                  _timer = null;
                  _timer = Timer(Duration(milliseconds: 500), () {
                    if (info.visibleFraction >= 0.6) {
                      _setupController();
                    } else {
                      _freeController();
                    }
                  });
                  return;
                }
                if (info.visibleFraction >= 0.6) {
                  _setupController();
                } else {
                  _freeController();
                }
              },
              child: StreamBuilder<BetterPlayerController>(
                stream: betterPlayerControllerStreamController.stream,
                builder: (context, snapshot) {
                  return AspectRatio(
                    aspectRatio: 2 / 3,
                    child: controller != null
                        ? BetterPlayer(
                            controller: controller,
                          )
                        : Container(
                            color: Colors.black,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                  );
                },
              ),
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
                    widget.text,
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

  @override
  void deactivate() {
    if (controller != null) {
      videoListData.wasPlaying = controller.isPlaying();
    }
    _initialized = true;
    super.deactivate();
  }
}
