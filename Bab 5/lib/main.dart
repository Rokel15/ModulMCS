import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'displayPage.dart';
import 'DB.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DB.initcatetanMhsDb();
  runApp(catetanMhs());
}

class catetanMhs extends StatelessWidget {
  const catetanMhs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'catetan Mhs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark()
      ),
      home: displayPage(),
    );
  }
}