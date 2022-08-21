import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

class FilledTextField extends StatefulWidget {
  final String hint;
  final Widget? suffix;
  final Widget? preffix;
  final int? maxLine;
  final TextInputType? inputType;
 final String? Function(String?)? validator;

  const FilledTextField({Key? key, required this.hint, this.suffix, this.validator, this.preffix, this.maxLine, this.inputType}) : super(key: key);

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: TextFormField(
        validator: widget.validator ,
        maxLines: widget.maxLine ,
        keyboardType:widget.inputType ,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        decoration: InputDecoration(
            filled: true,

            border: OutlineInputBorder(
                gapPadding: 2,
                borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
            fillColor: Theme.of(context).cardColor,
            hintText: widget.hint,
            suffixIcon: widget.suffix,
            prefixIcon: widget.preffix,
            prefixIconColor: Colors.blueGrey,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            suffixIconColor: Theme.of(context).colorScheme.primary,
            hintStyle: TextStyle(color: Colors.grey.shade500)),
      ),
    );
  }
}
