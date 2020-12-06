import 'package:artCraftLiving/menu/help/termsandconditions.dart';
import 'package:artCraftLiving/profiles/user_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Exhibition extends StatefulWidget {
  Exhibition({Key key}) : super(key: key);

  @override
  _ExhibitionState createState() => _ExhibitionState();
}

class _ExhibitionState extends State<Exhibition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Exhibition',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: ListView(
          children: [
            Text(
              'This section is for artists who would like to be a member of our gallery and who would like to have regular exhibitions in our gallery premises in Hamburg, Germany.',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Please read our ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Membership Terms & Conditions ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsAndConditions(),
                          ),
                        );
                      },
                  ),
                  TextSpan(
                    text:
                        'and if you agree to the terms and conditions, follow this link to payment for our artist support services: ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            InkWell(
                child: new Text(
                  'https://www.artcraftliving.com/plans-pricing',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                onTap: () =>
                    launch('https://www.artcraftliving.com/plans-pricing')),
            SizedBox(height: 20),
            Text(
              'Once we receive your payment, we will send you a confirmation, a membership number, and your membership card per post.',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'If you have questions, please contact us in the Help section.',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
