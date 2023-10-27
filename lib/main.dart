import 'package:flutter/material.dart';
import 'package:parties_hall_app/providers/AuthProvider.dart';
import 'package:parties_hall_app/providers/bottomNavigationBarProvider.dart';
import 'package:parties_hall_app/providers/hallProvider.dart';
import 'package:parties_hall_app/screens/accounts/loginUser.dart';
import 'package:provider/provider.dart';

import 'constants/string_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider(),),
        ChangeNotifierProvider<HallProvider>(create: (_) => HallProvider(),),
        ChangeNotifierProvider<BottomNavigationBarProvider>(create: (_) => BottomNavigationBarProvider(),),
      ],
      child: MaterialApp(
        title: txt_appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'cairo',
          primarySwatch: Colors.blue,
        ),
        home: const UserLogin(),
      ),
    );
  }
}

