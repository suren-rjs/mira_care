import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mira_care/constants/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, required this.isInitCall});

  final bool? isInitCall;

  @override
  Widget build(BuildContext context) {
    MediaQueryData contextSize = MediaQuery.of(context);
    double scrHeight = contextSize.size.height;
    double scrWidth = contextSize.size.width;
    return Container(
      color:
          (isInitCall ?? false) ? appColors.loadingBackground : appColors.white30,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: scrHeight * 0.35),
            SizedBox(
              width: scrWidth * 0.3,
              height: scrHeight * 0.25,
              child: Image.asset('assets/images/logo.png'),
            ),
            Lottie.asset(
              'assets/animation/loading.json',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: scrHeight * 0.1),
          ],
        ),
      ),
    );
  }
}
