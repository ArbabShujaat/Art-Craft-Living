// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'inapp_payment_provider.dart';
// import 'package:artCraftLiving/login/sign_up.dart';

// class BuyApp extends StatefulWidget {
//   BuyApp({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _BuyAppState createState() => new _BuyAppState();
// }

// class _BuyAppState extends State<BuyApp> {
//   static const String iapId = 'android.test.purchased';
//   List<IAPItem> _items = [];

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   Future<void> initPlatformState() async {
//     // prepare
//     var result = await FlutterInappPurchase.initConnection;
//     print('result: $result');

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     // refresh items for android
//     String msg = await FlutterInappPurchase.consumeAllItems;
//     print('consumeAllItems: $msg');
//     await _getProduct();
//   }

//   Future<Null> _getProduct() async {
//     List<IAPItem> items = await FlutterInappPurchase.getProducts([iapId]);
//     for (var item in items) {
//       print('${item.toString()}');
//       this._items.add(item);
//     }

//     setState(() {
//       this._items = items;
//     });
//   }

//   Future<Null> _buyProduct(IAPItem item) async {
//     try {
//       PurchasedItem purchased =
//           await FlutterInappPurchase.buyProduct(item.productId)
//               .whenComplete(() => {
//                     signUp(context),
//                   });
//       print(purchased);
//       String msg = await FlutterInappPurchase.consumeAllItems;
//       print('consumeAllItems: $msg');
//     } catch (error) {
//       print('$error');
//     }
//   }

//   List<Widget> _renderButton() {
//     List<Widget> widgets = this
//         ._items
//         .map(
//           (item) => Container(
//             height: 250.0,
//             width: double.infinity,
//             child: Card(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 28.0),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Banana',
//                       style: Theme.of(context).textTheme.display1,
//                     ),
//                   ),
//                   SizedBox(height: 24.0),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'This is a consumable item',
//                       style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text('Which you can buy multiple times',
//                         style:
//                             TextStyle(fontSize: 16.0, color: Colors.grey[700])),
//                   ),
//                   SizedBox(height: 24.0),
//                   SizedBox(
//                     width: 340.0,
//                     height: 50.0,
//                     child: RaisedButton(
//                       color: Colors.blue,
//                       onPressed: () => _buyProduct(item),
//                       shape: new RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(30.0)),
//                       child: Text(
//                         'Buy ${item.price} ${item.currency}',
//                         style: Theme.of(context).primaryTextTheme.button,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//         .toList();
//     return widgets;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProviderModel>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.all(30),
//         child: ListView(
//           children: [
//             SizedBox(height: 20),
//             Image(
//               image: AssetImage('assets/logo.jpeg'),
//               height: 150,
//             ),
//             SizedBox(height: 30),
//             for (var prod in provider.products)
//               if (provider.hasPurchased(prod.id) != null) ...[
//                 Container(
//                   height: 60,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.blue[100],
//                   ),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 15),
//                         Text(
//                           'One-Time purchase',
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.blue[900],
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           '9.98 €',
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.blue[900],
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 100,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.blue[100],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(
//                       'By proceeding to payment, you agree that all fees are non-refundable and non-cancellable once access is gained into our platform. Do you still wish to proceed?',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blue[900],
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   child: Column(children: this._renderButton()),
//                 ),
//               ] else ...[
//                 Container(
//                   height: 60,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.blue[100],
//                   ),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 15),
//                         Text(
//                           'One-Time purchase',
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.blue[900],
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           '9.98 €',
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.blue[900],
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 100,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.blue[100],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(
//                       'By proceeding to payment, you agree that all fees are non-refundable and non-cancellable once access is gained into our platform. Do you still wish to proceed?',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blue[900],
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   child: Column(children: this._renderButton()),
//                 ),
//               ]
//           ],
//         ),
//       ),
//     );
//   }
// }
