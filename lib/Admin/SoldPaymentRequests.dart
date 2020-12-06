import 'package:artCraftLiving/Model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SoldPaymentRequests extends StatefulWidget {
  @override
  _SoldPaymentRequestsState createState() => _SoldPaymentRequestsState();
}

class _SoldPaymentRequestsState extends State<SoldPaymentRequests> {
  bool _loading = true;
  @override
  Future<void> didChangeDependencies() async {
    listpaymentRequestSold.clear();
    await FirebaseFirestore.instance
        .collection("PaymentRequestsSold")
        .where('accepted', isEqualTo: false)

        // ignore: deprecated_member_use
        .getDocuments()
        .then((value) => {
              for (int i = 0; i < value.documents.length; i++)
                listpaymentRequestSold.add(PaymentRequestSold(
                    pics: value.documents[i]["imageUrls"],
                    paypalAccount: value.documents[i]["paypalAccount"],
                    amount: value.documents[i]["amount"],
                    time: value.documents[i]["time"],
                    userUid: value.documents[i]["userUid"],
                    userDocid: value.documents[i]["userUid"],
                    accepted: value.documents[i]["accepted"],
                    docid: value.documents[i].documentID))
            });
    setState(() {
      _loading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payments requests of sellers',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: listpaymentRequestSold.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height / 2.5,
                          width: width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Carousel(
                              overlayShadow: false,
                              dotBgColor: Colors.transparent,
                              autoplay: false,
                              dotIncreaseSize: 3,
                              dotSize: 5,
                              dotIncreasedColor: Colors.white,
                              dotColor: Colors.black,
                              images: [
                                for (int i = 0;
                                    i <
                                        listpaymentRequestSold[index]
                                            .pics
                                            .length;
                                    i++)
                                  Container(
                                    child: CachedNetworkImage(
                                      // height: 200,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          listpaymentRequestSold[index].pics[i],
                                      placeholder: (context, url) => Center(
                                          child:
                                              new CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          var url = listpaymentRequestSold[index].paypalAccount;

                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              universalLinksOnly: true,
                            );
                          } else {
                            throw 'There was a problem to open the url: $url';
                          }
                        },
                        title: Text('PayPalAccountLink'),
                        subtitle:
                            Text(listpaymentRequestSold[index].paypalAccount),
                      ),
                      ListTile(
                        title: Text('Ammount to be transfered'),
                        subtitle: Text(listpaymentRequestSold[index].amount),
                      ),
                      Row(
                        children: [
                          FlatButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .where('userUid',
                                        isEqualTo: listpaymentRequestSold[index]
                                            .userUid)
                                    .getDocuments()
                                    .then((value) async => {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .document(
                                                  listpaymentRequestSold[index]
                                                      .userDocid)
                                              .update({
                                            'soldCredit': (int.parse(
                                                        value.documents[0]
                                                            ['soldCredit']) +
                                                    int.parse(
                                                        listpaymentRequestSold[
                                                                index]
                                                            .amount))
                                                .toString(),
                                          }),
                                        });

                                await FirebaseFirestore.instance
                                    .collection('PaymentRequestsSold')
                                    .document(
                                        listpaymentRequestSold[index].docid)
                                    .update({
                                  'accepted': true,
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SoldPaymentRequests()),
                                );
                              },
                              child: Text(
                                "Decline",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red),
                              )),
                          FlatButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('PaymentRequestsSold')
                                    .document(
                                        listpaymentRequestSold[index].docid)
                                    .update({
                                  'accepted': true,
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SoldPaymentRequests()),
                                );
                              },
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Divider(
                          height: 10,
                          thickness: 10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }),
      ),
    );
  }
}
