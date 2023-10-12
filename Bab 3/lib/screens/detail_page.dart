import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/cat.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.cat}) : super(key: key);
  final Cat cat;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cat.name),
      ),
      body: Material(
        child: ListView(
          children: [
            Image.network(widget.cat.urlImage),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Text(
                widget.cat.desc,
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
