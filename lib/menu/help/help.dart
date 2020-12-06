import 'package:artCraftLiving/menu/help/howtouse.dart';
import 'package:artCraftLiving/menu/help/privacypolicy.dart';
import 'package:artCraftLiving/menu/help/termsandconditions.dart';
import 'package:flutter/material.dart';

import 'faqs.dart';

class Help extends StatefulWidget {
  Help({Key key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Help',
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
            ListTile(
              leading: Text('How to use this app'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HowToUse()),
                );
              },
            ),
            ListTile(
              leading: Text('FAQs'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Faqs()),
                );
              },
            ),
            ListTile(
              leading: Text('Terms and Conditions'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsAndConditions()),
                );
              },
            ),
            ListTile(
              leading: Text('Privacy Policy'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
