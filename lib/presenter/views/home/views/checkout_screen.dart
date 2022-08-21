import 'package:flutter/material.dart';
import '../widgets/checkout_webview.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.url, required this.onSuccess}) : super(key: key);
  final String url;
 final  VoidCallback onSuccess;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
      SizedBox(
        height: 20,
      ),
      SizedBox(
        height: 10,
      ),
      // Expanded(
      //     child: WebViewExample(
      //   url: widget.url, onSuccess: () {
      //
      //     }, ticket: null,
      //
      // ))
    ]));
  }
}
