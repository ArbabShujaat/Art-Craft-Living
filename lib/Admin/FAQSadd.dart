import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/artwork/users.artwork.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/profiles/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailgun/mailgun.dart';

class FAQsadd extends StatefulWidget {
  @override
  _FAQsaddState createState() => _FAQsaddState();
}

class _FAQsaddState extends State<FAQsadd> {
  bool orderLoading = false;

  TextEditingController question = TextEditingController();
  TextEditingController answer = TextEditingController();

  var _formKey = GlobalKey<FormState>();

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
                _input('Question', question),
                _input('Answer', answer),
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
                          child: Text('ADD'),
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
    await FirebaseFirestore.instance.collection("FAQs").add({
      'Question': question.text,
      'Answer': answer.text,
    });

    Navigator.pop(context);
  }
}
