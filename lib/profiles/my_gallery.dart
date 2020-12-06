import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/profiles/edit_Profile.dart';
import 'package:artCraftLiving/profiles/user_profile.dart';
import 'package:artCraftLiving/uplaod_art.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyGallery extends StatefulWidget {
  MyGallery({Key key}) : super(key: key);

  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  bool _loading = true;
  bool _showabout = false;
  @override
  Future<void> didChangeDependencies() async {
    listArtWorkDetail.clear();
    await FirebaseFirestore.instance
        .collection("ArtWork")
        .where('userUid', isEqualTo: userDetails.userUid)

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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'My Gallery',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(userDetails.userpic),
                      radius: 40,
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userDetails.username,
                          style: TextStyle(fontSize: 22),
                        ),
                        if (_showabout)
                          Column(
                            children: [
                              SingleChildScrollView(
                                child: Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    height: 100,
                                    child: AutoSizeText(
                                      userDetails.about,
                                      style: TextStyle(fontSize: 18.0),
                                      maxLines: 100,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _showabout = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'See less',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        if (!_showabout)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 200,
                                child: Text(
                                  userDetails.about,
                                  maxLines: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _showabout = true;
                                  });
                                },
                                child: Text(
                                  'See more',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                  onPressed: () {
                    firstTimeForedit = false;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit Profile'),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 30),
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: _loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            itemCount: listArtWorkDetail.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                child: _art(
                                    listArtWorkDetail[index].pics[0],
                                    USERS_ARTWORK,
                                    context,
                                    listArtWorkDetail[index].sold),
                              );
                            },
                          )),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firstTimeForartWork = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UploadArt()));
        },
        child: Icon(Icons.art_track_sharp),
      ),
    );
  }

  Widget _art(String image, String routeName, BuildContext context, bool sold) {
    return Stack(
      children: [
        Center(
          child: Container(
            child: CachedNetworkImage(
              height: 200,
              fit: BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) =>
                  Center(child: new CircularProgressIndicator()),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ),
        if (sold)
          Center(
              child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "SOLD",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ))
      ],
    );
  }
}
