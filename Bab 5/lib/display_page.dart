import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcs_bab_5/catatan_controller.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_5/catatan_model.dart';
import 'add_data_page.dart';
import 'DB.dart';
import 'edit_page.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final CatatanController _catatanController = Get.put(CatatanController());

  @override
  void initState() {
    super.initState();
    _catatanController.getCatatanData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan App'),
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.add_circle,
            ),
            onTap: () {
              Get.to(const AddDataPage());
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: Colors.white),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.1),
                          blurRadius: 10.0)
                    ],
                    color: const Color(0xff2E3840),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create your notes in this App',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '- Write your plan',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '- Write your needs',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '- Write your memories',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 30),
                    child: Obx(() => ListView.builder(
                          itemCount: _catatanController.catatanList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            Catatan catatan =
                                _catatanController.catatanList[index];
                            return Container(
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              padding: const EdgeInsets.all(12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: catatan.warna == 0
                                      ? const Color(0xff4C4C6D)
                                      : catatan.warna == 1
                                          ? const Color(0xff6F61C0)
                                          : catatan.warna == 2
                                              ? Colors.blue[900]
                                              : Colors.pink[500],
                                  border: Border.all(
                                      width: 3, color: Colors.white)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //display taggal, hapus tanggal, edit tanggal dan ganti warna
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${catatan.tanggal}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                setState(() {
                                                  ubahTanggal(
                                                      context,
                                                      _catatanController
                                                          .catatanList[index]);
                                                  _catatanController
                                                      .getCatatanData();
                                                });
                                              }),
                                          IconButton(
                                              icon: const Icon(Icons.brush),
                                              onPressed: () {
                                                setState(() {
                                                  if (catatan.warna == 0) {
                                                    _catatanController
                                                        .warna1(catatan.id!);
                                                  } else if (catatan.warna ==
                                                      1) {
                                                    _catatanController
                                                        .warna2(catatan.id!);
                                                  } else if (catatan.warna ==
                                                      2) {
                                                    _catatanController
                                                        .warna3(catatan.id!);
                                                  } else {
                                                    _catatanController
                                                        .warna0(catatan.id!);
                                                  }
                                                  _catatanController
                                                      .getCatatanData();
                                                });
                                              }),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                showDeleteRecordBottomSheet(
                                                    context,
                                                    _catatanController
                                                        .catatanList[index]);
                                              }),
                                          IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                Get.to(
                                                    EditPage(catatan: catatan));
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 3,
                                    color: Colors.white,
                                  ),
                                  //tugas 1
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tugas 1',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      //hapus catetan tugas 1
                                      IconButton(
                                        icon: const Icon(Icons.restart_alt),
                                        onPressed: () {
                                          showEmptyTugas1BottomSheet(
                                              context,
                                              _catatanController
                                                  .catatanList[index]);
                                          _catatanController.getCatatanData();
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${catatan.tugas1}',
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //tugas 2
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tugas 2',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      //hapus catetan tugas 2
                                      IconButton(
                                        icon: const Icon(
                                          Icons.restart_alt,
                                        ),
                                        onPressed: () {
                                          showEmptyTugas2BottomSheet(
                                              context,
                                              _catatanController
                                                  .catatanList[index]);
                                          _catatanController.getCatatanData();
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${catatan.tugas2}',
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //tugas 3
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tugas 3',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      //hapus catetan tugas 3
                                      IconButton(
                                        icon: const Icon(Icons.restart_alt),
                                        onPressed: () {
                                          showEmptyTugas3BottomSheet(
                                              context,
                                              _catatanController
                                                  .catatanList[index]);
                                          _catatanController.getCatatanData();
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${catatan.tugas3}',
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            );
                          },
                        ))),

                //untuk spasi halaman paling bawah
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> ubahTanggal(BuildContext context, Catatan catatan) async {
    DateTime? setUbahTanggal = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));

    if (setUbahTanggal != null && setUbahTanggal != DateTime.now()) {
      setState(() {
        // String formattedDate = DateFormat.yMd().format(setUbahTanggal);  bisa begini
        DB.catatanDb!.rawUpdate(
            '''UPDATE ${DB.catatanDbTable} SET tanggal = '${DateFormat.yMd().format(setUbahTanggal)}' WHERE id = ?''',
            [catatan.id]);
        _catatanController.getCatatanData();
      });
    }
  }

  showEmptyTugas1BottomSheet(BuildContext context, Catatan catatan) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.7,
      decoration: const BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'empty tugas 1?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yesOrNoButton(
                  text: 'Yes',
                  color: const Color(0xff5C5470),
                  onTap: () {
                    _catatanController.emptyTugas1(catatan.id!);
                    _catatanController.getCatatanData();
                    Get.back();
                  },
                ),
                yesOrNoButton(
                    text: 'No',
                    color: const Color(0xffB9B4C7),
                    onTap: () {
                      Get.back();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  showEmptyTugas2BottomSheet(BuildContext context, Catatan catatan) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.7,
      decoration: const BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'empty tugas 2?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yesOrNoButton(
                  text: 'Yes',
                  color: const Color(0xff5C5470),
                  onTap: () {
                    _catatanController.emptyTugas2(catatan.id!);
                    _catatanController.getCatatanData();
                    Get.back();
                  },
                ),
                yesOrNoButton(
                    text: 'No',
                    color: const Color(0xffB9B4C7),
                    onTap: () {
                      Get.back();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  showEmptyTugas3BottomSheet(BuildContext context, Catatan catatan) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.7,
      decoration: const BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'empty tugas 3?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yesOrNoButton(
                  text: 'Yes',
                  color: const Color(0xff5C5470),
                  onTap: () {
                    _catatanController.emptyTugas3(catatan.id!);
                    _catatanController.getCatatanData();
                    Get.back();
                  },
                ),
                yesOrNoButton(
                    text: 'No',
                    color: const Color(0xffB9B4C7),
                    onTap: () {
                      Get.back();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  showDeleteRecordBottomSheet(BuildContext context, Catatan catatan) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.7,
      decoration: const BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'delete record?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yesOrNoButton(
                  text: 'Yes',
                  color: const Color(0xff5C5470),
                  onTap: () {
                    _catatanController.delete(catatan);
                    _catatanController.getCatatanData();
                    Get.back();
                  },
                ),
                yesOrNoButton(
                    text: 'No',
                    color: const Color(0xffB9B4C7),
                    onTap: () {
                      Get.back();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  yesOrNoButton(
      {required String text, required Color color, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.8,
        height: MediaQuery.of(context).size.height / 17,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Text(text,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
