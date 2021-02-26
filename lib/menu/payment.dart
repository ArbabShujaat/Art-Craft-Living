import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/PaymentProofScreenPurchased.dart';
import 'package:artCraftLiving/PaymentProofScreenSold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Payment extends StatefulWidget {
  Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Payment',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Column(
                children: [
                  TabBar(
                    //indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Purchased'),
                      Tab(text: 'Sold'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '*To get paid for your bonuses, please click on the Get Paid button and follow the instructions. You will need to upload a photo of the received artwork hanging on a wall in its new home. You will also need to send us your PayPalme link in order for us to pay you your bonus. If you don’t have a PayPal account yet, you can open one first by visiting the PayPal website. ',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Bonuses',
                          style: TextStyle(fontSize: 22),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 5))
                              ]),
                          width: 60,
                          height: 60,
                          child: Center(
                              child: Text(userDetails.bonusCredit,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("Users")
                              .where("userEmail",
                                  isEqualTo: userDetails.userEmail)

                              // ignore: deprecated_member_use
                              .getDocuments()
                              .then((value) => {
                                    userDetails = UserDetails(
                                      instagram: value.documents[0]
                                          ["instagram"],
                                      about: value.documents[0]["userAbout"],
                                      userEmail: value.documents[0]
                                          ["userEmail"],
                                      bonusCredit: value.documents[0]
                                          ["bonusCredit"],
                                      soldCredit: value.documents[0]
                                          ["soldCredit"],
                                      points: value.documents[0]["points"],
                                      verified: value.documents[0]["verified"],
                                      firstTime: value.documents[0]
                                          ["firstTime"],
                                      userUid: value.documents[0]["userUid"],
                                      username: value.documents[0]["userName"],
                                      userpic: value.documents[0]["userImage"],
                                      userDocid: value.documents[0].documentID,
                                    )
                                  });

                          if (int.parse(userDetails.bonusCredit) > 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentProofScreenPuchased()),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "You donot have enough Bonuses",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Text(
                          'Get Paid',
                          style: TextStyle(fontSize: 18),
                        ),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              '*To get paid for your sold artworks, please click on the Get Paid button and follow the instructions. You will need to upload a screenshot of the delivery confirmation (a confirmation that the collector received the artwork). You will also need to send us your PayPalme link in order for us to pay you. If you don’t have a PayPal account yet, you can open one first by visiting the PayPal website.',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Payment',
                                style: TextStyle(fontSize: 22),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[300],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: Offset(0, 5))
                                    ]),
                                width: 60,
                                height: 60,
                                child: Center(
                                    child: Text(userDetails.soldCredit,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("Users")
                                    .where("userEmail",
                                        isEqualTo: userDetails.userEmail)

                                    // ignore: deprecated_member_use
                                    .getDocuments()
                                    .then((value) => {
                                          userDetails = UserDetails(
                                            instagram: value.documents[0]
                                                ["instagram"],
                                            about: value.documents[0]
                                                ["userAbout"],
                                            verified: value.documents[0]
                                                ["verified"],
                                            firstTime: value.documents[0]
                                                ["firstTime"],
                                            userEmail: value.documents[0]
                                                ["userEmail"],
                                            bonusCredit: value.documents[0]
                                                ["bonusCredit"],
                                            soldCredit: value.documents[0]
                                                ["soldCredit"],
                                            points: value.documents[0]
                                                ["points"],
                                            userUid: value.documents[0]
                                                ["userUid"],
                                            username: value.documents[0]
                                                ["userName"],
                                            userpic: value.documents[0]
                                                ["userImage"],
                                            userDocid:
                                                value.documents[0].documentID,
                                          )
                                        });

                                if (int.parse(userDetails.soldCredit) > 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentProofScreenSold()),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "You donot have enough Bonuses",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Text(
                                'Get Paid',
                                style: TextStyle(fontSize: 18),
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget mainImage(
    Image image, String text, String routeName, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
    child: Container(
      child: Stack(
        children: [
          Container(child: image),
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )),
        ],
      ),
    ),
  );
}
