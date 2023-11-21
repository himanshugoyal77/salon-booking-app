import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:salon_app/features/booking/widgets/divider.dart';
import 'package:salon_app/utils/ui/styles.dart';

import '../../utils/ui/text.dart';
import 'package:http/http.dart' as http;

const List<String> paymentMethods = [
  "Cash",
  "Credit Card",
  "Debit Card",
  "Paypal",
];

List<Map<String, dynamic>> unselectedServices = [
  {
    "id": 0,
    "price": 49.99,
    "service": "Haircut",
  },
  {
    "id": 1,
    "price": 69.99,
    "service": "Hair Color",
  },
  {
    "id": 2,
    "price": 29.99,
    "service": "Manicure",
  },
  {
    "id": 3,
    "price": 49.99,
    "service": "Pedicure",
  },
  {
    "id": 4,
    "price": 9.99,
    "service": "Nail Art",
  },
];

class BookingSummary extends StatefulWidget {
  const BookingSummary(
      {super.key,
      required this.name,
      required this.id,
      required this.services,
      required this.selectedServices,
      required this.date,
      required this.time});

  final String name;
  final int id;
  final List services;
  final List selectedServices;
  final String date;
  final String time;

  @override
  State<BookingSummary> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  String dropdownValue = paymentMethods.first;

  double findTotal() {
    double total = 0;
    for (var i = 0; i < widget.selectedServices.length; i++) {
      total += unselectedServices[widget.selectedServices[i]]["price"];
    }
    return total;
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));
        var paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('error is in displayPaymentSheet:');
      print('$e');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      print('error is in createPaymentIntent:');
      throw Exception(err.toString());
    }
  }

  Future<void> makePayment() async {
    try {
      Map<String, dynamic>? paymentIntent =
          await createPaymentIntent('100', 'INR');
      print('paymentIntent: $paymentIntent');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: 'IN', currencyCode: 'INR', testEnv: true);
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay',
                  googlePay: gpay))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print('error is in makePayment:');
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("secret ${dotenv.env['STRIPE_SECRET']}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Styles.primaryColor,
          ),
        ),
        title: Text(
          "Booking Summary",
          style: AppTextStyles.bodyRegularBold
              .copyWith(fontSize: 16, color: Styles.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/artists/a1.jpg'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppTextStyles.bodyRegularBold
                          .copyWith(fontSize: 16, color: Styles.primaryColor),
                    ),
                    Text(
                      widget.services.join(", "),
                      style: AppTextStyles.bodyExtraSmall
                          .copyWith(fontSize: 12, color: Styles.textGray),
                    ),
                  ],
                ),
                //  Spacer(),
              ],
            ),
            const CustomDivider(),
            Text(
              "OVERVIEW",
              style: AppTextStyles.bodyExtraSmall,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Styles.secondaryColor,
                        ),
                        child: Icon(
                          CupertinoIcons.calendar,
                          size: 24,
                          color: Styles.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.date,
                            style: AppTextStyles.bodyExtraSmall,
                          ),
                          Text(
                            widget.time,
                            style: AppTextStyles.bodySmallBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Styles.secondaryColor,
                        ),
                        child: Icon(
                          Icons.map_outlined,
                          size: 24,
                          color: Styles.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style: AppTextStyles.bodyExtraSmall,
                          ),
                          Text(
                            "Clinic",
                            style: AppTextStyles.bodySmallBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "ADDRESS",
              style: AppTextStyles.bodyExtraSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget augue nec massa volutpat aliquam. Nunc eget augue nec massa volutpat aliquam.",
              style: AppTextStyles.bodyExtraSmall,
            ),
            const CustomDivider(),
            Text(
              "PAYMENT",
              style: AppTextStyles.bodyExtraSmall,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Styles.secondaryColor,
                  ),
                  child: Icon(
                    CupertinoIcons.creditcard,
                    size: 24,
                    color: Styles.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style: AppTextStyles.bodySmall,
                    ),
                    DropdownButton<dynamic>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 0,
                      style: TextStyle(color: Styles.primaryColor),
                      underline: Container(
                        height: 2,
                        color: Colors.transparent,
                      ),
                      autofocus: true,
                      isDense: true,
                      focusColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value.toString();
                        });
                      },
                      items: paymentMethods
                          .map<DropdownMenuItem<dynamic>>((dynamic value) {
                        return DropdownMenuItem<dynamic>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "SELECTED SERVICES",
              style: AppTextStyles.bodyExtraSmall,
            ),
            const SizedBox(height: 10),
            ...widget.selectedServices
                .map((e) => Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 5),
                    color: Colors.grey[100],
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      dense: true,
                      leading: Text(
                        unselectedServices[e]["service"],
                        style: AppTextStyles.bodySmall,
                      ),
                      trailing: Text(
                        "\$ ${unselectedServices[e]["price"]}",
                        style: AppTextStyles.bodySmallBold,
                      ),
                    )))
                .toList(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    "Total",
                    style: AppTextStyles.bodySmall,
                  ),
                  const Spacer(),
                  Text(
                    "\$ ${findTotal().toStringAsFixed(2)}",
                    style:
                        AppTextStyles.bodySmallBold.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CustomDivider(),
            dropdownValue == 'Cash'
                ? Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await makePayment();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Styles.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Confirm Booking"),
                    ),
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Styles.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Pay Now"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
