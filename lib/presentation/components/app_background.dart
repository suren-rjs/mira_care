import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: scrHeight,
      width: scrWidth,
      child: Image.asset(
        'assets/images/mira_background.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
