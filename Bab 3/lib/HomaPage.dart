import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcs_bab_2/data/cats_data.dart';
import 'package:mcs_bab_2/DetailPage.dart';
import 'package:mcs_bab_2/models/cat.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bab 2',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Jenis-jenis Kucing',
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ),
            ),
            ListView.builder(
              itemCount: catsData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Cat cat = catsData[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.width / 4,
                            child: Image.network(
                              cat.urlImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            cat.name,
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.to(DetailPage(
                        cat: cat,
                      ));
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
