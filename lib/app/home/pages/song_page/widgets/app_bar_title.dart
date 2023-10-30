import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(
            "PLAYING FROM PLAYLIST",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
          Text(
            'Legendary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
