import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/artwork/users.artwork.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/profiles/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailgun/mailgun.dart';

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  bool orderLoading = false;

  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController postalCodeContoller = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    singleartwork = ArtWorks(
      pics: listArtWorkDetail[artworkIndex].pics,
      tittle: listArtWorkDetail[artworkIndex].tittle,
      docId: listArtWorkDetail[artworkIndex].docId,
      size: listArtWorkDetail[artworkIndex].size,
      technique: listArtWorkDetail[artworkIndex].technique,
      year: listArtWorkDetail[artworkIndex].year,
      aboutArt: listArtWorkDetail[artworkIndex].aboutArt,
      userUid: listArtWorkDetail[artworkIndex].userUid,
      userDocid: listArtWorkDetail[artworkIndex].userDocid,
      price: listArtWorkDetail[artworkIndex].price,
      sold: listArtWorkDetail[artworkIndex].sold,
      buyeruserUid: listArtWorkDetail[artworkIndex].buyeruserUid,
      buyerdocId: listArtWorkDetail[artworkIndex].buyerdocId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Your Adress"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _input('Country', countryController),
                _input('City/Town', cityController),
                _input('Street Number', streetController),
                _input('House Number', houseNumberController),
                _input('Postal code', postalCodeContoller),
                SizedBox(height: 10),
                Container(
                  child: orderLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            print("hiii");
                            if (_formKey.currentState.validate()) {
                              placeorder();
                            }
                            print("hiii");
                          },
                          child: Text('Purchase'),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController controller) {
    return Container(
      //height: 60,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)),
      ),

      child: TextFormField(
        validator: (String val) {
          if (val.trim().isEmpty) {
            return label + " cannot be empty";
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: InputBorder.none,
          labelText: label,
        ),
      ),
    );
  }

  Future<void> placeorder() async {
    setState(() {
      orderLoading = true;
    });
    print('1');
    await FirebaseFirestore.instance.collection("Orders").add({
      'ArtworkDocId': singleartwork.docId,
      'ArtworkUserDocId': singleartwork.userDocid,
      'ArtworkUserUid': singleartwork.userUid,
      'delivered': false,
      'country': countryController.text,
      'city': cityController.text,
      'street': streetController.text,
      'house': houseNumberController.text,
      'postalCode': postalCodeContoller.text,
    });
    UserDetails orderUserDetaisl;
    await FirebaseFirestore.instance
        .collection("Users")
        .where("userUid", isEqualTo: singleartwork.userUid)
        .getDocuments()
        .then((value) => {
              orderUserDetaisl = UserDetails(
                instagram: value.documents[0]["instagram"],
                about: value.documents[0]["userAbout"],
                verified: value.documents[0]["verified"],
                firstTime: value.documents[0]["firstTime"],
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

    String emailBody = "Order: " +
        "\n\n\nCustomer Details: " +
        "n\nCustomerName : " +
        userDetails.username +
        "\n\nCustomerEmail : " +
        userDetails.userEmail +
        "\n\nCustomerPic : " +
        userDetails.userpic +
        "\n\nAddress : " +
        countryController.text +
        cityController.text +
        streetController.text +
        houseNumberController.text +
        postalCodeContoller.text +
        "\n\n\n\nArtWork Details: " +
        "\n\nArtwork Title: " +
        singleartwork.tittle +
        "\n\nArt Work Price : " +
        singleartwork.price +
        "\n\nArt Work Pic : " +
        singleartwork.pics[0];

    List<String> a = [userDetails.userEmail];
    // List<String> a = ["artcraftliving4@gmail.com"];

    final Email email = Email(
      body: emailBody,
      subject: 'Art Craft Living App Order',
      recipients: [orderUserDetaisl.userEmail],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);

    print('2');
    await FirebaseFirestore.instance
        .collection('Users')
        .document(userDetails.userDocid)
        .update({
      'bonusCredit':
          (int.parse(userDetails.bonusCredit) + int.parse(bonusAmount))
              .toString(),
      'points': (int.parse(userDetails.points) - 100).toString(),
    });
    userDetails.points = (int.parse(userDetails.points) - 100).toString();
    userDetails.bonusCredit =
        (int.parse(userDetails.bonusCredit) + int.parse(bonusAmount))
            .toString();
    print('3');
    String oldSoldcredit = '0';
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userUid', isEqualTo: singleartwork.userUid)
        .getDocuments()
        .then((value) async => {
              print('4'),
              print(singleartwork.userDocid),
              print(value.documents[0]['soldCredit']),
              oldSoldcredit = value.documents[0]['soldCredit'],
              print('5'),
            });
    await FirebaseFirestore.instance
        .collection('Users')
        .document(singleartwork.userDocid)
        .update({
      'soldCredit':
          (int.parse(oldSoldcredit) + int.parse(singleartwork.price)).toString()
    });
    await FirebaseFirestore.instance
        .collection('ArtWork')
        .document(singleartwork.docId)
        .update({
      'sold': true,
      'buyerUid': userDetails.userUid,
      'buyerdocId': userDetails.userDocid
    });
    print('6');
    setState(() {
      orderLoading = false;
    });
    Fluttertoast.showToast(
        msg: "Your order will be delivered soon",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
