import 'dart:convert';

import 'package:artCraftLiving/Admin/Home.dart';
import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/login/forgot_password.dart';
import 'package:artCraftLiving/login/sign_up.dart';
import 'package:artCraftLiving/profiles/after_signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../home_screen.dart';
import '../main.dart';

class LogIn2 extends StatefulWidget {
  LogIn2({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

bool loginLoading = false;
final FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
GlobalKey<FormState> _key = GlobalKey();

class _LogInState extends State<LogIn2> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(height: 50),
              Image(
                image: AssetImage('assets/logo.jpeg'),
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  "A email verification is sent to your email kindly  verify your email and login here",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              Opacity(
                opacity: 0.8,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        _textInput('Email Address', Icons.email),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.blue,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color:
                                    _showPassword ? Colors.blue : Colors.black,
                              ),
                              onPressed: () {
                                setState(() => _showPassword = !_showPassword);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        button(),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Forgot your password?",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ));
  }

  Widget button() {
    return loginLoading
        ? CircularProgressIndicator()
        : RaisedButton(
            onPressed: () async {
              if (_key.currentState.validate()) {
                setState(() {
                  loginLoading = true;
                });
                if (_emailController.text == adminEmail &&
                    _passwordController.text == adminPassword) {
                  var prefs = await SharedPreferences.getInstance();
                  final userData = json.encode(
                    {
                      'Email': adminEmail,
                      'password': adminPassword,
                    },
                  );
                  prefs.setString('AdminData', userData);
                  setState(() {
                    loginLoading = false;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AdminHome()),
                  );
                  return 0;
                }

                final bool isValid =
                    EmailValidator.validate(_emailController.text);
                if (!isValid) {
                  return 0;
                }
                try {
                  final User user = (await _auth.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ))
                      .user;

                  if (!user.emailVerified) {
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.red,
                              )),
                          title: Text("Please veriy your email"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ));
                    setState(() {
                      loginLoading = false;
                    });
                  }

                  if (user != null && user.emailVerified) {
                    print("Verified");
                    var prefs = await SharedPreferences.getInstance();
                    final userData = json.encode(
                      {
                        'userEmail': user.email,
                        'userUid': user.uid,
                        'password': _passwordController.text,
                      },
                    );
                    prefs.setString('userData', userData);

                    try {
                      await Firestore.instance
                          .collection("Users")
                          .where("userEmail", isEqualTo: user.email)

                          // ignore: deprecated_member_use
                          .getDocuments()
                          .then((value) => {
                                userDetails = UserDetails(
                                    userEmail: value.documents[0]["userEmail"],
                                    about: value.documents[0]["userAbout"],
                                    bonusCredit: value.documents[0]
                                        ["bonusCredit"],
                                    instagram: value.documents[0]["instagram"],
                                    soldCredit: value.documents[0]
                                        ["soldCredit"],
                                    verified: value.documents[0]["verified"],
                                    firstTime: value.documents[0]["firstTime"],
                                    points: value.documents[0]["points"],
                                    userUid: value.documents[0]["userUid"],
                                    username: value.documents[0]["userName"],
                                    userpic: value.documents[0]["userImage"],
                                    userDocid: value.documents[0].documentID)
                              });

                      if (userDetails.firstTime == true &&
                          userDetails.verified == false) {
                        await Firestore.instance
                            .collection("Users")
                            .document(userDetails.userDocid)
                            .update({"verified": true, "firstTime": false});

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AfterSignup()));
                        setState(() {
                          loginLoading = false;
                        });
                      }
                    } catch (e) {
                      print(e);
                    }

                    setState(() {
                      loginLoading = false;
                    });
                  }
                } catch (signUpError) {
                  setState(() {
                    loginLoading = false;
                  });

                  if (true) {
                    if (signUpError.code == 'ERROR_INVALID_EMAIL') {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red,
                                )),
                            title: Text("Incorrect Email"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ));
                    } else if (signUpError.code == 'ERROR_WRONG_PASSWORD') {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red,
                                )),
                            title: Text("Wrong Password"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ));
                    } else if (signUpError.code == 'ERROR_USER_NOT_FOUND') {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red,
                                )),
                            title: Text("No user exists"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ));
                    } else {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red,
                                )),
                            title: Text(signUpError.message),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ));
                    }
                  }
                }
              }
            },
            padding: EdgeInsets.fromLTRB(80, 2, 80, 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 17),
            ),
          );
  }
}

Widget _textInput(String label, IconData icon) {
  return Container(
    height: 60,
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.black)),
    ),
    //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: TextFormField(
      controller: _emailController,
      validator: (String val) {
        if (val.isEmpty) {
          return 'Email must not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 16, color: Colors.black),
        border: InputBorder.none,
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
    ),
  );
}
