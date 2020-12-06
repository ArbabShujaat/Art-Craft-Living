import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Model/model.dart';

int userIndex = 0;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  @override
  Future<void> didChangeDependencies() async {
    listUserDetail.clear();
    await FirebaseFirestore.instance
        .collection("Users")

        // ignore: deprecated_member_use
        .getDocuments()
        .then((value) => {
              for (int i = 0; i < value.documents.length; i++)
                {
                  if (value.documents[i]["userUid"] != userDetails.userUid)
                    {
                      listUserDetail.add(UserDetails(
                        instagram: value.documents[0]["instagram"],
                        about: value.documents[i]["userAbout"],
                        userEmail: value.documents[i]["userEmail"],
                        bonusCredit: value.documents[i]["bonusCredit"],
                        soldCredit: value.documents[i]["soldCredit"],
                        points: value.documents[i]["points"],
                        userUid: value.documents[i]["userUid"],
                        username: value.documents[i]["userName"],
                        userpic: value.documents[i]["userImage"],
                        userDocid: value.documents[i].documentID,
                      ))
                    }
                }
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
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
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
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: listUserDetail.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          userIndex = index;
                          Navigator.pushNamed(context, USER_PROFILE);
                        },
                        child: member(
                            listUserDetail[index].userpic,
                            listUserDetail[index].username,
                            listUserDetail[index].about,
                            USER_PROFILE,
                            context),
                      ),
                      Divider(),
                    ],
                  );
                }),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blue,
        ),
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              SizedBox(height: 30),
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(
                  userDetails.username,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                accountEmail: Text(
                  userDetails.userEmail,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(userDetails.userpic),
                ),
              ),
              drawerData('My Gallery', MY_GALLERY, context),
              drawerData('Collected Points', COLLECTED_POINTS, context),
              drawerData('Community Sales', COMMUNITY_SALE, context),
              drawerData('Purchased Artworks', PURCHASED, context),
              drawerData('Sold Artworks', MYSOLD, context),
              drawerData('Payments', PAYMENT, context),
              drawerData('My Supporters', MY_SUPPOERTERS, context),
              drawerData('Exhibitions', EXHIBITION, context),
              drawerData('Help', HELP, context),
              SizedBox(
                height: 20,
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
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget drawerData(String title, String routeName, BuildContext context) {
  return ListTile(
    dense: true,
    visualDensity: VisualDensity(horizontal: 0, vertical: -0.3),
    // leading: Image(
    //   image: AssetImage(iconimage),
    //   width: 40,
    //   height: 40,
    // ),
    title: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
  );
}

Widget member(String img, String username, String about, String routeName,
    BuildContext context) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.grey[200],
      backgroundImage: NetworkImage(img),
      radius: 25,
    ),
    title: Text(
      username,
      style: TextStyle(fontSize: 17),
    ),
    subtitle: Text(
      about,
      maxLines: 1,
    ),
    // onTap: () {

    // },
  );
}
