import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcs_bab_2/bloc/cat_bloc.dart';
import 'package:mcs_bab_2/screens/detail_page.dart';

class CatOverviewScreen extends StatelessWidget {
  const CatOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cats'),
      ),
      body: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          if (state is CatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CatLoaded) {
            final cats = state.result;

            return ListView(
              children: [
                ListView.builder(
                  itemCount: cats.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cat = cats[index];
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.to(() => DetailPage(
                                cat: cat,
                              ));
                        },
                      ),
                    );
                  },
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
