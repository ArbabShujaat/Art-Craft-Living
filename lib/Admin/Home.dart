import 'package:artCraftLiving/Admin/BonusPaymentRequest.dart';
import 'package:artCraftLiving/Admin/FAQSadd.dart';
import 'package:artCraftLiving/Admin/FAQsedit.dart';
import 'package:artCraftLiving/Admin/SoldPaymentRequests.dart';
import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AdminPannel"),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SoldPaymentRequests()),
                  );
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Payments requests of sellers",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BonusPaymentRequest()),
                  );
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Payments requests of Buyers",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () async {
                  faqsList.clear();
                  await FirebaseFirestore.instance
                      .collection("FAQs")

                      // ignore: deprecated_member_use
                      .getDocuments()
                      .then((value) => {
                            for (int i = 0; i < value.documents.length; i++)
                              faqsList.add(FAQs(
                                question: value.documents[i]["Question"],
                                answer: value.documents[i]["Answer"],
                                docid: value.documents[i].documentID,
                              ))
                          });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQsEdit()),
                  );
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "FAQs Edit",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQsadd()),
                  );
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "FAQs Add",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.black,
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  var prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LogIn()),
                      (Route<dynamic> route) => false);
                },
                elevation: 3,
                child: Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
