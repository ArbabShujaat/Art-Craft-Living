import 'dart:async';
import 'dart:io';
import 'package:artCraftLiving/login/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/store_kit_wrappers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'consumable_store.dart';

// Original code link: https://github.com/flutter/plugins/blob/master/packages/in_app_purchase/example/lib/main.dart

const bool kAutoConsume = true;
bool _isLoading = false;
const String _kConsumableId = '';
const String _kSubscriptionId = '';
const List<String> _kProductIds = <String>[
  _kConsumableId,
  'noadforfifteendays',
  _kSubscriptionId
];

// TODO: Please Add your android product ID here
const List<String> _kAndroidProductIds = <String>[''];
//Example
//const List<String> _kAndroidProductIds = <String>[
//  'ADD_YOUR_ANDROID_PRODUCT_ID_1',
//  'ADD_YOUR_ANDROID_PRODUCT_ID_2',
//  'ADD_YOUR_ANDROID_PRODUCT_ID_3'
//];

// TODO: Please Add your iOS product ID here
const List<String> _kiOSProductIds = <String>['arcraftLivingBuyApp'];
//Example
//const List<String> _kiOSProductIds = <String>[
//  'ADD_YOUR_IOS_PRODUCT_ID_1',
//  'ADD_YOUR_IOS_PRODUCT_ID_2',
//  'ADD_YOUR_IOS_PRODUCT_ID_3'
//];

class PaymentMain extends StatefulWidget {
  @override
  _PaymentMainState createState() => _PaymentMainState();
}

class _PaymentMainState extends State<PaymentMain> {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  bool _loadingbutton = false;
  String _queryProductError;

  @override
  void initState() {
    DateTime currentDate = DateTime.now();
    DateTime noADDate;

    var fiftyDaysFromNow = currentDate.add(new Duration(days: 50));
    print(
        '${fiftyDaysFromNow.month} - ${fiftyDaysFromNow.day} - ${fiftyDaysFromNow.year} ${fiftyDaysFromNow.hour}:${fiftyDaysFromNow.minute}');

    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();

    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(Platform.isIOS
            ? _kiOSProductIds.toSet()
            : _kAndroidProductIds.toSet()); //_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
        await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(30),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: [
                        SizedBox(height: 20),
                        Image(
                          image: AssetImage('assets/logo.jpeg'),
                          height: 150,
                        ),

                        SizedBox(height: 20),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[100],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "By proceeding with payment, you agree that all fees are non-refundable and non-cancellable once access is gained into our platform.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        // Container(
                        //   child: RaisedButton(
                        //     padding: EdgeInsets.fromLTRB(80, 2, 80, 2),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(5.0)),
                        //     color: Colors.blue,
                        //     textColor: Colors.white,
                        //     child: Text(
                        //       'Proceed',
                        //       style: TextStyle(fontSize: 17),
                        //     ),
                        //     onPressed: () async {},
                        //   ),
                        // ),
                      ],
                    ),
            ),
            _buildProductList(),
            // _buildConsumableBox(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: stack,
        ),
      ),
    );
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return Card(child: ListTile(title: const Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable ? Colors.green : ThemeData.light().errorColor),
      title: Text(
          'The store is ' + (_isAvailable ? 'available' : 'unavailable') + '.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll([
        Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  Card _buildProductList() {
    if (_loading) {
      return Card(
          child: Center(
        child: (ListTile(
            leading: CircularProgressIndicator(), title: Text('Loading'))),
      ));
    }
    if (!_isAvailable) {
      return Card();
    }
    final ListTile productHeader = ListTile(title: Text('Proceed'));
    List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verity the purchase data.
    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        PurchaseDetails previousPurchase = purchases[productDetails.id];
        return ListTile(
          title: previousPurchase != null
              ? Container(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _loadingbutton = true;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                      setState(() {
                        _loadingbutton = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _loadingbutton
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "Proceed",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                )
              : ListTile(
                  title: Text(
                    productDetails.title,
                  ),
                  subtitle: Text(
                    productDetails.description,
                  ),
                  trailing: FlatButton(
                    child: Text(productDetails.price),
                    color: Colors.green[800],
                    textColor: Colors.white,
                    onPressed: () {
                      PurchaseParam purchaseParam = PurchaseParam(
                          productDetails: productDetails,
                          applicationUserName: null,
                          sandboxTesting: false);

                      setState(() {
                        _isLoading = true;
                      });

                      _connection
                          .buyConsumable(
                              purchaseParam: purchaseParam,
                              autoConsume: kAutoConsume || Platform.isIOS)
                          .whenComplete(() => {
                                // _consumables.map((String id) {
                                //   consume(id);
                                // }).toList(),

                                print("Complete ")
                              })
                          .catchError((e) {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: Colors.blue[400],
                                  )),
                              title: Text("Error"),
                              content: Text("PaymentFailed"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.blue[400]),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                      });

                      setState(() {
                        _isLoading = false;
                      });
                      // if (productDetails.id == _kConsumableId) {
                      //   _connection.buyConsumable(
                      //       purchaseParam: purchaseParam,
                      //       autoConsume: kAutoConsume || Platform.isIOS);
                      // } else {
                      //   _connection.buyNonConsumable(
                      //       purchaseParam: purchaseParam);
                      // }
                    },
                  )),
        );
      },
    ));

    return Card(child: Column(children: <Widget>[Divider()] + productList));
  }

  Card _buildConsumableBox() {
    if (_loading) {
      return Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching consumables...'))));
    }
    if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
      return Card();
    }
    final ListTile consumableHeader =
        ListTile(title: Text('Purchased consumables'));
    final List<Widget> tokens = _consumables.map((String id) {
      return GridTile(
        child: IconButton(
          icon: Icon(
            Icons.stars,
            size: 42.0,
            color: Colors.orange,
          ),
          splashColor: Colors.yellowAccent,
          onPressed: () => consume(id),
        ),
      );
    }).toList();
    return Card(
        child: Column(children: <Widget>[
      consumableHeader,
      Divider(),
      GridView.count(
        crossAxisCount: 5,
        children: tokens,
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
      )
    ]));
  }

  Future<void> consume(String id) async {
    print('consume id is $id');
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    print('deliverProduct'); // Last
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID);
      List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    print('_verifyPurchase');
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    print('_handleInvalidPurchase');
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    print('_listenToPurchaseUpdated');
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            await InAppPurchaseConnection.instance
                .consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }
}
