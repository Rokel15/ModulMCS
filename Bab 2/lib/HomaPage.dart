import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcs_bab_2/Cat.dart';
import 'package:mcs_bab_2/DetailPage.dart';

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
        padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Jenis-jenis Kucing',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    )
                ),
              ),
            ),
            ListView.builder(
              itemCount: listCat.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                Cat cat = listCat[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/4,
                              height: MediaQuery.of(context).size.width/4,
                              child: Image.network(
                                cat.urlImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '${cat.name}',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    onTap: (){
                        Get.to(DetailPage(cat: cat,));
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
