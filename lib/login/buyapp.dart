import 'dart:convert';
import 'dart:io';

import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/login/inapp_payment_provider.dart';
import 'package:artCraftLiving/login/sign_up.dart';
import 'package:artCraftLiving/profiles/after_signup.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Payment.dart';

bool payLoading = false;
bool payLoading2 = false;

class BuyApp extends StatefulWidget {
  BuyApp({Key key}) : super(key: key);

  @override
  _BuyAppState createState() => _BuyAppState();
}

class _BuyAppState extends State<BuyApp> {
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  void _buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);

    _iap.buyConsumable(purchaseParam: purchaseParam).catchError(() {
      showDialog(
          context: context,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text("Payment Failed"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red[400]),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ));
    }).whenComplete(() async => {});
  }

  @override
  Future<void> initState() {
    var provider = Provider.of<ProviderModel>(context, listen: false);
    provider.initialize();

//    StripePayment.setOptions(StripeOptions(
//        publishableKey:
//            'pk_test_51HiYXtCoCrv2hNUUPWqVBLhTVbE0b5hAT4ipR5ziekX3hT2hc0c6nrdbBN52EwR5sRvlxZRBKuAvzbcygreW9OEr00b3an3E4v',
//        merchantId: 'test',
//        androidPayMode: 'test'));
    super.initState();
  }

  @override
  void dispose() {
    var provider = Provider.of<ProviderModel>(context, listen: false);
    provider.subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Image(
              image: AssetImage('assets/logo.jpeg'),
              height: 150,
            ),
            SizedBox(height: 30),
            for (var prod in provider.products)
              if (provider.hasPurchased(prod.id) != null) ...[
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          'Payment Successful',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: payLoading2
                      ? Center(child: CircularProgressIndicator())
                      : RaisedButton(
                          padding: EdgeInsets.fromLTRB(80, 2, 80, 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text(
                            'Proceed',
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: () async {
                            setState(() {
                              payLoading2 = true;
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                            setState(() {
                              payLoading2 = false;
                            });

//                        StripeTransactionResponse response =
//                            await StripeService.payViaNewCard(
//                                amount: (9.98 * 100).toStringAsFixed(0),
//                                currency: 'USD',
//                                context: context);
//                        if (response.success == false) {
//                          showDialog(
//                              context: context,
//                              child: AlertDialog(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(18.0),
//                                    side: BorderSide(
//                                      color: Colors.red[400],
//                                    )),
//                                title: Text(response.message),
//                                actions: <Widget>[
//                                  FlatButton(
//                                    child: Text(
//                                      "OK",
//                                      style: TextStyle(color: Colors.red[400]),
//                                    ),
//                                    onPressed: () {
//                                      Navigator.pop(context);
//                                    },
//                                  )
//                                ],
//                              ));
//                          throw Exception;
//                        }
                          },
                        ),
                ),
              ] else ...[
                // Container(
                //   height: 60,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.blue[100],
                //   ),
                //   child: Center(
                //     child: Column(
                //       children: [
                //         SizedBox(height: 15),
                //         Text(
                //           'One-Time purchase',
                //           style: TextStyle(
                //               fontSize: 18,
                //               color: Colors.blue[900],
                //               fontWeight: FontWeight.bold),
                //         ),
                //         Text(
                //           '9.98 €',
                //           style: TextStyle(
                //               fontSize: 18,
                //               color: Colors.blue[900],
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Please proceed to the offer page where the price for access will be displayed. Please note that all fees are non-refundable and cancellable once access is gained to our platform .",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: payLoading
                      ? Center(child: CircularProgressIndicator())
                      : RaisedButton(
                          padding: EdgeInsets.fromLTRB(80, 2, 80, 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text(
                            'Proceed',
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: () async {
                            setState(() {
                              payLoading = true;
                            });
                            var prefs = await SharedPreferences.getInstance();
                            _buyProduct(prod);
//                        StripeTransactionResponse response =
//                            await StripeService.payViaNewCard(
//                                amount: (9.98 * 100).toStringAsFixed(0),
//                                currency: 'USD',
//                                context: context);
//                        if (response.success == false) {
//                          showDialog(
//                              context: context,
//                              child: AlertDialog(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(18.0),
//                                    side: BorderSide(
//                                      color: Colors.red[400],
//                                    )),
//                                title: Text(response.message),
//                                actions: <Widget>[
//                                  FlatButton(
//                                    child: Text(
//                                      "OK",
//                                      style: TextStyle(color: Colors.red[400]),
//                                    ),
//                                    onPressed: () {
//                                      Navigator.pop(context);
//                                    },
//                                  )
//                                ],
//                              ));
//                          throw Exception;
//                        }
                          },
                        ),
                ),
              ]
          ],
        ),
      ),
    );
  }
}
