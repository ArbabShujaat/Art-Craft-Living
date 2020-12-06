import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/profiles/user_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Purchased extends StatefulWidget {
  Purchased({Key key}) : super(key: key);

  @override
  _PurchasedState createState() => _PurchasedState();
}

class _PurchasedState extends State<Purchased> {
  bool _loading = true;
  @override
  Future<void> didChangeDependencies() async {
    listArtWorkDetail.clear();
    await FirebaseFirestore.instance
        .collection("ArtWork")
        .where("buyerdocId", isEqualTo: userDetails.userDocid)
        .where('sold', isEqualTo: true)

        // ignore: deprecated_member_use
        .getDocuments()
        .then((value) => {
              for (int i = 0; i < value.documents.length; i++)
                listArtWorkDetail.add(ArtWorks(
                  pics: value.documents[i]["imageUrls"],
                  tittle: value.documents[i]["tittle"],
                  technique: value.documents[i]["technique"],
                  docId: value.documents[i].documentID,
                  size: value.documents[i]["size"],
                  year: value.documents[i]["year"],
                  aboutArt: value.documents[i]["aboutArt"],
                  userUid: value.documents[i]["userUid"],
                  price: value.documents[i]["price"],
                  sold: value.documents[i]["sold"],
                  userDocid: value.documents[i].documentID,
                  buyeruserUid: value.documents[i]["buyerUid"],
                  buyerdocId: value.documents[i]["buyerdocId"],
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
        title: Text(
          'My Purchased Artworks',
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
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: listArtWorkDetail.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // mainAxisSpacing: 10,
                    crossAxisSpacing: 2,
                    // childAspectRatio: 0.6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        artworkIndex = index;
                        Navigator.pushNamed(context, USERS_ARTWORK);
                      },
                      child: _art(listArtWorkDetail[index].pics[0],
                          USERS_ARTWORK, context),
                    );
                  },
                )),
    );
  }
}

Widget _art(String image, String routeName, BuildContext context) {
  return Container(
    child: CachedNetworkImage(
      height: 200,
      fit: BoxFit.cover,
      imageUrl: image,
      placeholder: (context, url) =>
          Center(child: new CircularProgressIndicator()),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    ),
  );
}
