import 'package:arquetipo_flutter_bloc/app/shared/widgets/bottom_menu_widget.dart';
import 'package:flutter/material.dart';

class RandomPage extends StatelessWidget {

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RandomPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('Random')
      ),
      bottomNavigationBar: BottomMenu(2)
    );
  }
}
