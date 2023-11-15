import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_5/catatan_controller.dart';
import 'DB.dart';
import 'catatan_model.dart';

class EditPage extends StatefulWidget {
  final Catatan? catatan;

  const EditPage({super.key, required this.catatan});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController tugas1 = TextEditingController();
  TextEditingController tugas2 = TextEditingController();
  TextEditingController tugas3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    tugas1.text = widget.catatan?.tugas1 ?? '';
    tugas2.text = widget.catatan?.tugas2 ?? '';
    tugas3.text = widget.catatan?.tugas3 ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final CatatanController catatanController = Get.put(CatatanController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: ListView(
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
                    child: Text('Edit your note',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))),
              ),
              // Tugas 1
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tugas 1',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: tugas1,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              //Tugas 2
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tugas 2',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: tugas2,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              //Tugas 3
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tugas 3',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: tugas3,
                      maxLines: null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      //save
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save,
        ),
        onPressed: () async {
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas1 = '${tugas1.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas2 = '${tugas2.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas3 = '${tugas3.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          catatanController.getCatatanData();
          Get.back();
        },
      ),
    );
  }
}
