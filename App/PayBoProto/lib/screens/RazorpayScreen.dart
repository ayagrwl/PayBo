import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class RazorpayScreen extends StatefulWidget {
  final String name, email, number, amount, description;
  final int cid, subid;
  RazorpayScreen(this.name, this.email, this.number, this.amount, this.cid,
      this.subid, this.description);
  @override
  _RazorpayScreenState createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  Razorpay _razorpay;

  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'PayBo',
            style: TextStyle(fontSize: 25.0),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            "Return back",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ));
  }

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_jbNfQ5xTNrmGw1',
      'amount': num.parse(widget.amount) * 100,
      'name': widget.name,
      'description': widget.description,
      'prefill': {'contact': widget.number, 'email': widget.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment Successful...");
    String name = widget.name;
    int cat = widget.cid;
    int subcat = widget.subid;
    String amount = widget.amount;
    String description = widget.description;
    String email = widget.email;
    /* String uri = 'https://payboproto.herokuapp.com/donate?name=$name';
    var res = http.get(uri);

    if (res != null) {
      Fluttertoast.showToast(msg: "Successful");
      Navigator.pop(context);
    } */
    Map data = {
      'donor': name,
      'cat': cat,
      'subcat': subcat,
      'amount': amount,
      'cause': description,
      'email': email,
    };
    String body = json.encode(data);
    String uri = 'https://payboproto.herokuapp.com/donate';
    http.Response res = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (res != null) {
      Fluttertoast.showToast(
          msg: "Transaction Details added to the database...");
      Navigator.pop(context);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Failed...",
    );
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg:
          "Sorry, wallet facility not available now, try another medium of payment...",
    );
    Navigator.pop(context);
  }
}
