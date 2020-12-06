import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/artwork/review.dart';
import 'package:artCraftLiving/orderForm.dart';
import 'package:artCraftLiving/profiles/user_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';

ArtWorks singleartwork;

class UsersArtwork extends StatefulWidget {
  UsersArtwork({Key key}) : super(key: key);

  @override
  _UsersArtworkState createState() => _UsersArtworkState();
}

class _UsersArtworkState extends State<UsersArtwork> {
  bool review = false;
  bool orderLoading = false;

  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController postalCodeContoller = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Art Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
              child: Container(
                height: height / 2.5,
                width: width,
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
                      for (int i = 0;
                          i < listArtWorkDetail[artworkIndex].pics.length;
                          i++)
                        Container(
                          child: CachedNetworkImage(
                            // height: 200,
                            fit: BoxFit.cover,
                            imageUrl: listArtWorkDetail[artworkIndex].pics[i],
                            placeholder: (context, url) =>
                                Center(child: new CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            if (listArtWorkDetail[artworkIndex].userUid != userDetails.userUid)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    onPressed: () {
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
                        buyerdocId: listArtWorkDetail[artworkIndex].buyerdocId,
                        buyeruserUid:
                            listArtWorkDetail[artworkIndex].buyeruserUid,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentScreen()),
                      );
                    },
                    child: Text("Review"),
                    color: Colors.black,
                    textColor: Colors.white,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    onPressed: () {
                      if (!listArtWorkDetail[artworkIndex].sold)
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Text("Price: "),
                                    Text(
                                      "100",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40),
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
                                content: Text("You want to buy this art?"),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                  FlatButton(
                                      onPressed: () {
                                        if (int.parse(userDetails.points) <
                                            100) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "You donot have enough Point",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderForm()),
                                          );
                                        }
                                      },
                                      child: Text(
                                        'Buy',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ))
                                ],
                              );
                            });
                    },
                    child: Container(
                        child: listArtWorkDetail[artworkIndex].sold
                            ? Text("Sold")
                            : Text("Purchase")),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
            review
                ? Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: EdgeInsets.only(),
                        decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.black)),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelStyle:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              border: InputBorder.none,
                              //labelText: 'Review',
                              hintText: 'Write a Review'),
                        ),
                      ),
                    ))
                : Container(),
            SizedBox(height: 30),
            ListTile(
              title: Text('Title'),
              subtitle: Text(listArtWorkDetail[artworkIndex].tittle),
            ),
            ListTile(
              title: Text('Price'),
              subtitle: Text(listArtWorkDetail[artworkIndex].price),
              trailing: Text('Size: ' + listArtWorkDetail[artworkIndex].size),
            ),
            // ListTile(
            //   title: Text('Size'),
            //   subtitle: Text('Size'),
            // ),
            ListTile(
              title: Text('Technique'),
              subtitle: Text(listArtWorkDetail[artworkIndex].technique),
              trailing: Text('Year: ' + listArtWorkDetail[artworkIndex].year),
            ),
            // ListTile(
            //   title: Text('Year'),
            //   subtitle: Text('Year'),
            // ),
            ListTile(
              title: Text('About Art'),
              subtitle: Text(listArtWorkDetail[artworkIndex].aboutArt),
            ),
          ],
        ),
      ),
    );
  }
}
