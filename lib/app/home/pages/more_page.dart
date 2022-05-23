import 'package:arquetipo_flutter_bloc/app/shared/widgets/bottom_menu_widget.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('More')
      ),
      bottomNavigationBar: BottomMenu(1)
    );
  }
}
