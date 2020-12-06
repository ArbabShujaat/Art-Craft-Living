import 'dart:convert';

import 'package:artCraftLiving/Admin/Home.dart';
import 'package:artCraftLiving/Admin/SoldPaymentRequests.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/home_screen.dart';
import 'package:artCraftLiving/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'Model/model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    Timer(const Duration(milliseconds: 2000), () async {
      var prefs = await SharedPreferences.getInstance();

      await FirebaseFirestore.instance
          .collection("BonusAmount")

          // ignore: deprecated_member_use
          .getDocuments()
          .then((value) => {
                bonusAmount = value.documents[0]["amount"],
              });

      await FirebaseFirestore.instance
          .collection("AdminCredentials")

          // ignore: deprecated_member_use
          .getDocuments()
          .then((value) => {
                adminEmail = value.documents[0]["Email"],
                adminPassword = value.documents[0]["Password"],
              });

      if (!prefs.containsKey("userData")) {
        if (prefs.containsKey("AdminData")) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
        } else
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LogIn()),
          );
      } else {
        final extractedUserData =
            json.decode(prefs.getString('userData')) as Map<String, Object>;
        // userEmail = extractedUserData['userEmail'];
        // userUid = extractedUserData['userUid'];
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
                    userUid: value.documents[0]["userUid"],
                    username: value.documents[0]["userName"],
                    userpic: value.documents[0]["userImage"],
                    userDocid: value.documents[0].documentID,
                  )
                });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 200),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Image.asset(
                "assets/logo.jpeg",
                height: 250,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Supporting artists'),
          Text('Finding a home for your art'),
          Text('Connecting artists with supporters'),
        ],
      ),
    );
  }
}
