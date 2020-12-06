import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/profiles/after_signup.dart';
import 'package:artCraftLiving/profiles/my_gallery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //hide password
  bool _showPassword = false;

  File _image;
  bool signupLoading = false;
  double _height;
  double _width;
  bool imagecheck = false;
  bool piccheck = false;
  String imageUrl;
  bool nameEdit = false;
  bool aboutEdit = false;
  bool picEdit = false;
  bool passwordEdit = false;
  TextEditingController nameController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
        //padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Column(
              children: [
                InkWell(
                  child: pic(),
                  onTap: () async {
                    _image = await pickImage(context, ImageSource.gallery);
                    setState(() {
                      piccheck = true;
                    });
                    if (_image != null) {
                      setState(() {
                        picEdit = true;
                      });
                      final FirebaseStorage _storgae = FirebaseStorage(
                          storageBucket:
                              'gs://artcraftliving-b287b.appspot.com');
                      StorageUploadTask uploadTask;
                      String filePath = '${DateTime.now()}.png';
                      uploadTask =
                          _storgae.ref().child(filePath).putFile(_image);
                      uploadTask.onComplete.then((_) async {
                        print(1);
                        String url1 =
                            await uploadTask.lastSnapshot.ref.getDownloadURL();
                        _image.delete().then((onValue) {
                          print(2);
                        });
                        setState(() {
                          imagecheck = true;
                        });
                        print(url1);

                        imageUrl = url1;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(child: Text('Profile Picture')),
            Container(
              padding: EdgeInsets.all(30),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    //height: 60,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextFormField(
                      controller: nameController,
                      onChanged: (e) {
                        setState(() {
                          nameEdit = true;
                        });
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                          border: InputBorder.none,
                          hintText: userDetails.username),
                    ),
                  ),
                  SizedBox(height: 10),
                  // _input(
                  //   'Email *',
                  //   Icons.email,
                  // ),
                  // SizedBox(height: 10),
                  Container(
                    //height: 60,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        //border: Border(bottom: BorderSide(color: Colors.black)),
                        ),

                    //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: aboutController,
                      onChanged: (e) {
                        setState(() {
                          aboutEdit = true;
                        });
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_add_alt_1_outlined,
                            color: Colors.blue,
                          ),
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                          // border: new UnderlineInputBorder(
                          //     borderSide: new BorderSide(color: Colors.black, width: 2)),

                          hintText: userDetails.about),
                      maxLength: 500,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    onChanged: (e) {
                      setState(() {
                        passwordEdit = true;
                      });
                    },
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: "Enter New Password",
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.blue,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: _showPassword ? Colors.black : Colors.blue,
                        ),
                        onPressed: () {
                          setState(() => _showPassword = !_showPassword);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  SizedBox(height: 30),
                  Container(
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
                              if (picEdit) if (imagecheck) {
                                print("Hi");
                                update();
                              } else {
                                imagecheck == false
                                    ? showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      18.0),
                                              side: BorderSide(
                                                color: Colors.red[400],
                                              )),
                                          title: Text("Wait..."),
                                          content: Text("Image Not Uploaded"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.red[400]),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ))
                                    : null;
                              }
                              else
                                update();
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> pickImage(BuildContext context, ImageSource source) async {
    File selected = await ImagePicker.pickImage(
      source: source,
      imageQuality: 20,
    );
    return selected;
  }

  Widget pic() {
    return piccheck && _image != null
        ? CircleAvatar(radius: 40, backgroundImage: FileImage(_image))
        : CircleAvatar(
            radius: 40, backgroundImage: NetworkImage(userDetails.userpic));
  }

  void _changePassword(String password) async {
    //Create an instance of the current user.
    User user = FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future<void> update() async {
    setState(() {
      signupLoading = true;
    });

    print(1);

    Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection("Users")
        .document(userDetails.userDocid)
        .update({
      'userName': nameEdit ? nameController.text : userDetails.username,
      'userAbout': aboutEdit ? aboutController.text : userDetails.about,
      'userImage': picEdit ? imageUrl : userDetails.userpic,
    });
    if (passwordEdit) {
      _changePassword(passwordController.text);
    }

    await FirebaseFirestore.instance
        .collection("ArtWork")
        .getDocuments()
        .then((value) async {
      for (int i = 0; i < value.documents.length; i++) {
        print("entered");
        FirebaseFirestore.instance
            .collection("ArtWork")
            .document(value.documents[i].documentID)
            .collection("reviews")
            .where("userUid", isEqualTo: userDetails.userUid)
            .getDocuments()
            .then((value2) async {
          print("entered2");
          if (value2.documents.length != 0)
            for (int j = 0; j < value2.documents.length; j++)
              FirebaseFirestore.instance
                  .collection("ArtWork")
                  .document(value.documents[i].documentID)
                  .collection("reviews")
                  .document(value2.documents[j].documentID)
                  .update({
                "userName":
                    nameEdit ? nameController.text : userDetails.username,
                "userImage": picEdit ? imageUrl : userDetails.userpic,
              });
          print("entered3");
        });
      }
    });

    await Firestore.instance
        .collection("Users")
        .where("userEmail", isEqualTo: userDetails.userEmail)

        // ignore: deprecated_member_use
        .getDocuments()
        .then((value) => {
              userDetails = UserDetails(
                  userEmail: value.documents[0]["userEmail"],
                  about: value.documents[0]["userAbout"],
                  instagram: value.documents[0]["instagram"],
                  bonusCredit: value.documents[0]["bonusCredit"],
                  soldCredit: value.documents[0]["soldCredit"],
                  points: value.documents[0]["points"],
                  userUid: value.documents[0]["userUid"],
                  username: value.documents[0]["userName"],
                  userpic: value.documents[0]["userImage"],
                  userDocid: value.documents[0].documentID)
            });

    print(4);

    setState(() {
      signupLoading = false;
    });
    if (!firstTimeForedit)
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyGallery()));

    if (firstTimeForedit)
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AfterSignup()));
  }
}
