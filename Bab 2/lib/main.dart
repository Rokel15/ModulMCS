import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_2/HomaPage.dart';

void main() {
  runApp(CatBreedApp());
}

class CatBreedApp extends StatelessWidget {
  const CatBreedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cat Breed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark()
      ),
      home: HomePage(),
    );
  }
}


