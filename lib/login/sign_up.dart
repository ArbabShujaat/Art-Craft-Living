import 'dart:convert';

import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/home_screen.dart';
import 'package:artCraftLiving/login/buyapp.dart';
import 'package:artCraftLiving/login/login.dart';
import 'package:artCraftLiving/menu/help/privacypolicy.dart';
import 'package:artCraftLiving/menu/help/termsandconditions.dart';
import 'package:artCraftLiving/profiles/after_signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../main.dart';
import 'buyapp2.dart';
import 'login2.dart';

bool fromSignUp = false;
String imageUrl;

TextEditingController fullnameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();
TextEditingController aboutartistContoller = TextEditingController();
TextEditingController instagramUsernameContoller = TextEditingController();

// import 'package:country_code_picker/country_code_picker.dart';
class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //hide password
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  //image picker
  File _image;
  bool signupLoading = false;
  double _height;
  double _width;
  bool imagecheck = false;
  bool piccheck = false;
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(height: 30),

              Column(children: [
                InkWell(
                  child: pic(),
                  onTap: () async {
                    _image = await pickImage(
                      context,
                      ImageSource.gallery,
                    );
                    setState(() {
                      piccheck = true;
                    });
                    if (_image != null) {
                      final FirebaseStorage _storgae = FirebaseStorage(
                          storageBucket:
                              'gs://artcraftliving-9582b.appspot.com');
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
              ]),
              SizedBox(height: 10),
              Center(child: Text('Profile Picture')),
              Container(
                padding: EdgeInsets.all(30),
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //SizedBox(height: 10),
                      _input(
                        fullnameController,
                        'Name *',
                        Icons.person,
                      ),
                      SizedBox(height: 10),
                      _input(
                        emailController,
                        'Email *',
                        Icons.email,
                      ),
                      _input(
                        instagramUsernameContoller,
                        'Instagram Username *',
                        Icons.email,
                      ),
                      SizedBox(height: 10),
                      Container(
                        //height: 60,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            //border: Border(bottom: BorderSide(color: Colors.black)),
                            ),

                        //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: TextFormField(
                          controller: aboutartistContoller,
                          validator: (String val) {
                            if (val.trim().isEmpty) {
                              aboutartistContoller.text = "";
                              return null;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_add_alt_1_outlined,
                              color: Colors.blue,
                            ),
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            // border: new UnderlineInputBorder(
                            //     borderSide: new BorderSide(color: Colors.black, width: 2)),
                            labelText: 'About Artist',
                          ),
                          maxLength: 500,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (String val) {
                          if (val.trim().isEmpty) {
                            return "Password must not be empty";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'Password *',
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
                      TextFormField(
                        validator: (String val) {
                          if (val.trim().isEmpty) {
                            return "Password must not be empty";
                          }
                          if (val.trim() != passwordController.text) {
                            return "Password doesnot match";
                          }
                          return null;
                        },
                        obscureText: !_showConfirmPassword,
                        controller: confirmpasswordController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'Confirm Password *',
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.blue,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: _showConfirmPassword
                                  ? Colors.black
                                  : Colors.blue,
                            ),
                            onPressed: () {
                              setState(() =>
                                  _showConfirmPassword = !_showConfirmPassword);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: signupLoading
                            ? CircularProgressIndicator()
                            : RaisedButton(
                                padding: EdgeInsets.fromLTRB(80, 2, 80, 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: () async {
                                  if (imagecheck &&
                                      _formKey.currentState.validate()) {
                                    setState(() {
                                      signupLoading = true;
                                    });
                                    await signUp(context);
                                    setState(() {
                                      signupLoading = false;
                                    });

                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => BuyApp()),
                                    //     (Route<dynamic> route) => false);
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
                                                    color: Colors.blue[400],
                                                  )),
                                              title: Text("Wait..."),
                                              content:
                                                  Text("Image Not Uploaded"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blue[400]),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            ))
                                        : null;
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'By signing up, you are agreeing to our ',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy()),
                      );
                    },
                    child: Container(
                      child: Text(
                        "Privacy Policy and, ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Text(
                  //   'And ',
                  //   style: TextStyle(fontSize: 13),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditions()),
                      );
                    },
                    child: Container(
                      child: Text(
                        "Terms & Conditions",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ));
  }

  Future<File> pickImage(BuildContext context, ImageSource source) async {
    File selected = await ImagePicker.pickImage(
      source: source,
      imageQuality: 13,
    );
    return selected;
  }

  Widget pic() {
    return piccheck && _image != null
        ? CircleAvatar(radius: 40, backgroundImage: FileImage(_image))
        : CircleAvatar(
            child: Icon(
              Icons.camera_alt,
              size: 40,
              color: Colors.blue,
            ),
            radius: 40,
            backgroundColor: Colors.grey[300],
          );
  }
}

Widget _input(controller, String label, IconData icon) {
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
        prefixIcon: Icon(
          icon,
          color: Colors.blue,
        ),
        labelStyle: TextStyle(fontSize: 16, color: Colors.black),
        border: InputBorder.none,
        labelText: label,
      ),
    ),
  );
}

