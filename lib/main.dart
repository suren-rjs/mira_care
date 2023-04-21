import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mira_care/presentation/screens/login.dart';
import 'package:mira_care/resources/init_controllers.dart';
import 'package:mira_care/resources/service/messaging_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (DefaultFirebaseOptions.currentPlatform != DefaultFirebaseOptions.web) {
    await Permission.contacts.request();
  }
  await messagingService.init();
  await messagingService.subscribeToChannel('user1-user2');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: '',
        visualDensity: VisualDensity.standard,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: appColors.scoreCardText,
        ),
      ),
      initialBinding: InitRequiredControllers(),
      home: const Login(),
    );
  }
}
