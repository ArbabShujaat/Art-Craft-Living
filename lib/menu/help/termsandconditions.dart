import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  TermsAndConditions({Key key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Terms and Conditions',
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
            Text('Last Updated: 26 October, 2020'),
            SizedBox(height: 20),
            Text(
              'TERMS AND CONDITIONS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
                'The registration capabilities and services (collectively, the "App") are provided to you by ArtCraftLiving. These Terms and Conditions apply to anyone who accesses or uses the App.'),
            SizedBox(height: 5),
            Text(
                'The App is provided to you as-is without any guarantee and you use it at your own risk. The App contains material which is owned by us, so you should not copy them without obtaining permission from the authorized owner. Any data you submit to the App may be publicly viewable. You are responsible for the security of Personal Data of other participants provided to you when you use the App. You can find out how we collect and use your Data in our Privacy Notice.'),
            SizedBox(height: 5),
            Text('General Terms and Conditions'),
            Text('of '),
            Text('Art.Craft.Living '),
            Text('Hammerbrookstrasse 93 '),
            Text('20097 Hamburg '),
            SizedBox(height: 5),
            Text(
                'ArtCraftLiving (hereinafter "we", "our", or "us") provides a service ("platform") as a mobile application (app) in the relevant app stores, with the help of which the artist (hereinafter "user", "you", "your") can promote artworks, connect with other artists, support other artists, and find collectors for artworks. Our main goal is to support and promote artists all around the world, connect them with other artists and art collectors and provide a platform where art works can be exhibited, sold, reviewed, bought, and promoted. The artist is anyone who uploads an artwork on the platform and the supporter is anyone who leaves a review on an artwork or purchases an artwork. Anyone who uses this platform is a "user". The following conditions regulate the use of the app by the user. '),
            SizedBox(height: 10),
            Text('1. SCOPE  '),
            SizedBox(height: 5),
            Text('1.1 Platform.  '),
            SizedBox(height: 2),
            Text(
                'We provide the platform as a mobile application (app) with the help of which you can upload your artworks, promote your works, review other artworks, and carry out sales and purchasing transactions with other users using the points collected within the app.'),
            SizedBox(height: 5),
            Text('1.2 Age  '),
            SizedBox(height: 2),
            Text(
                'You represent that you are of legal age in your jurisdiction to enter into a binding contract, and that are at least thirteen (13) years old. Children under the age of thirteen (13) are prohibited from using any of the Services. If you are between thirteen (13) and eighteen (18) years old, you must review this Agreement with your parent or guardian, have him/her accept it on your behalf, as well as approve your use of the Services.'),
            SizedBox(height: 5),
            Text('1.3 Language; Contract in Electronic Form. '),
            SizedBox(height: 5),
            Text(
                'The language of this Agreement is expressly agreed to be in the English language only. By accepting this agreement, you irrevocably waive any law applicable to you requiring that the Agreement be localized to meet your language (as well as any other localization requirements), or requiring an original (non-electronic) signature or delivery or retention of non-electronic records.'),
            SizedBox(height: 5),
            Text('1.4 App Download from App Marketplace.'),
            SizedBox(height: 2),
            Text(
                'If you are downloading the App from a third party app-distribution platform or App marketplace, such as Apple\'s App Store, Google\'s Google Play, or the Amazon Appstore for Android, please note that the App Marketplace may have additional terms which also govern your use of the App.'),
            SizedBox(height: 5),
            Text(
                '1.5 ArtCraftLiving does not recognize any general terms and conditions of the user that conflict with or deviate from these Terms and Conditions, unless their validity is expressly agreed in writing. '),
            SizedBox(height: 10),
            Text('2. DECLARATION OF CONSENT'),
            SizedBox(height: 5),
            Text(
                '2.1 The user agrees to our Terms and Conditions, and to our Data Protection Policy, when registering and setting up a profile by confirming the declaration: "By signing up, you are agreeing to our Privacy Policy and Terms & Conditions" by clicking on the "Sign Up" button during registration.'),
            SizedBox(height: 5),
            Text(
                '2.2 By using the ArtCraftLiving app, the user agrees to the validity of the Terms and Conditions.'),
            SizedBox(height: 10),
            Text('3. REGISTRATION'),
            SizedBox(height: 5),
            Text(
                '3.1 In order to access the Services, you will be required to register for an account by submitting the information requested in the applicable form ("Profile"). You are solely responsible for maintaining the confidentiality and security of your Profile and credentials, as well as for all activities that occur in such Profile. We will process and use the information collected by us in creating your Profile in accordance with our Privacy Policy (available in the Help section of this app).'),
            SizedBox(height: 10),
            Text('4. PAYMENT'),
            SizedBox(height: 5),
            Text(
                '4.1. The app can be downloaded from the relevant app store for free but access to the platform is granted at a price indicated on the offer page. With your acceptance of our offer, the contract ("agreement") for the use of the ArtCraftLiving App is concluded. You agree to pay whatever fees and other charges are presented to you when you accept our offer. All Fees are non-refundable and non-cancellable once access is gained to our platform. Moreover, amounts payable are exclusive of all applicable sales, use, consumption, VAT and other taxes, except for taxes based upon ArtCraftLiving net income.'),
            SizedBox(height: 5),
            Text('4.2. Payment Methods and Processing. '),
            SizedBox(height: 5),
            Text(
                'Payments may be processed via the relevant App Marketplace, as well as any other third-party payment methods which we make available (such as via PayPal). You must provide accurate billing information, and immediately update any changes to it. If you are paying via credit or debit card, you assure that you are the authorized user of the card, and you authorize ArtCraftLiving (and any third party payment processor) to process payment from you and to take all other necessary billing actions. If payment is made via a third-party payment processor, you will also be subject to its terms and conditions.'),
            SizedBox(height: 10),
            Text('5. OBLIGATIONS'),
            SizedBox(height: 5),
            Text('5.1 Our commitment.'),
            SizedBox(height: 2),
            Text(
                'Our goal is to support and promote artists worldwide. In this respect, we fund all art transactions “transactions” in the app with part of the income received from our paid services. As an art supporter, you will not have to spend your money for the works you purchase “collect” on our platform. Instead, we will reward your support of other artists by paying you a bonus “bonus” for every art you collect.'),
            SizedBox(height: 5),
            Text('5.2 Reviews and Points. '),
            SizedBox(height: 2),
            Text(
                'We encourage and support your activities and transactions on the app by paying you real currency for your sold works and also for collecting the works of other artists. To collect any artwork, you must first collect 100 points “points” by leaving reviews “reviews” on the artworks of other users. One Point is awarded for every first Review left on a user’s profile. Once you have collected 100 points, you must use the points immediately to purchase an artwork. You will find your point balance in the Collected Points section on your profile.'),
            SizedBox(height: 5),
            Text('5.3 Bonus.'),
            SizedBox(height: 2),
            Text(
                'We will pay you a 5-Euro-bonus (or equivalent in your currency) for every artwork you collect with 100 Points. To receive your bonus, you must follow the instructions under the Payment section on your profile and send us a photo “photo” of the received artwork hanging on a wall in its new home. '),
            SizedBox(height: 5),
            Text(
                '5.4 Payment for sales. To receive a Payment from us for your sold work, you must follow the instructions under the Payment section on your profile and must send us the a screenshot of the delivery confirmation. You must only Review artworks you feel positive about and you must ensure that your Reviews are not defamatory, negative, discouraging, demotivating, mean or rude in any way or form. By posting a Review and uploading a photo of a purchased work hanging on a wall in its new home, you give us, and the artist unrestricted permission to use your review and photo for promotional purposes.'),
            SizedBox(height: 5),
            Text('5.5 Artwork, Pricing, Transactions, and Refunds.'),
            SizedBox(height: 2),
            Text(
                'You agree to post only small-sized artworks such as paintings, drawings, studies, art prints. By posting artworks, you assure that you are the sole owner of all rights to the works. You must specify the price, technique, year and title when uploading an artwork. The stated price of artwork must not exceed 100 Euros (or equivalent in your currency). The price must be in gross pricing (inclusive of transportation cost and all relevant taxes). You are responsible for organizing and paying for the delivery of your sold artwork to the collector. Sold artworks must be sent off to the collector within five days after purchase and you must keep a tracking record of the delivery. You must send us the delivery confirmation in order to receive a payment from us. All purchases are closed to returns and refunds. You are not entitled to a refund of used points. You have the right to return the artwork back to the artist if it does not meet your expectations but you will be responsible for the return-costs and the used-up points will not be recovered.'),
            SizedBox(height: 5),
            Text('6. ENFORCEABILITY'),
            SizedBox(height: 2),
            Text(
                'You acknowledge and agree that you have freely and voluntarily entered into these Terms and Conditions of Use for the ArtCraftLiving App, have read and understood each and every provision, and any interpretation of these Terms of Use shall not be construed against us because we drafted these Terms of Use.'),
            SizedBox(height: 10),
            Text('7. DISCLAIMER'),
            SizedBox(height: 2),
            Text(
                'YOU ACKNOWLEDGE AND AGREE THAT THE APP AND ITS CONTENTS ARE PROVIDED ON AN “AS IS”, “AS AVAILABLE” BASIS AND WE DO NOT MAKE ANY, AND HEREBY SPECIFICALLY DISCLAIM ANY, REPRESENTATIONS, ENDORSEMENTS, GUARANTEES, OR WARRANTIES, EXPRESS OR IMPLIED, REGARDING THE APP OR ITS CONTENTS, INCLUDING, WITHOUT LIMITATION, ANY REGARDING OR ARISING FROM: (I) MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, OR NONINFRINGEMENT OF INTELLECTUAL PROPERTY RIGHTS; (II) COURSE OF DEALING, COURSE OF USAGE, OR COURSE OF PERFORMANCE; OR (III) TIMELINESS, ACCURACY, RELIABILITY OR CONTENT OF THE APP AND ANY INFORMATION PROVIDED THROUGH THE APP UNDER THIS AGREEMENT. WE DO NOT GUARANTEE THAT THE APP WILL ALWAYS FUNCTION WITHOUT DISRUPTIONS, DELAYS OR IMPERFECTIONS. WE DO NOT CONTROL AND ARE NOT RESPONSIBLE FOR CONTROLLING HOW OR WHEN OUR USERS USE THE PLATFORM. WE ARE NOT OBLIGED TO CONTROL AND NON-RESPONSIBLE FOR CONTROLLING THE ACTIONS, INFORMATION AND CONTENT OF OUR USERS OR OTHER THIRD PARTIES. '),
            SizedBox(height: 10),
            Text('8. LIMITATION OF LIABILITY'),
            SizedBox(height: 2),
            Text(
                'WE ARE NOT LIABLE FOR DIRECT, INDIRECT, INCIDENTAL, CONSEQUENTIAL, SPECIAL, PUNITIVE, EXEMPLARY, OR ANY OTHER DAMAGES (COLLECTIVELY, THE “DAMAGES”), ARISING OUT OF YOUR USE OR INABILITY TO USE THE APP. THIS PROVISION ENTITLED “LIMITATION OF LIABILITY” APPLIES REGARDLESS OF: (A) OUR NEGLIGENCE; (B) OUR GROSS NEGLIGENCE; (C) ANY FAILURE OF AN ESSENTIAL PURPOSE; AND (D) WHETHER SUCH LIABILITY ARISES IN NEGLIGENCE, CONTRACT, TORT, OR ANY OTHER THEORY OF LEGAL LIABILITY. THIS PROVISION ENTITLED “LIMITATION OF LIABILITY” APPLIES EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF OR COULD HAVE FORESEEN THE DAMAGES. IN THOSE STATES THAT DO NOT ALLOW THE EXCLUSION OR LIMITATION OF LIABILITY FOR THE DAMAGES, OUR LIABILITY IS LIMITED TO THE FULLEST POSSIBLE EXTENT PERMITTED BY LAW. WE ARE NOT RESPONSIBLE AND NOT LIABLE FOR ANY INFORMATION, PRODUCTS, OR SERVICES PROVIDED BY OTHER WEB SITES THAT LINK TO OR FROM THE APP.'),
            SizedBox(height: 10),
            Text('9. YOUR USE OF THE APP'),
            SizedBox(height: 5),
            Text('9.1 Your Right to Use the App. '),
            SizedBox(height: 2),
            Text(
                'We grant you a non-exclusive, personal, and revocable right to access the App.'),
            SizedBox(height: 5),
            Text('9.2 Passwords.'),
            SizedBox(height: 2),
            Text(
                'You are responsible for protecting the confidentiality of your password(s), and for the acts and omissions of any third party that accesses the App through use of your password, as if such acts and omissions were your own.'),
            SizedBox(height: 5),
            Text('9.3 Protection of Personal Data.'),
            SizedBox(height: 2),
            Text(
                'You may be provided with Personal Data of other users when using the App. You are responsible for protecting any Personal Data provided to you when you use the App. You agree not to make copies of any Personal Data provided to you within the App or to make use of such Personal Data other than those uses provided by the App.'),
            SizedBox(height: 5),
            Text(
                '9.4 Changes to the App and Premium Features. We shall have the right at any time to change or discontinue any aspect or feature of the App, including, but not limited to, content, hours of availability, and equipment needed for access or use.'),
            SizedBox(height: 10),
            Text('10. CHANGED TERMS'),
            SizedBox(height: 2),
            Text(
                'We reserve the right, in our sole discretion, to update or modify these Terms at any time ("modifications").'),
            SizedBox(height: 2),
            Text(
                'Modifications to these Terms will be posted with a change to the "Updated" date at the top of this page. In certain circumstances we may, but need not, provide you with additional notice of such modifications, including by email. Modifications will be effective thirty (30) days following the "Updated" date or such other date as communicated in any other notice to you.'),
            SizedBox(height: 2),
            Text(
                'Please review these Terms periodically. These Terms were updated on the date indicated above. Your continued participation in the event and use of the app following the effectiveness of any modifications to these Terms constitutes acceptance of those modifications. If any modification to these Terms is not acceptable to you, you should cease accessing, browsing and otherwise using the app.'),
            SizedBox(height: 2),
            Text(
                'Please note that access to premium App features may be subject to a fee and additional agreement(s), which we will provide to you for your approval before charging you.'),
            SizedBox(height: 10),
            Text('11. EQUIPMENT'),
            SizedBox(height: 2),
            Text(
                'You must obtain, pay for and maintain all software, hardware and anything else needed to use the App.'),
            SizedBox(height: 10),
            Text('12. YOUR CONDUCT'),
            SizedBox(height: 5),
            Text('12.1 Lawful Purposes'),
            SizedBox(height: 5),
            Text('You shall use the App for lawful purposes only.'),
            SizedBox(height: 5),
            Text('12.2 Intellectual Property'),
            SizedBox(height: 2),
            Text(
                'The App contains copyrighted material, trademarks and other proprietary information, which may include, but is not limited to, logo, text, software, photos, video, graphics, music and sound. We own a copyright in the selection, coordination, arrangement and enhancement of such content, as well as in the content original, granted or assigned to us. You may not modify, publish, transmit, participate in the transfer or sale of, create derivative works, publicly distribute, publicly display, reproduce, publicly perform, or in any way exploit in any format whatsoever (including, without limitation, print and electronic formats) any of the App content, without our prior written authorization. This material includes, but is not limited to, the design, layout, look, appearance and graphics. You acknowledge that you do not acquire any ownership rights by downloading copyrighted material.'),
            SizedBox(height: 5),
            Text('12.3 Works and Material You Submit to the App.'),
            SizedBox(height: 2),
            Text(
                'You shall not upload, post or otherwise make available on the App any works or material protected by copyright, trademark or other proprietary right without the express written permission of the owner of the copyright, trademark or other proprietary right and the burden of determining that any works or material are not so protected rests entirely with you. You are liable for any damage resulting from any infringement of copyrights, trademarks, or other proprietary rights, or any other harm resulting from such a submission. For all works or material submitted by you to the App, you automatically grant, or warrant that the owner of such material has expressly granted, us a royalty-free, perpetual, irrevocable, worldwide, fully-paid up license to use, reproduce, create derivative works, publicly distribute, publicly perform, publicly display, assume any sound recording rights or moral rights of attribution or integrity, transmit, modify, adapt, publish, translate and distribute such material (in whole or in part) worldwide and/or to incorporate it in other works in any form, media or technology now known or hereafter developed (including, without limitation, print and electronic form, media and technology) for the full term of any copyright that may exist in such works or materials. Except as limited under applicable law, and subject to any functionality on the App allowing you to restrict access, you also permit any other App user to access, view, store or reproduce the works or materials consistent with the provision entitled “Your Right to Use the App".'),
            SizedBox(height: 5),
            Text(
                '12.4 No Unauthorized Access and Unauthorized Activities on the App.'),
            SizedBox(height: 2),
            Text(
                'The App is only publicly available for the authorized uses described in these Terms of Use. Access to the App is not authorized for any activities that interfere or have the potential to interfere with our possessory interest in the App. Unauthorized activities, include, but are not limited to: any access and use of the App for automated access, screen or data scraping, data acquisition and consolidation, automated offers; using the App in an attempt to break security, or so as to actually break security of any computer network (including, without limitation, the App itself); using the App for unauthorized relays through any third party systems; attempting, in any way, to interfere with or deny service to any user or any host on the Internet; using the App to engage in unsolicited commercial email, or to add or attempt to add addresses to any mailing list (yours or a third party’s); using the App to engage in flood attacks, which are defined as overburdening a recipient computer system by sending a high volume of spurious data which effectively impedes or totally disables functionality of the recipient system(s), or any other denial of service attacks; furnishing false data on your sign-up form, contract, or online application, including, without limitation, providing fraudulent payment information; actively engaging in or authorizing making the App or any portion available as part of a “co-branded” or “private label” web site, web service, or Internet access service, or as part of a “channel” through a software or Internet service, or similar arrangements or relationships that offer or provide access to the App from or through other web sites, web services, or Internet access services.'),
            SizedBox(height: 10),
            Text('13. MONITORING'),
            SizedBox(height: 2),
            Text(
                'We reserve the right to remove any material that we find violates these Terms of agreement may cause liability for us, or is otherwise objectionable.'),
            SizedBox(height: 10),
            Text('14. FEEDBACK'),
            SizedBox(height: 5),
            Text(
                'You understand that the feedback you give about the use of our platform is not obligatory and that we may use such feedback without any obligation to compensate you for them.'),
            SizedBox(height: 10),
            Text('15. TERMINATION AND SURVIVAL'),
            SizedBox(height: 5),
            Text(
                'You may terminate these Terms of Use at any time by deleting and ceasing to use the App, but if you use the App again in the future, then you will have agreed to these Terms of Use again. Sections 6, 7, 8, 12, 13, 14, 16 and 17 survive any termination or expiration of these Terms of Use. We reserve the right to modify, suspend, or terminate your access to our Services anytime for suspicious or unlawful conduct, including for fraud.'),
            SizedBox(height: 10),
            Text('16. GENERAL'),
            SizedBox(height: 2),
            Text(
                'Entire Agreement and Amendments: This Agreement constitutes the entire agreement between us and supersedes all earlier and simultaneous agreements regarding the subject matter hereof.'),
            SizedBox(height: 2),
            Text(
                'No Waivers, Cumulative Remedies: Our failure to insist upon strict performance of any provision of this Agreement is not a waiver of any of our rights under this Agreement. All of our remedies under this Agreement, at Law or in equity, are cumulative and nonexclusive.'),
            SizedBox(height: 2),
            Text(
                'Severability: If any portion of this Agreement is held to be unenforceable, the unenforceable portion must be construed as nearly as possible to reflect our original intent, the remaining portions remain in full force and effect, and the unenforceable portion remains enforceable in all other contexts and jurisdictions.'),
            SizedBox(height: 2),
            Text(
                'Captions and Plural Terms: All captions are for purposes of convenience only and are not to be used in interpretation or enforcement of this Agreement. Terms defined in the singular have the same meaning in the plural and vice versa.'),
            SizedBox(height: 10),
            Text('17. FINAL PROVISIONS'),
            SizedBox(height: 5),
            Text(
                '17.1 Should a provision be or become void, the remaining provisions will remain in effect. The ineffective provision will be replaced by an effective provision that is as economically similar as possible.'),
            SizedBox(height: 5),
            Text(
                '17.2 Special agreements and side agreements must be made in writing to be effective. This written form requirement can only be deviated from by written agreement. Changes and additions to the present conditions are only effective if they are confirmed by us in writing.'),
            SizedBox(height: 5),
            Text(
                '17.3 German law applies exclusively to all legal relationships between ArtCraftLiving and the user, even if the user is based abroad, excluding the UN sales law.'),
            SizedBox(height: 5),
            Text(
                '17.4 The place of jurisdiction is Hamburg as far as permissible.'),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
