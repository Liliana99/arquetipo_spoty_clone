import 'package:arquetipo_flutter_bloc/app/shared/widgets/bottom_menu_widget.dart';
import 'package:flutter/material.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: Text('Random')),
        bottomNavigationBar: BottomMenu(2));
  }
}
