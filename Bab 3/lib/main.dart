import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_2/bloc/cat_bloc.dart';
import 'package:mcs_bab_2/screens/cats_overview_screen.dart';

void main() {
  runApp(const CatBreedApp());
}

class CatBreedApp extends StatelessWidget {
  const CatBreedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatBloc()..add(OnCatEventCalled()),
      child: GetMaterialApp(
        title: 'Cat Breed',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: const ColorScheme.dark()),
        home: const CatOverviewScreen(),
      ),
    );
  }
}
