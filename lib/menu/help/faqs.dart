import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Faqs extends StatefulWidget {
  Faqs({Key key}) : super(key: key);

  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  bool _loading = true;
  @override
  Future<void> didChangeDependencies() async {
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'FAQs',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  ListView.builder(
                    itemCount: faqsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            faqsList[index].question,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 2),
                          Text(
                            faqsList[index].answer,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          if (index + 1 == faqsList.length)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Contact Us',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'You couldn’t find an answer in our FAQ Section? Then please contact us here',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 2),
                                  GestureDetector(
                                    child: Text(
                                      'info@artcraftliving.com',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      customLaunch(
                                          'mailto:info@artcraftliving.com?subject=&body=');
                                    },
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
