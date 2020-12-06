import 'package:flutter/material.dart';

class HowToUse extends StatefulWidget {
  HowToUse({Key key}) : super(key: key);

  @override
  _HowToUseState createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'How to use this App',
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
              'Our commitment',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
                'Our goal is to support and promote artists worldwide. In this respect, we fund all art transactions “transactions” in the app with part of the income received from our paid services. As an art supporter, you will not have to spend your money for the works you purchase “collect” on our platform. Instead, we will reward your support of other artists by paying you a bonus “bonus” for every art you collect.'),
            SizedBox(height: 10),
            Text(
              'Reviews and Points ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
                'We encourage and support your activities and transactions on the app by paying you real currency for your sold works and also for collecting the works of other artists. To collect any artwork, you must first collect 100 points “points” by leaving reviews “reviews” on the artworks of other users. One Point is awarded for every first Review left on a user’s profile. Once you have collected 100 points, you must use the points immediately to purchase an artwork. You will find your point balance in the Collected Points section on your profile. '),
            SizedBox(height: 10),
            Text(
              'Bonus ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              'We will pay you a 5-Euro-bonus (or equivalent in your currency) for every artwork you collect with 100 Points. To receive your bonus, you must follow the instructions under the Payment section on your profile and send us a photo “photo” of the received artwork hanging on a wall in its new home.',
            ),
            SizedBox(height: 10),
            Text(
              'Payments for sales ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              'To receive a Payment from us for your sold work, you must follow the instructions under the Payment section on your profile and must send us the a screenshot of the delivery confirmation. You must only Review artworks you feel positive about and you must ensure that your Reviews are not defamatory, negative, discouraging, demotivating, mean or rude in any way or form. By posting a Review and uploading a photo of a purchased work hanging on a wall in its new home, you give us, and the artist unrestricted permission to use your review and photo for promotional purposes.',
            ),
            SizedBox(height: 10),
            Text(
              'Artwork, Pricing, Transactions, and Refunds. ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              'You agree to post only small-sized artworks such as paintings, drawings, studies, art prints. By posting artworks, you assure that you are the sole owner of all rights to the works. You must specify the price, technique, year and title when uploading an artwork. The stated price of artwork must not exceed 100 Euros (or equivalent in your currency). The price must be in gross pricing (inclusive of transportation cost and all relevant taxes). You are responsible for organizing and paying for the delivery of your sold artwork to the collector. Sold artworks must be sent off to the collector within five days after purchase and you must keep a tracking record of the delivery. You must send us the delivery confirmation in order to receive a payment from us. All purchases are closed to returns and refunds. You are not entitled to a refund of used points. You have the right to return the artwork back to the artist if it does not meet your expectations but you will be responsible for the return-costs and the used-up points will not be recovered.',
            ),
            SizedBox(height: 10),
            Text(
              'Please read our FAQ before sending us a message.',
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
