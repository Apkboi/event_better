import 'package:flutter/material.dart';
class CustomButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.child, required this.onPressed}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ElevatedButton(onPressed: widget.onPressed, child: widget.child ,style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(18)),)),
      ],
    );
  }
}
