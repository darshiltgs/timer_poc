import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay _razorpay = Razorpay();
  var options = {
    'key': 'rzp_test_n8uzw7tSAaGRrf',
    'amount': 100,
    'name': 'Acme Corp.',
    'order_id': 'order_MfK77Dh9LtvdK6',
    'description': 'Fine T-Shirt',
    'retry': {'enabled': true, 'max_count': 1},
    'send_sms_hash': true,
    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
  };

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("{Payment ID: ${response.paymentId}, Signature: ${response.signature}, OrderId: ${response.signature}}");
    showAlertDialog(context, "Payment Successful",
        "{Payment ID: ${response.paymentId}, Signature: ${response.signature}, OrderId: ${response.signature}}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MaterialButton(
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
                _razorpay.on(
                    Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
                _razorpay.on(
                    Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
                _razorpay.open(options);
              },
              child: const Text("Make Payment"),
            ),
          ),
        ],
      )),
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
