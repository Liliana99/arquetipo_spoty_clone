import 'package:flutter/material.dart';

class SocialButtonDecoration extends StatelessWidget {
  const SocialButtonDecoration({super.key, required this.child, this.path});
  final Widget child;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 290,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(50.0),
          color: path != null
              ? Colors.transparent
              : const Color.fromARGB(255, 146, 239, 149),
        ),
        child: child);
  }
}

class ButtonDecorationWitOutPassword extends StatelessWidget {
  const ButtonDecorationWitOutPassword({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.transparent,
        ),
        child: child);
  }
}
