// import 'dart:convert';

// import 'package:artCraftLiving/Model/model.dart';
// import 'package:artCraftLiving/login/buyapp.dart';
// import 'package:artCraftLiving/profiles/after_signup.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class StripeTransactionResponse {
//   String message;
//   bool success;

//   StripeTransactionResponse({this.message, this.success});
// }

// class StripeService {
//   static String apiBase = 'https://api.stripe.com/v1';
//   static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
//   static String secret =
//       "sk_test_51HiYXtCoCrv2hNUUj8PwyoPJbZbHLWXBsFLL4v4VHMifY3yY3Q8CCa94tcyvtput9rCC6hMSjbNs9e34QlxRCtl700fdf2tkCZ";
//   static Map<String, String> headers = {
//     'Authorization': "Bearer ${StripeService.secret}",
//     'Content-Type': 'application/x-www-form-urlencoded'
//   };

//   ///Stripe service initializer
//   // static init() {

//   // }
// //
// //  static StripeTransactionResponse payViaExistingCard(
// //      {String amount, String currency, card}) {
// //    return StripeTransactionResponse(
// //        message: 'Transaction successful', success: true);
// //  }

//   ///Payment via new cart Function operator
//   static Future<StripeTransactionResponse> payViaNewCard(
//       {String amount, String currency, BuildContext context}) async {
//     try {
//       var paymentMethod = await StripePayment.paymentRequestWithCardForm(
//           CardFormPaymentRequest());
//       var paymentIntent = await StripeService.createPaymentIntent(
//           amount: amount, currency: currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: paymentIntent['client_secret'],
//           paymentMethodId: paymentMethod.id));
//       if (response.status == 'succeeded') {
//         var prefs = await SharedPreferences.getInstance();
//         final userData = json.encode(
//           {
//             'userEmail': userDetails.userEmail,
//             'userUid': userDetails.userUid,
//             'password': "",
//           },
//         );
//         prefs.setString('userData', userData);
//         payLoading = false;
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => AfterSignup()));
//         // return StripeTransactionResponse(
//         //     message: 'Transaction successful', success: true);
//       } else {
//         return StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (err) {
//       return StripeService.getPlatformExceptionErrorResult(err);
//     } catch (err) {
//       return StripeTransactionResponse(
//           message: 'Transaction failed: ' + err.toString(), success: false);
//     }
//   }

//   ///Payment Intent Creater
//   static Future<Map<String, dynamic>> createPaymentIntent(
//       {String amount, String currency}) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       var response = await http.post(StripeService.paymentApiUrl,
//           body: body, headers: StripeService.headers);

//       return jsonDecode(response.body);
//     } catch (err) {
//       print('Error charing user: ${err.toString()}');
//     }
//     return null;
//   }

//   ///platform exception handler
//   static getPlatformExceptionErrorResult(err) {
//     String message = 'Something went wrong';
//     if (err.code == 'cancelled') {
//       message = 'Transaction cancelled';
//     }

//     return new StripeTransactionResponse(message: message, success: false);
//   }
// }
