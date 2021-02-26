import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'dart:async';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/mailgun.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PaymentProofScreenPuchased extends StatefulWidget {
  @override
  _PaymentProofScreenPuchasedState createState() =>
      _PaymentProofScreenPuchasedState();
}

class _PaymentProofScreenPuchasedState
    extends State<PaymentProofScreenPuchased> {
  //multi image picker
  List<Asset> images = List<Asset>();
  List imagesDisplay = [];
  bool firstTime = true;
  List<String> imageUrls = <String>[];
  bool upoadingLoading = false;
  String _error = 'No Error Dectected';

  TextEditingController tittleController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          quality: 40,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Art Craft Living",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
      if (resultList.isNotEmpty) firstTime = false;
    });
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
          'Upload Proof of purchased artwork',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: ListView(
          children: [
            SizedBox(height: 30),
            SizedBox(height: 15),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      child: firstTime
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: Offset(0, 5))
                                  ]),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                                size: 40,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, top: 6),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Carousel(
                                    overlayShadow: false,
                                    dotBgColor: Colors.transparent,
                                    autoplay: false,
                                    dotIncreaseSize: 3,
                                    dotSize: 5,
                                    // dotSpacing: 30,

                                    dotIncreasedColor: Colors.white,
                                    dotColor: Colors.black,
                                    images: [
                                      for (int i = 0; i < images.length; i++)
                                        AssetThumb(
                                          asset: images[i],
                                          width: 300,
                                          height: 300,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                    onTap: loadAssets,
                  ),
                  SizedBox(height: 30),
                  _input('Past your paypal account link *', tittleController),
                  SizedBox(height: 20),
                  Container(
                    child: upoadingLoading
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
                              'Upload',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                getPayment();
                              }
                            },
                          ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPayment() async {
    setState(() {
      upoadingLoading = true;
    });

    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) async {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          await Firebase.initializeApp();
          await FirebaseFirestore.instance
              .collection("PaymentRequestsPurchased")
              .add({
            'paypalAccount': tittleController.text,
            'userUid': userDetails.userUid,
            'userDocid': userDetails.userDocid,
            'imageUrls': imageUrls,
            'amount': bonusAmount,
            'time': DateTime.now().toString(),
            'accepted': false
          });
          String emailBody = "Payment Requests for Purchased art: " +
              "\nCustomerName : " +
              userDetails.username +
              "\n\nCustomerEmail : " +
              userDetails.userEmail +
              "\n\nCustomerPic : " +
              userDetails.userpic +
              "\n\nAmount to be paid : " +
              bonusAmount +
              "\n\nProof Pic : " +
              imageUrls[0] +
              "\n\nPaypalAccountLink : " +
              tittleController.text;

          final Email email = Email(
            body: emailBody,
            subject: 'Payment Requests for Purchased art',
            recipients: ['info@artcraftliving.com'],
            isHTML: false,
          );

          await FlutterEmailSender.send(email).catchError((e) {
            print(e);
          });

          Fluttertoast.showToast(
              msg:
                  "Our Team is reviewing your request you will get your payment soon.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 8,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          await FirebaseFirestore.instance
              .collection('Users')
              .document(userDetails.userDocid)
              .update({
            'bonusCredit':
                (int.parse(userDetails.bonusCredit) - int.parse(bonusAmount))
                    .toString(),
          });

          userDetails.bonusCredit =
              (int.parse(userDetails.bonusCredit) - int.parse(bonusAmount))
                  .toString();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }
}

Widget _input(String label, controller) {
  return Container(
    //height: 60,
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.black)),
    ),

    child: TextFormField(
      controller: controller,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return label + " must not be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 16, color: Colors.black),
        border: InputBorder.none,
        labelText: label,
      ),
    ),
  );
}
