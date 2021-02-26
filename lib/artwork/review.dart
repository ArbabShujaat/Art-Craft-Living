// import 'package:flutter/material.dart';
import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/artwork/users.artwork.dart';
import 'package:artCraftLiving/profiles/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import "dart:async";
import 'package:intl/intl.dart';

// import "main.dart"; //for current user

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool didFetchComments = false;
  String articelId = "";
  int commentsCount;
  bool _loading = false;
  List<Comment> fetchedComments = [];

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: Text(
          "Comments",
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Colors.white,
      ),
      body: Container(child: buildPage()),
    );
  }

  Widget buildPage() {
    return Column(
      children: [
        Expanded(
          child: buildComments(),
        ),
        Divider(),
        Container(
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListTile(
                  title: TextFormField(
                    cursorColor: Colors.blue,
                    controller: _commentController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: 'Write a comment...',
                        fillColor: Colors.blue,
                        focusColor: Colors.blue),
                    // onFieldSubmitted: addComment,
                  ),
                  trailing: OutlineButton(
                    onPressed: () {
                      setState(() {
                        _loading = true;
                      });
                      addComment(_commentController.text);
                    },
                    borderSide: BorderSide.none,
                    child: Text("Post"),
                  ),
                ),
        ),
      ],
    );
  }

  Widget buildComments() {
    if (this.didFetchComments == false) {
      return FutureBuilder<List<Comment>>(
          future: getComments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator());

            this.didFetchComments = true;
            this.fetchedComments = snapshot.data;
            return ListView(
              children: snapshot.data,
            );
          });
    } else {
      // for optimistic updating
      return ListView(children: this.fetchedComments);
    }
  }

  Future<List<Comment>> getComments() async {
    List<Comment> comments = [];

    try {
      QuerySnapshot data = await Firestore.instance
          .collection("ArtWork")
          .document(singleartwork.docId)
          .collection("reviews")
          .orderBy('time')
          .getDocuments();
      data.documents.forEach((DocumentSnapshot doc) {
        comments.add(Comment.fromDocument(doc));
      });
    } catch (e) {
      print(e);
    }
    print("Done");
    return comments;
  }

  /////add commment////
  addComment(String comment) async {
    _commentController.clear();
    print('hiiiiii2');

    print(artworkIndex);

    await FirebaseFirestore.instance
        .collection("ArtWork")
        .document(singleartwork.docId)
        .collection("reviews")
        .add({
      "userName": userDetails.username,
      "userUid": userDetails.userUid,
      "userImage": userDetails.userpic,
      "userdocid": userDetails.userDocid,
      "userComment": comment,
      'time': DateTime.now().toString()
    });
//reviewed
    String points = '';
    await FirebaseFirestore.instance
        .collection('Users')
        .document(userDetails.userDocid)
        .collection("ReviewedUsers")
        .where('userDocid', isEqualTo: singleartwork.userDocid)
        .getDocuments()
        .then((value) async => {
              if (value.documents.length == 0)
                {
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .document(userDetails.userDocid)
                      .collection("ReviewedUsers")
                      .add({
                    'userUid': singleartwork.userUid,
                    'userDocid': singleartwork.userDocid,
                  }),

                  await FirebaseFirestore.instance
                      .collection('Users')
                      .where("userUid", isEqualTo: singleartwork.userUid)
                      .getDocuments()
                      .then((value) => {points = value.documents[0]["points"]}),
                  //     .update({
                  //   "points": (int.parse(singleartwork.points) + 1).toString()
                  // }

                  await FirebaseFirestore.instance
                      .collection('Users')
                      .document(singleartwork.userDocid)
                      .update({"points": (int.parse(points) + 1).toString()}),
                }
            });

    // userDetails.points = (int.parse(userDetails.points) + 1).toString();

    ///supporters

    await FirebaseFirestore.instance
        .collection('Users')
        .document(singleartwork.userDocid)
        .collection("Supporters")
        .where('userDocid', isEqualTo: userDetails.userDocid)
        .getDocuments()
        .then((value) async => {
              if (value.documents.length == 0)
                {
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .document(singleartwork.userDocid)
                      .collection("Supporters")
                      .add({
                    'userUid': userDetails.userUid,
                    'userDocid': userDetails.userDocid,
                  })
                }
            });

    // add comment to the current listview for an optimistic update

    setState(() {
      _loading = false;
      fetchedComments = List.from(fetchedComments)
        ..add(Comment(
            username: userDetails.username,
            comment: comment,
            timestamp: DateTime.now().toString(),
            avatarUrl: userDetails.userpic,
            userId: userDetails.userUid));
    });
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final String timestamp;

  Comment(
      {this.username,
      this.userId,
      this.avatarUrl,
      this.comment,
      this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot document) {
    return Comment(
      username: document['userName'],
      userId: document['userUid'],
      comment: document["userComment"],
      avatarUrl: document["userImage"],
      timestamp: document["time"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(avatarUrl),
                  )),
            ),
            SizedBox(
              width: 20.0,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10.0),
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 200,
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                            Text(
                              "  .  ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                            Text(
                              DateFormat('EEE, M/d/y')
                                  .format(DateTime.parse(timestamp)),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            comment,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}
