import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'NewsPage.dart';
import 'fetchData.dart';

void main(){
  runApp(newsApp());
}

class newsApp extends StatelessWidget {
  const newsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "News App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      home: NewsPage(),
    );
  }
}

