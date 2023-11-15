import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'display_page.dart';
import 'DB.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.initCatatanDb();
  runApp(const CatatanApp());
}

class CatatanApp extends StatelessWidget {
  const CatatanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Catatan App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      home: const DisplayPage(),
    );
  }
}
