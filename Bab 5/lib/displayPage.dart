import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcs_bab_5/CatetanMhsController.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_5/CatetanMhsModel.dart';
import 'AddDataPage.dart';
import 'DB.dart';
import 'EditPage.dart';

class displayPage extends StatefulWidget {
  const displayPage({Key? key}) : super(key: key);

  @override
  State<displayPage> createState() => _displayPageState();
}

class _displayPageState extends State<displayPage> {

  final CatetanMhsController catetanMhsController = Get.put(CatetanMhsController());

  @override
  void initState() {
    super.initState();
    catetanMhsController.getCatetanMhsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catetan App'),
        actions: [
          GestureDetector(
            child: Icon(
              Icons.add_circle,
            ),
            onTap: (){
              Get.to(AddDataPage());
            },
          ),
          SizedBox(width: 10,)
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Create your notes in this App', style: TextStyle(fontSize: 16),),
                        Text('- Write your plan', style: TextStyle(fontWeight: FontWeight.w600),),
                        Text('- Write your needs', style: TextStyle(fontWeight: FontWeight.w600),),
                        Text('- Write your memories', style: TextStyle(fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 30),
                  child: Obx(()
                  => ListView.builder(
                    itemCount: catetanMhsController.CatetanMhsList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index){
                      CatetanMhsModel catetanMhsModel = catetanMhsController.CatetanMhsList[index];
                      return Container(
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        padding: EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color:
                          catetanMhsModel.warna==0? Color(0xff4C4C6D) :
                          catetanMhsModel.warna==1? Color(0xff6F61C0) :
                          catetanMhsModel.warna==2? Colors.blue[900] :
                          Colors.pink[500],
                          border: Border.all(
                            width: 3,
                            color: Colors.white
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //display taggal, hapus tanggal, edit tanggal dan ganti warna
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${catetanMhsModel.tanggal}',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: (){
                                          setState(() {
                                            ubahTanggal(context, catetanMhsController.CatetanMhsList[index]);
                                            catetanMhsController.getCatetanMhsData();
                                          });
                                        }
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.brush),
                                        onPressed: (){
                                          setState(() {
                                            if(catetanMhsModel.warna==0){
                                              catetanMhsController.warna1(catetanMhsModel.id!);
                                            } else if(catetanMhsModel.warna==1){
                                              catetanMhsController.warna2(catetanMhsModel.id!);
                                            } else if(catetanMhsModel.warna==2){
                                              catetanMhsController.warna3(catetanMhsModel.id!);
                                            } else{
                                              catetanMhsController.warna0(catetanMhsModel.id!);
                                            }
                                            catetanMhsController.getCatetanMhsData();
                                          });
                                        }
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: (){
                                          show_deleteRecordBottomSheet(context, catetanMhsController.CatetanMhsList[index]);
                                        }
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: (){
                                          Get.to(EditPage(catetanMhsModel: catetanMhsModel));
                                        }
                                    ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Tugas 1',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                //hapus catetan tugas 1
                                IconButton(
                                  icon: Icon(Icons.restart_alt),
                                  onPressed: (){
                                    show_emptyTugas1BottomSheet(context, catetanMhsController.CatetanMhsList[index]);
                                    catetanMhsController.getCatetanMhsData();
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${catetanMhsModel.tugas1}',
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10,),
                            //tugas 2
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Tugas 2',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                //hapus catetan tugas 2
                                IconButton(
                                  icon: Icon(Icons.restart_alt,),
                                  onPressed: (){
                                    show_emptyTugas2BottomSheet(context, catetanMhsController.CatetanMhsList[index]);
                                    catetanMhsController.getCatetanMhsData();
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${catetanMhsModel.tugas2}',
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10,),
                            //tugas 3
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Tugas 3',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                //hapus catetan tugas 3
                                IconButton(
                                  icon: Icon(Icons.restart_alt),
                                  onPressed: (){
                                    show_emptyTugas3BottomSheet(context, catetanMhsController.CatetanMhsList[index]);
                                    catetanMhsController.getCatetanMhsData();
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${catetanMhsModel.tugas3}',
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      );
                    },
                  ))
                ),

                //untuk spasi halaman paling bawah
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> ubahTanggal(BuildContext context, CatetanMhsModel catetanMhsModel) async{
    DateTime? setUbahTanggal = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));

    if(setUbahTanggal != null && setUbahTanggal != DateTime.now()){
      setState(() {
        // String formattedDate = DateFormat.yMd().format(setUbahTanggal);  bisa begini
        DB.catetanMhsDB!.rawUpdate(
            '''UPDATE ${DB.catetanMhsDbTable} SET tanggal = '${DateFormat.yMd().format(setUbahTanggal)}' WHERE id = ?''',[catetanMhsModel.id]
        );
        catetanMhsController.getCatetanMhsData();
      });
    }
  }

  show_emptyTugas1BottomSheet(BuildContext context, CatetanMhsModel catetanMhsModel){
    Get.bottomSheet(
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height/5.7,
          decoration: BoxDecoration(
              color: Color(0xff352F44),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          child: Column(
            children: [
              Container(
                height: 7,
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Text('empty tugas 1?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    YesOrNo_Button(
                      text: 'Yes',
                      color: Color(0xff5C5470),
                      onTap: (){
                        catetanMhsController.emptyTugas1(catetanMhsModel.id!);
                        catetanMhsController.getCatetanMhsData();
                        Get.back();
                      },
                    ),
                    YesOrNo_Button(
                        text: 'No',
                        color: Color(0xffB9B4C7),
                        onTap: (){
                          Get.back();
                        }
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  show_emptyTugas2BottomSheet(BuildContext context, CatetanMhsModel catetanMhsModel){
    Get.bottomSheet(
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height/5.7,
          decoration: BoxDecoration(
              color: Color(0xff352F44),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          child: Column(
            children: [
              Container(
                height: 7,
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Text('empty tugas 2?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    YesOrNo_Button(
                      text: 'Yes',
                      color: Color(0xff5C5470),
                      onTap: (){
                        catetanMhsController.emptyTugas2(catetanMhsModel.id!);
                        catetanMhsController.getCatetanMhsData();
                        Get.back();
                      },
                    ),
                    YesOrNo_Button(
                        text: 'No',
                        color: Color(0xffB9B4C7),
                        onTap: (){
                          Get.back();
                        }
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  show_emptyTugas3BottomSheet(BuildContext context, CatetanMhsModel catetanMhsModel){
    Get.bottomSheet(
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height/5.7,
          decoration: BoxDecoration(
              color: Color(0xff352F44),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          child: Column(
            children: [
              Container(
                height: 7,
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Text('empty tugas 3?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    YesOrNo_Button(
                      text: 'Yes',
                      color: Color(0xff5C5470),
                      onTap: (){
                        catetanMhsController.emptyTugas3(catetanMhsModel.id!);
                        catetanMhsController.getCatetanMhsData();
                        Get.back();
                      },
                    ),
                    YesOrNo_Button(
                        text: 'No',
                        color: Color(0xffB9B4C7),
                        onTap: (){
                          Get.back();
                        }
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  show_deleteRecordBottomSheet(BuildContext context, CatetanMhsModel catetanMhsModel){
    Get.bottomSheet(
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height/5.7,
        decoration: BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        child: Column(
          children: [
            Container(
              height: 7,
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child: Text('delete record?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  YesOrNo_Button(
                      text: 'Yes',
                      color: Color(0xff5C5470),
                      onTap: (){
                        catetanMhsController.delete(catetanMhsModel);
                        catetanMhsController.getCatetanMhsData();
                        Get.back();
                      },
                  ),
                  YesOrNo_Button(
                      text: 'No',
                      color: Color(0xffB9B4C7),
                      onTap: (){
                        Get.back();
                      }
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  YesOrNo_Button({
    required String text,
    required Color color,
    required Function() onTap}){
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width/2.8,
        height: MediaQuery.of(context).size.height/17,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white
            )
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}