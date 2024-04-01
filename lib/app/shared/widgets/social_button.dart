import 'package:arquetipo_flutter_bloc/app/shared/widgets/social_button_decoration.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.title, required this.path});
  final String title;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return SocialButtonDecoration(
      path: path,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (path != null)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(path!),
              ),
            ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: path != null ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
}
