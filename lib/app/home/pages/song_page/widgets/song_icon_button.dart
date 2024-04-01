import 'package:flutter/material.dart';

class IconButtonSong extends StatelessWidget {
  final Widget icon;
  final Color? backGroundColor;
  final VoidCallback ontap;
  const IconButtonSong({
    super.key,
    required this.icon,
    this.backGroundColor,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backGroundColor ?? Colors.transparent,
      ),
      child: IconButton(
        icon: icon,
        iconSize: MediaQuery.of(context).size.height * 0.05,
        color: backGroundColor != null ? Colors.black :backGroundColor,
        onPressed: ontap,
      ),
    );
  }
}
