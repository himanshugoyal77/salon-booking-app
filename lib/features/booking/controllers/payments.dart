// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// class PaymentControllere {
//   Future<void> makePayment() async {
//     try {
//       //STEP 1: Create Payment Intent
//       var paymentIntent = await createPaymentIntent('100', 'USD');

//       //STEP 2: Initialize Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   paymentIntentClientSecret: paymentIntent![
//                       'client_secret'], //Gotten from payment intent
//                   style: ThemeMode.light,
//                   merchantDisplayName: 'Ikay'))
//           .then((value) {});

//       //STEP 3: Display Payment sheet
//       displayPaymentSheet();
//     } catch (err) {
//       throw Exception(err);
//     }
//   }

//   createPaymentIntent(String amount, String currency) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };

//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) {
//         //Clear paymentIntent variable after successful payment
//         var paymentIntent = null;
//       }).onError((error, stackTrace) {
//         throw Exception(error);
//       });
//     } on StripeException catch (e) {
//       print('Error is:---> $e');
//     } catch (e) {
//       print('$e');
//     }
//   }

  
// }
