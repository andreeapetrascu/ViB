import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/utils.dart';
import 'package:frontend/screens/hellopage/hellopage.dart';
import 'package:frontend/screens/home/components/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messagerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'ViB',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.indigo.shade900,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return const HelloPage();
            }
            return const Homescreen();
          }),
    );
  }
}
