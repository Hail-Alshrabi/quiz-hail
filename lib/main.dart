import 'package:demo/screens/leaderboard_screen.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:demo/screens/questions_screen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.initialize("f787d8d5-6234-468d-8819-e86b855be5fb");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String initalRoute = "/";

    if (user == null) {
      initalRoute = "/login";
    }

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initalRoute,
      routes: {
        "/login": (context) => const LoginScreen(),
        "/leaderboard": (context) => const LeaderBoardScreen(),
        "/": (context) => const QuestionsScreen()
      },
    );
  }
}
