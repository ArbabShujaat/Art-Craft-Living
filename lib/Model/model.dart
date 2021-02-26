import 'package:flutter/material.dart';

UserDetails userDetails;
List<UserDetails> listUserDetail = [];
List<UserDetails> supportersList = [];

///User
class UserDetails {
  final String userEmail;
  final String about;
  final String userUid;
  final String userpic;
  final String username;
  final String userDocid;
  final String instagram;
  bool verified;

  bool firstTime;

  String bonusCredit;
  String soldCredit;
  String points;

  UserDetails({
    @required this.userEmail,
    @required this.userDocid,
    @required this.about,
    @required this.instagram,
    @required this.verified,
    @required this.firstTime,
    @required this.bonusCredit,
    @required this.soldCredit,
    @required this.points,
    @required this.userUid,
    @required this.username,
    @required this.userpic,
  });
}

//Artwork
ArtWorks artwork;

List<ArtWorks> listArtWorkDetail = [];

class ArtWorks {
  List pics;
  final String tittle;
  final String size;
  final String technique;
  final String year;
  final String aboutArt;
  final String userUid;
  final String userDocid;
  final String price;
  final String docId;
  final String buyerdocId;
  final String buyeruserUid;
  final bool sold;

  ArtWorks({
    @required this.pics,
    @required this.tittle,
    @required this.docId,
    @required this.size,
    @required this.buyerdocId,
    @required this.buyeruserUid,
    @required this.technique,
    @required this.year,
    @required this.aboutArt,
    @required this.userUid,
    @required this.userDocid,
    @required this.price,
    @required this.sold,
  });
}

//////soldartworkPaymentRequest
PaymentRequestSold paymentRequestSold;

List<PaymentRequestSold> listpaymentRequestSold = [];

class PaymentRequestSold {
  List pics;

  final String time;
  final String paypalAccount;
  final String userUid;
  final String userDocid;
  final String amount;
  final String docid;
  final bool accepted;

  PaymentRequestSold({
    @required this.pics,
    @required this.time,
    @required this.accepted,
    @required this.paypalAccount,
    @required this.userUid,
    @required this.userDocid,
    @required this.docid,
    @required this.amount,
  });
}

//////FAQs Questions////
FAQs faqs;

List<FAQs> faqsList = [];

class FAQs {
  final String question;
  final String answer;
  final String docid;

  FAQs({
    @required this.question,
    @required this.answer,
    @required this.docid,
  });
}
