import 'package:arquetipo_flutter_bloc/shared/widgets/bottom_menu_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('Home')
      ),
      bottomNavigationBar: BottomMenu(0)
    );
  }
}
