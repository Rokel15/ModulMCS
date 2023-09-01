import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_5/CatetanMhsController.dart';
import 'DB.dart';
import 'CatetanMhsModel.dart';

class EditPage extends StatefulWidget {
  CatetanMhsModel? catetanMhsModel;

  EditPage({
    required this.catetanMhsModel
  });

  @override
  State<EditPage> createState() => _EditPageState(catetanMhsModel: catetanMhsModel);
}

class _EditPageState extends State<EditPage> {
  CatetanMhsModel? catetanMhsModel;

  _EditPageState({
    required this.catetanMhsModel
  });

  TextEditingController tugas1 = TextEditingController();
  TextEditingController tugas2 = TextEditingController();
  TextEditingController tugas3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    tugas1.text = widget.catetanMhsModel?.tugas1 ?? '';
    tugas2.text = widget.catetanMhsModel?.tugas2 ?? '';
    tugas3.text = widget.catetanMhsModel?.tugas3 ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final CatetanMhsController catetanMhsController = Get.put(CatetanMhsController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
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
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.1),
                        blurRadius: 10.0
                    )
                  ],
                  color: Color(0xff2E3840),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Text('Edit your note', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
              ),
              // Tugas 1
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tugas 1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    TextFormField(
                      controller: tugas1,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              //Tugas 2
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tugas 2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    TextFormField(
                      controller: tugas2,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              //Tugas 3
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tugas 3', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
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
        child:
        Icon(Icons.save,),
        onPressed: () async{
          await DB.catetanMhsDB!.rawUpdate(
              '''UPDATE ${DB.catetanMhsDbTable} SET tugas1 = '${tugas1.text}' WHERE id = ?''',[catetanMhsModel!.id]
          );
          await DB.catetanMhsDB!.rawUpdate(
              '''UPDATE ${DB.catetanMhsDbTable} SET tugas2 = '${tugas2.text}' WHERE id = ?''',[catetanMhsModel!.id]
          );
          await DB.catetanMhsDB!.rawUpdate(
              '''UPDATE ${DB.catetanMhsDbTable} SET tugas3 = '${tugas3.text}' WHERE id = ?''',[catetanMhsModel!.id]
          );
          catetanMhsController.getCatetanMhsData();
          Get.back();
        },
      ),
    );
  }
}