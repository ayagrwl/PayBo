import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Donation extends StatefulWidget {
  final String d;
  Donation(this.d);
  @override
  _DonationState createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  Razorpay _razorpay;
  final name = TextEditingController();
  final email = TextEditingController();
  final number = TextEditingController();
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Bo'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 125,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 5,
                child: Center(
                  child: Text('Donation for ' + widget.d),
                ),
              ),
            ),
          ),
          Container(
              width: 300,
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: 'Enter Your Name',
                ),
              )),
          Container(
            width: 300,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Enter Your E-mail',
              ),
            ),
          ),
          Container(
            width: 300,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: number,
              decoration: InputDecoration(
                hintText: 'Enter Your Mobile',
              ),
            ),
          ),
          Container(
            width: 300,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: amount,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
              ),
            ),
          ),
          ElevatedButton(onPressed: openCheckout, child: Text('Pay Now'))
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_bQuZ77m8aNIUJk',
      'amount': num.parse(amount.text) * 100,
      'name': 'Student Gymkhana',
      'description': widget.d,
      'prefill': {'contact': number.text, 'email': email.text},
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
    );
  }
}