Future<void> signUp(BuildContext context) async {
  print(emailController.text);
  print(passwordController.text);

  final bool isValid = EmailValidator.validate(emailController.text);
  if (!isValid) {
    return 0;
  }
  try {
    final User user =
        (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
            .user;

    try {
      await user.sendEmailVerification();
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }

    print(1);

    if (user != null) {
      print(2);
      print(2);

      Firebase.initializeApp();
      await FirebaseFirestore.instance.collection("Users").add({
        'userEmail': emailController.text,
        'userName': fullnameController.text,
        'userUid': user.uid,
        'verified': false,
        'firstTime': true,
        'userImage': imageUrl,
        'userAbout': aboutartistContoller.text,
        'instagram': instagramUsernameContoller.text,
        'bonusCredit': "0",
        'soldCredit': "0",
        'points': "0",
      });
      print(3);

      await Firestore.instance
          .collection("Users")
          .where("userEmail", isEqualTo: emailController.text)
          .getDocuments()
          .then((value) => {
                userDetails = UserDetails(
                    userEmail: value.documents[0]["userEmail"],
                    about: value.documents[0]["userAbout"],
                    verified: value.documents[0]["verified"],
                    firstTime: value.documents[0]["firstTime"],
                    bonusCredit: value.documents[0]["bonusCredit"],
                    soldCredit: value.documents[0]["soldCredit"],
                    points: value.documents[0]["points"],
                    userUid: value.documents[0]["userUid"],
                    username: value.documents[0]["userName"],
                    userpic: value.documents[0]["userImage"],
                    instagram: value.documents[0]["instagram"],
                    userDocid: value.documents[0].documentID)
              });

      print(4);

      fromSignUp = true;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LogIn2()),
      );

      // setState(() {
      //   signupLoading = false;
      // });
      return 0;
    }
  } catch (signUpError) {
    // setState(() {
    //   signupLoading = false;
    // });

    print("Hiiiii1");
    showDialog(
        context: context,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(
                color: Colors.red[400],
              )),
          title: Text(signUpError.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.red[400]),
              ),
              onPressed: () {
                Navigator.pop(context);
                return 0;
              },
            )
          ],
        ));
    return 0;
    print("Hiiiii2");

    //Error handling
    if (signUpError is PlatformException) {
      showDialog(
          context: context,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text(signUpError.message),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red[400]),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  return 0;
                },
              )
            ],
          ));
      if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showDialog(
            context: context,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: Colors.red[400],
                  )),
              title: Text("Email already in use"),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    return 0;
                  },
                )
              ],
            ));
      }

      if (signUpError.code == 'ERROR_WEAK_PASSWORD') {
        showDialog(
            context: context,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: Colors.red[400],
                  )),
              title: Text("Weak Password"),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    return 0;
                  },
                )
              ],
            ));
      }

      if (signUpError.code == 'ERROR_INVALID_EMAIL') {
        showDialog(
            context: context,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: Colors.red[400],
                  )),
              title: Text("Invalid Email"),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    return 0;
                  },
                )
              ],
            ));
        return 0;
      }
    }
    showDialog(
        context: context,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(
                color: Colors.red[400],
              )),
          title: Text(signUpError),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.red[400]),
              ),
              onPressed: () {
                Navigator.pop(context);
                return 0;
              },
            )
          ],
        ));
  }
}
