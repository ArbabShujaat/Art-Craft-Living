import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/home_screen.dart';
import 'package:artCraftLiving/profiles/my_gallery.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailgun/mailgun.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';

class PaymentProofScreenSold extends StatefulWidget {
  @override
  _PaymentProofScreenSoldState createState() => _PaymentProofScreenSoldState();
}

class _PaymentProofScreenSoldState extends State<PaymentProofScreenSold> {
  //multi image picker
  List<Asset> images = List<Asset>();
  List imagesDisplay = [];
  bool firstTime = true;

  List<String> imageUrls = <String>[];
  bool upoadingLoading = false;
  String _error = 'No Error Dectected';

  TextEditingController accountLinkController = TextEditingController();
  TextEditingController artpriceController = TextEditingController();

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
        maxImages: 300,
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
      if (resultList.isNotEmpty) firstTime = false;
    });
  }

  var mailgun = MailgunMailer(
      domain: "sandbox1a835de893dd48d6afcce2875c8ab3e9.mailgun.org",
      apiKey: "bf0a0230d39183d5d286d45836724e68-ba042922-7b8b3ca3");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Upload Proof of Delivered artwork',
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
            //Center(child: Text('Error: $_error')),
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
                  //SizedBox(height: 30),
                  //buildGridView(),
                  SizedBox(height: 30),
                  _input('Paste your paypal account link *',
                      accountLinkController),
                  _input('Price of your sold art Work *', artpriceController),
                  // _input('Price *', priceController),
                  // _input('Size *', sizeController),
                  // _input('Technique *', techniqueController),
                  // _input('Year *', yearContoller),
                  // _input('About Art ', aboutartContoller),
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
                              'Get Paid',
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
              .collection("PaymentRequestsSold")
              .add({
            'paypalAccount': accountLinkController.text,
            'userUid': userDetails.userUid,
            'userDocid': userDetails.userDocid,
            'imageUrls': imageUrls,
            'amount': artpriceController.text,
            'time': DateTime.now().toString(),
            'accepted': false,
          });

          String emailBody = "Payment Requests for Purchased art: " +
              "\nCustomerName : " +
              userDetails.username +
              "\n\nCustomerEmail : " +
              userDetails.userEmail +
              "\n\nCustomerPic : " +
              userDetails.userpic +
              "\n\nAmount to be paid : " +
              artpriceController.text +
              "\n\nProof Pic : " +
              imageUrls[0] +
              "\n\nPaypalAccountLink : " +
              accountLinkController.text;

          final Email email = Email(
            body: emailBody,
            subject: 'Payment Requests for Sold art',
            recipients: ['info@artcraftliving.com'],
            isHTML: false,
          );
          await FlutterEmailSender.send(email);

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
            'soldCredit': (int.parse(userDetails.soldCredit) -
                    int.parse(artpriceController.text))
                .toString(),
          });

          userDetails.soldCredit = (int.parse(userDetails.soldCredit) -
                  int.parse(artpriceController.text))
              .toString();
          Navigator.pop(context);
          Navigator.pop(context);

          print(4);
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
    //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: TextFormField(
      controller: controller,
      validator: (String val) {
        if (val.trim().isEmpty) {
          return label + " must not be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        //prefixIcon: Icon(icon, color: Colors.blue,),
        labelStyle: TextStyle(fontSize: 16, color: Colors.black),
        border: InputBorder.none,
        labelText: label,
      ),
    ),
  );
}
