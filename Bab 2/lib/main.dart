import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_2/screens/home_page.dart';

void main() {
  runApp(const CatBreedApp());
}

class CatBreedApp extends StatelessWidget {
  const CatBreedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cat Breed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      home: const HomePage(),
    );
  }
}
