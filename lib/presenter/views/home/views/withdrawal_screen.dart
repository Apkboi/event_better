import 'package:flutter/material.dart';
import 'package:square_tickets/helpers/app_utils.dart';
import 'package:square_tickets/presenter/widgets/custom_button.dart';
import 'package:square_tickets/presenter/widgets/outlined_form_field.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({Key? key,  required this.balance}) : super(key: key);
  final int balance;

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw Funds'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'YOUR BALANCE',
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$${widget.balance}',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(
              height: 20,
            ),
            const OutlinedFormField(hint: 'Amount'),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  Future.delayed(const Duration(seconds: 3)).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    CustomSnackBar.show(context, message: 'Withdrawal Request Sent');
                  });
                },
                child: !isLoading
                    ? const Text('Withdraw')
                    : const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      ))
          ],
        ),
      ),
    );
  }
}
