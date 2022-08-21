import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
class PaymentOptionCard extends StatelessWidget {
  const PaymentOptionCard(
      {Key? key,
        required this.selected,
        required this.title,
        required this.description})
      : super(key: key);

  final bool selected;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: selected ? AppColors.primarycolor : Colors.grey[100]!,
              width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Container(
        margin: const EdgeInsets.all(16),
        child: ListTile(
          leading: Icon(Icons.check_circle_rounded,
              color: selected ? AppColors.primarycolor : Colors.grey),
          title: Text(
            title,
            style:  TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimary)),

          subtitle: Text(description,style: const TextStyle(color: AppColors.textColor),),
        ),
      ),
    );
  }
}