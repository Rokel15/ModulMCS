import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase MCS App',
      theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: const Color(0xff0597F2),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: Color(0xff0597F2),
            elevation: 0,
          )),
      home: const HomePage(),
    );
  }
}
