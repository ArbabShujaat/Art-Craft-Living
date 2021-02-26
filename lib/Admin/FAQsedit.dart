import 'package:artCraftLiving/Admin/Home.dart';
import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/home_screen.dart';
import 'package:artCraftLiving/profiles/after_signup.dart';
import 'package:artCraftLiving/profiles/my_gallery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FAQsEdit extends StatefulWidget {
  FAQsEdit({Key key}) : super(key: key);

  @override
  _FAQsEditState createState() => _FAQsEditState();
}

class _FAQsEditState extends State<FAQsEdit> {
  //hide password
  bool _showPassword = false;

  File _image;
  bool signupLoading = false;
  double _height;
  double _width;

  List<bool> faqA = [];

  List<bool> faqQ = [];

  List<TextEditingController> faqa = [];

  List<TextEditingController> faqq = [];

  bool _loading = true;
  @override
  Future<void> didChangeDependencies() async {
    for (int i = 0; i < faqsList.length; i++) {
      faqq.add(TextEditingController());
      faqa.add(TextEditingController());
      faqA.add(false);
      faqQ.add(false);
    }

    setState(() {
      _loading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'FAQS',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    ListView.builder(
                        itemCount: faqsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black)),
                                    ),
                                    child: TextFormField(
                                      maxLines: 10,
                                      minLines: 1,
                                      controller: faqq[index],
                                      onChanged: (e) {
                                        setState(() {
                                          faqQ[index] = true;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                          suffixIcon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          border: InputBorder.none,
                                          hintText: faqsList[index].question),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black)),
                                    ),
                                    child: TextFormField(
                                      maxLines: 10,
                                      minLines: 1,
                                      controller: faqa[index],
                                      onChanged: (e) {
                                        setState(() {
                                          faqA[index] = true;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          border: InputBorder.none,
                                          hintText: faqsList[index].answer),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(height: 30),
                    Positioned(
                      bottom: 10,
                      left: 90,
                      child: Container(
                        child: signupLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : RaisedButton(
                                padding: EdgeInsets.fromLTRB(80, 2, 80, 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Text(
                                  'Update',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: () {
                                  update();
                                },
                              ),
                      ),
                    )
                  ],
                )),
    );
  }

  Future<void> update() async {
    setState(() {
      signupLoading = true;
    });

    print(1);

    Firebase.initializeApp();

    for (int i = 0; i < faqsList.length; i++) {
      if (faqQ[i]) {
        await FirebaseFirestore.instance
            .collection("FAQs")
            .document(faqsList[i].docid)
            .update({
          'Question': faqq[i].text,
        });
      }
      if (faqA[i]) {
        await FirebaseFirestore.instance
            .collection("FAQs")
            .document(faqsList[i].docid)
            .update({
          'Answer': faqa[i].text,
        });
      }
    }

    setState(() {
      signupLoading = false;
    });
    Navigator.pop(context);

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => AdminHome()));
  }
}
