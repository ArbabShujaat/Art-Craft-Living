import 'dart:convert';

import 'package:artCraftLiving/Model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectedPoints extends StatefulWidget {
  CollectedPoints({Key key}) : super(key: key);

  @override
  _CollectedPointsState createState() => _CollectedPointsState();
}

class _CollectedPointsState extends State<CollectedPoints> {
  bool _isLoading = true;
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    var prefs = await SharedPreferences.getInstance();

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    await FirebaseFirestore.instance
        .collection("Users")
        .where("userEmail", isEqualTo: extractedUserData['userEmail'])

        // ignore: deprecated_member_use
        .getDocuments()
        .then((value) => {
              userDetails = UserDetails(
                instagram: value.documents[0]["instagram"],
                about: value.documents[0]["userAbout"],
                userEmail: value.documents[0]["userEmail"],
                bonusCredit: value.documents[0]["bonusCredit"],
                soldCredit: value.documents[0]["soldCredit"],
                points: value.documents[0]["points"],
                verified: value.documents[0]["verified"],
                firstTime: value.documents[0]["firstTime"],
                userUid: value.documents[0]["userUid"],
                username: value.documents[0]["userName"],
                userpic: value.documents[0]["userImage"],
                userDocid: value.documents[0].documentID,
              )
            });
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Collected Points',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(height: 15),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '*You receive one point for the first reviewed artwork of another user. Collect more points by reviewing more artists. Once you reach 100 points, you can purchase an artwork with the points.',
                          style: TextStyle(
                              color: Colors.blue,
                              // fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Your Points',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            userDetails.points,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 70),
                          ),
                          Text(
                            " points",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
