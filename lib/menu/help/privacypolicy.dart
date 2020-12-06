import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text(
              'Last Updated: October 26, 2020',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),
            Text(
              'DATA PROTECTION POLICY',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Data protection'),
            Text('Internet & App Privacy Policy'),
            Text('of '),
            Text('Art.Craft.Living'),
            Text('Hammerbrookstrasse 93'),
            Text('20097 Hamburg'),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'ArtCraftLiving, ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  TextSpan(
                      text:
                          ' its service providers, and suppliers ("we", "us", "our") recommitted to protecting and respecting your privacy.',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            Text(
                'Our goal is to provide you with a platform to promote your artworks, connect with other artists and find collectors for your works. We support you by sending you money for every successful transaction you make on the app. To help us do that, we collect personal data when you register, contact us with inquiries, or use certain parts of the app ("App").'),
            Text(
                '\“Personal data\” means any information relating to an identified or identifiable person.This notice provides you with information about:'),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.fiber_manual_record,
                size: 10,
                color: Colors.black,
              ),
              title: new Text('how we use your data;'),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.fiber_manual_record,
                size: 10,
                color: Colors.black,
              ),
              title: new Text('what personal data we collect;'),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.fiber_manual_record,
                size: 10,
                color: Colors.black,
              ),
              title: new Text('who we provide your personal data to; and'),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.fiber_manual_record,
                size: 10,
                color: Colors.black,
              ),
              title:
                  new Text('your legal rights relating to your personal data.'),
            ),
            SizedBox(height: 20),
            Text(
              'Who\'s who',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
                'When this privacy notice uses the terms "participant", "you", or "your" we mean people using the registration page and App.'),
            Text(
                'If you have any questions or concerns at any time, please contact us at the address above.'),
            SizedBox(height: 20),
            Text(
              'How do we use your data?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('We use your data:'),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("to send you money "),
                )),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.fiber_manual_record,
                size: 10,
                color: Colors.black,
              ),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: Text("to understand who is selling and supporting art "),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.fiber_manual_record,
                size: 10,
                color: Colors.black,
              ),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: Text("to complete a sales or purchase transaction"),
              ),
            ),
            ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.fiber_manual_record,
                size: 10,
                color: Colors.black,
              ),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: Text("to make a tailored App available to you"),
              ),
            ),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "to manage any registered account(s) that you hold with us; "),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("to verify your identity;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "to send you announcements about art on sale and purchased art;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "to send you notifications of private messages received through the App;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "to better understand your needs and how you engaged with the elements of the App;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "for crime and fraud prevention, detection and related purposes;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "to enable us to manage customer service interactions with you; and"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "where we have a legal right or duty to use or disclose your information (for example in relation to an investigation by a public authority or in a legal dispute)."),
                )),
            Text(
                'If the App is configured to permit public access, some personal data that you have provided, including that shown in group discussions, the activity feed, and your participant profile (if published), will be publicly viewable.'),
            Text(
                'If you ask for help with using the App, we may access your personal data in order to understand the problem and find a solution.'),
            SizedBox(height: 20),
            Text(
              'What information do we collect from you?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Information you may give us:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("your profile details, including your username "),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("Your name;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "your contact details, including email and postal address;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("your password;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("your photograph;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("your biographical summary;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("your paypalme link; "),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("your social media links;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("your website link;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("your communication preferences;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "your interests, preferences, feedback, and survey responses;"),
                )),
            SizedBox(height: 10),
            Text(
              'Information you may give us:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "information about your visit, including the full Uniform Resource Locators (URL) clickstream to, through and from our website (including date and time); products you viewed or searched for; page response times, download errors, length of visits to certain pages, page interaction information (such as scrolling, clicks, and mouse-overs), and methods used to browse away from the page."),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "technical information that your browser sends whenever you visit a website or your mobile App sends when you are using it. This log data may include your Internet Protocol (IP) address, the address of the web page you visited before using the Service, your browser type and settings, the date and time of your use of the Service, information about your browser configuration and plug-ins, device information (including device identifiers and estimated geographical location), language preferences and cookie data."),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "other publicly available personal data, including any shared via a public platform (such as a Twitter feed) when these are selected for display on the App."),
                )),
            Text(
                'This list is not exhaustive and, in specific instances, we may need to collect additional data for the purposes set out in this notice.'),
            Text(
                'We use a third-party service, Google Analytics, to collect standard internet log information and details of visitor behaviour patterns on our registration page and App. We do this to find out things such as the number of people using the registration page and App and the popularity of content within the App. This information is only processed in a way which does not identify anyone. We use the anonymizeip feature to anonymize your IP address and limit the amount of identifiable data is collected. We do not make, and do not allow Google to make, any attempt to find out the identities of those visiting our website.'),
            SizedBox(height: 20),
            Text(
              'Use of cookies',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'We use cookies on our website to distinguish you from other users of our website and Service. This helps us to provide you with a good experience when you browse our website and also allows us to improve the website and Service. For detailed information on the cookies we use and the purposes for which we use them see our Cookie Policy.'),
            SizedBox(height: 20),
            Text(
              'Use by Children',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'Our registration page and App are not intended for children and we do not knowingly collect data relating to children.'),
            SizedBox(height: 20),
            Text(
              'Why do we collect this information?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'We collect and use your personal data because it is necessary for:'),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("performance of our contractual obligations;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "the pursuit of our legitimate interests (as set out below); or"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("complying with our legal obligations."),
                )),
            Text(
                'In general, we only rely on consent as a legal basis for processing in relation to distributing transaction announcements via push notification.'),
            Text(
                'You have the right to withdraw consent at any time. If you revoke consent for a particular purpose for which you had previously provided consent, we will stop using your personal data for that purpose after consent is withdrawn.'),
            SizedBox(height: 20),
            Text(
              'Our legitimate interests',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'The normal legal basis for processing participant data, is that it is necessary for our legitimate interests, including:'),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "identifying the participants we are transferring funds to;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child:
                      Text("managing access to our App and online services;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "allowing users of the App to recognize you as the author of reviews, group discussion posts, and activity feed posts you create;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child:
                      Text("letting other participants find you in the app;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "protecting and demonstrating the integrity of transactions within the app;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "protecting participants, employees and other individuals and maintaining their safety, health and welfare;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "promoting, marketing and advertising our services offerings;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "understanding our participants’ behaviour, activities, preferences, and needs;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "improving existing products and services and developing new products and services;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "complying with our legal and regulatory obligations;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "preventing, investigating and detecting crime, fraud or anti-social behaviour and prosecuting offenders, including working with law enforcement agencies;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "handling participant contacts, queries, complaints or disputes;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("managing insurance claims by participants;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "protecting us, our employees and participants, by taking appropriate legal action against third parties who have committed criminal acts or are in breach of legal obligations to us;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "effectively handling any legal claims or regulatory enforcement actions taken against us; and"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "fulfilling our duties to our participants, colleagues, shareholders and other stakeholders."),
                )),
            SizedBox(height: 20),
            Text(
              'Who might we share your information with?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              'Our service providers and suppliers',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'In order to make certain services available to you, we may need to share your personal data with some of our service partners. These include our registration and App provider.'),
            Text(
                'We only allow our service providers to handle your personal data when we have confirmed that they apply appropriate data protection and security controls. We impose contractual obligations on service providers to ensure that they (i) process personal data only under our instructions; (ii) assist us in fulfilling our obligations under applicable data protection legislation; and (iii) safeguard personal data in compliance with applicable data protection legislation.'),
            SizedBox(height: 20),
            Text(
              'Required by law',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'We will disclose personal data when we believe that the disclosure is required by law, including to comply with a judicial order served on us or when we receive a request from law enforcement authorities. We will only disclose personal data to law enforcement authorities upon demonstration of lawful authority.'),
            SizedBox(height: 20),
            Text(
              'International transfers',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'If you are registering for or using the App from outside the United States, please be aware that you are sending information (including personal data) to the United States where our servers are located. The courts, law enforcement or public authorities in the United States may be able to obtain disclosure of the data through the laws of the United States.'),
            Text(
                'Our Service is accessible via the Internet and may potentially be accessed by any user around the world. Other users may access the Service from outside the European Economic Area (EEA). This means that where you chose to upload your data to the Service, it could be accessed from anywhere around the world and therefore a transfer of your data outside of the EEA may be deemed to have occurred. You consent to such transfer of your data for and by way of this purpose.'),
            SizedBox(height: 20),
            Text(
              'How long do we keep your information?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'We will not retain your personal data for longer than necessary for the purposes set out in this notice.'),
            SizedBox(height: 20),
            Text(
              'How do we secure and protect your information?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'We are committed to data security. We protect personal data through integrated physical, technological and administrative safeguards. Personal data is protected by security safeguards appropriate to the level of sensitivity of the data through (i) physical measures, such as secure areas; (ii) technical measures, such as encryption and secure servers; and (iii) organizational measures such as access policies based on the need-to-know and employee security through vetting and supervision.'),
            Text(
                'However, if a personal data breach has occurred, we will notify you of the breach after becoming aware of the breach in accordance with applicable privacy legislation.'),
            SizedBox(height: 20),
            Text(
              'What rights do you have?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'The EU General Data Protection Regulation (GDPR) and similar privacy legislation provide for certain rights with respect to your personal data, including:'),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "the right to ask what personal data we hold about you at any time and access that personal data;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "the right to object to certain uses of your personal data;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "the right to ask us to update and correct any out-of-date or incorrect personal data that we hold about you free of charge;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("the right to have your personal data deleted;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "the right to demand restriction of processing of your personal data;"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text("the right to data portability; and"),
                )),
            ListTile(
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                  color: Colors.black,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                      "the right to revoke consent for uses of your personal data to which you previously consented."),
                )),
            Text(
                'You can correct the data published in your participant profile through the App or self-edit link. If you wish to exercise any of the above rights, please contact us using the contact details set out above.'),
            Text(
                'Requests to exercise data protection rights will be assessed on a case-by-case basis. Not all jurisdictions require us to provide you with the rights listed above. In these jurisdictions, we may not be legally required to comply with your request. There may also be circumstances where we are not legally required to comply with your request because of exemptions provided for in applicable data protection legislation.'),
            Text(
                'We will respond to your request within one month, free of charge, unless the volume or complexity of the request requires a longer process. We will notify you if we require an extension and may charge you a reasonable fee if the administrative cost of providing the information is excessive. If we refuse the request, we will provide justification.'),
            SizedBox(height: 20),
            Text(
              'Changes to this notice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
                'We reserve the right, in our sole discretion, to update or modify this privacy notice at any time ("modifications"). Modifications to this privacy notice will be posted with a change to the "Updated" date at the top of this privacy notice. In certain circumstances we may, but need not, provide you with additional notice of such modifications, including by email.'),
            Text(
                'Please review this policy periodically, and especially before you provide any personal data. This privacy notice was updated on the date indicated above. Your continued participation and use of the App following the effectiveness of any modifications to this privacy notice constitutes acceptance of those modifications. If any modification to this privacy notice is not acceptable to you, you should cease accessing, browsing and otherwise using the App.'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
