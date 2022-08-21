import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AppBarButton extends StatefulWidget {
  const AppBarButton({Key? key, this.icon, this.onTap}) : super(key: key);
 final  Widget? icon;
 final VoidCallback? onTap;

  @override
  State<AppBarButton> createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      child: TextButton(
        onPressed:
          widget.onTap,
        child: widget.icon?? const Icon(
          LineIcons.bellAlt,
          color: Colors.white,
        ),
        style: TextButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.3,),
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),),
    );
  }
}
