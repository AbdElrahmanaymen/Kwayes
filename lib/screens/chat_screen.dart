import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId, myUser;
  ChatScreen({@required this.chatRoomId, @required this.myUser});
  @override
  _ChatScreenState createState() =>
      _ChatScreenState(chatRoomId: chatRoomId, myUser: myUser);
}

addConversationMessages(String chatRoomId, messageMap) {
  FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .collection('chats')
      .add(messageMap);
}

getChatRoom(String chatRoomId) {
  return FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .snapshots();
}

getConversationMessages(String chatRoomId) {
  return FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .collection('chats')
      .orderBy('time')
      .snapshots();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatRoomId, myUser;
  _ChatScreenState({@required this.chatRoomId, @required this.myUser});

  TextEditingController messageController = new TextEditingController();
  Stream chatMessagesStream;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot> loadMyInfo(String email) {
    return _firestore.collection('users').doc(email).snapshots();
  }

  Widget chatMessagesList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final Timestamp timestamp =
                      snapshot.data.docs[index]["time"] as Timestamp;
                  final DateTime dateTime = timestamp.toDate();
                  return MessageTile(
                      snapshot.data.docs[index]["message"],
                      snapshot.data.docs[index]["sendBy"] == myUser,
                      snapshot.data.docs[index]["name"],
                      dateTime,
                      snapshot.data.docs[index]["userPhoto"]);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() async {
    if (messageController.text.isNotEmpty) {
      String username;
      String photo;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myUser)
          .get()
<<<<<<< HEAD
          .then((DocumentSnapshot documentSnapshot) {
        var data = documentSnapshot.data() as Map;
        username = data['Name'];
        photo = data['photo_url'];
      });
=======
          .then((DocumentSnapshot documentSnapshot) => {
                username = documentSnapshot.data()['Name'],
                photo = documentSnapshot.data()['photo_url']
              });
>>>>>>> 728352692394a5334eb2908d623c6819ff7c48ec
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": myUser,
        "time": DateTime.now(),
        'name': username,
        'userPhoto': photo
      };
      addConversationMessages(chatRoomId, messageMap);
      messageController.text = '';
      scolldown();
      // String tempPhoneNumber =
      //     chatRoomId.toString().replaceAll("_", "").replaceAll(myUser, "");
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(tempPhoneNumber)
      //     .collection('Notifications')
      //     .doc()
      //     .set({
      //   "message": "لقد تلقيت رسالة جديده من" + " " + username,
      //   'date': DateTime.now().microsecondsSinceEpoch,
      //   'type': 'message',
      //   'docId': chatRoomId
      // });
    }
  }

  final ScrollController _scrollController = ScrollController();

  void scolldown() {
    Timer(
        Duration(seconds: 1),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
  }

  @override
  void initState() {
    Timer(
        Duration(seconds: 1),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFBFBFB),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: getChatRoom(chatRoomId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
<<<<<<< HEAD
                      var data = snapshot.data.data() as Map;

                      String user = data['chatRoomId']
=======
                      String user = snapshot.data
                          .data()['chatRoomId']
>>>>>>> 728352692394a5334eb2908d623c6819ff7c48ec
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(myUser, "");
                      return StreamBuilder<DocumentSnapshot>(
                        stream: loadMyInfo(user),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
<<<<<<< HEAD
                          var data = snapshot.data.data() as Map;

                          String name = data['Name'];
                          String photoUrl = data['photo_url'];
=======
                          String name = snapshot.data.data()['Name'];
                          String photoUrl = snapshot.data.data()['photo_url'];
>>>>>>> 728352692394a5334eb2908d623c6819ff7c48ec
                          return Container(
                            width: 206,
                            height: 61,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        112, 107, 107, 0.23999999463558197),
                                    offset: Offset(0, 4),
                                    blurRadius: 16)
                              ],
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                    left: 93,
                                    child: Container(
                                      width: 128,
                                      height: 61,
                                      child: Center(
                                        child: Text(
                                          name,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                112, 107, 107, 1),
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )),
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                        width: 78,
                                        height: 61,
                                        child: Container(
                                            width: 78,
                                            height: 61,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                                bottomLeft: Radius.circular(16),
                                                bottomRight:
                                                    Radius.circular(16),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(photoUrl),
                                                  fit: BoxFit.fitWidth),
                                            )))),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              Container(
                height: MediaQuery.of(context).size.height -
                    (141 + MediaQuery.of(context).padding.top),
                child: StreamBuilder<QuerySnapshot>(
                  stream: getConversationMessages(chatRoomId),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        final Timestamp timestamp =
                            snapshot.data.docs[index]["time"] as Timestamp;
                        final DateTime dateTime = timestamp.toDate();
                        return MessageTile(
                            snapshot.data.docs[index]["message"],
                            snapshot.data.docs[index]["sendBy"] == myUser,
                            snapshot.data.docs[index]["name"],
                            dateTime,
                            snapshot.data.docs[index]["userPhoto"]);
                      },
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 67,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.07000000029802322),
                          offset: Offset(0, -4),
                          blurRadius: 10)
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 299,
                          child: TextField(
                            controller: messageController,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: Color(0xFF716B6B),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 25),
                                hintText: "Type a message…",
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: Color(0xFF716B6B),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFA3A3A3)),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFA3A3A3)),
                                  borderRadius: BorderRadius.circular(24),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SwipeTo(
                          onLeftSwipe: () {
                            print('nothin');
                          },
                          child: ClipOval(
                            child: Material(
                              color: Color(0xFFA229F2), // Button color
                              child: InkWell(
                                splashColor: Color(0xFFA3A3A3), // Splash color
                                onTap: () {
                                  if (messageController.text.isNotEmpty) {
                                    sendMessage();
                                  } else {}
                                },
                                child: SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Icon(
                                      (messageController.text.isEmpty)
                                          ? Icons.mic
                                          : Icons.send,
                                      // size: 18,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByME;
  final String sendBy;
  final DateTime dateTime;
  final String photoUrl;
  MessageTile(
      this.message, this.isSendByME, this.sendBy, this.dateTime, this.photoUrl);

  @override
  Widget build(BuildContext context) {
    int dateDays = DateTime.now().difference(dateTime).inDays;
    int dateHours = DateTime.now().difference(dateTime).inHours;
    int dateMins = DateTime.now().difference(dateTime).inMinutes;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      width: MediaQuery.of(context).size.width,
      alignment: (isSendByME) ? Alignment.centerRight : Alignment.centerLeft,
      child: (isSendByME)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: (isSendByME)
                                    ? [
                                        const Color(0xffA229F2),
                                        const Color(0xffA229F2)
                                      ]
                                    : [
                                        const Color(0xffA3A3A3),
                                        const Color(0xffA3A3A3)
                                      ]),
                            borderRadius: (isSendByME)
                                ? BorderRadius.circular(8)
                                : BorderRadius.circular(8)),
                        child: Text(
                          message,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      (dateDays != 0)
                          ? '$dateDays days ago'
                          : (dateHours != 0)
                              ? '$dateHours days ago'
                              : (dateMins != 0)
                                  ? '$dateMins mins ago'
                                  : 'just now',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFA3A3A3),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(photoUrl),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(photoUrl),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: (isSendByME)
                                    ? [
                                        const Color(0xffA229F2),
                                        const Color(0xffA229F2)
                                      ]
                                    : [
                                        const Color(0xffA3A3A3),
                                        const Color(0xffA3A3A3)
                                      ]),
                            borderRadius: (isSendByME)
                                ? BorderRadius.circular(8)
                                : BorderRadius.circular(8)),
                        child: Text(
                          message,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      (dateDays != 0)
                          ? '$dateDays days ago'
                          : (dateHours != 0)
                              ? '$dateHours days ago'
                              : (dateMins != 0)
                                  ? '$dateMins mins ago'
                                  : 'just now',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xFFA3A3A3),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
