import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/home_screen.dart';
import 'package:artCraftLiving/profiles/edit_Profile.dart';
import 'package:artCraftLiving/uplaod_art.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AfterSignup extends StatefulWidget {
  AfterSignup({Key key}) : super(key: key);

  @override
  _AfterSignupState createState() => _AfterSignupState();
}

class _AfterSignupState extends State<AfterSignup> {
  bool _showabout = false;
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
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(30),
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    children: [
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
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      height: 100,
                                      child: AutoSizeText(
                                        listUserDetail[userIndex].about,
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
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  height: 20,
                                  child: AutoSizeText(
                                    listUserDetail[userIndex].about,
                                    style: TextStyle(fontSize: 18.0),
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
                      firstTimeForedit = true;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit Profile'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 30),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    child: CircleAvatar(
                      //backgroundImage: AssetImage('assets/profile_picture.png'),
                      child: Icon(
                        Icons.photo,
                        size: 40,
                      ),
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                    ),
                    onTap: () {
                      firstTimeForartWork = true;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadArt()));
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Upload your first Artwork'),
                  SizedBox(height: 50),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(30, 2, 30, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: Colors.white,
                        textColor: Colors.blue,
                        child: Text(
                          'Upload your first Artwork',
                          style: TextStyle(fontSize: 17),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadArt()));
                        },
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(80, 2, 80, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Skip for later',
                          style: TextStyle(fontSize: 17),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
