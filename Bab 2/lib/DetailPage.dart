import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcs_bab_2/Cat.dart';

class DetailPage extends StatefulWidget {
  Cat cat;
  DetailPage({required this.cat});

  @override
  State<DetailPage> createState() => _DetailPageState(cat: cat);
}

class _DetailPageState extends State<DetailPage> {
  Cat cat;
  _DetailPageState({
    required this.cat
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${cat.name}'),
      ),
      body: Material(
        child: ListView(
          children: [
            Image.network(cat.urlImage),

            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Text(
                '${cat.desc}',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  )
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
