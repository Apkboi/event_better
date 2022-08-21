import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  const CardTile({Key? key,
    required this.preffix,
    required this.suffix,
    required this.tittle,
    this.onClick})
      : super(key: key);
  final Widget preffix;
  final Widget suffix;
  final Widget tittle;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 18),
        decoration: BoxDecoration(color: Theme
            .of(context)
            .cardColor, borderRadius:BorderRadius.circular(10)),
        child: Row(
          children: [
            preffix,
            const SizedBox(width: 10,),
            Expanded(child: tittle),
            const SizedBox(width: 10,),
            suffix

          ],
        ),
      ),
    );
  }
}
