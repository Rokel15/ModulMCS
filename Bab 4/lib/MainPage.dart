import 'package:bab_4_mcs/ShowData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'EditPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController headController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void dispose() {
    headController.dispose();
    bodyController.dispose();
    numberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore.collection('mcs bab 4');

    return Scaffold(
      appBar: AppBar(title: Text('mcs bab 4'), backgroundColor: Colors.black,),
      body: ListView(
        children: [
          Row(
            children: [
              Text('head : '),
              Expanded(
                child: TextFormField(
                  controller: headController,
                  decoration: InputDecoration(hintText: 'head',),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Text('body : '),
              Expanded(
                child: TextFormField(
                  controller: bodyController,
                  decoration: InputDecoration(hintText: 'body',),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Text('number : '),
              Expanded(
                child: TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(hintText: 'number',),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                ),
              ),
            ],
          ),

          SizedBox(height: 50,),

          Center(
            child: ElevatedButton(
              child: Text('input'),
              onPressed: (){
                collectionReference.add({
                  'head' : headController.text,
                  'body' : bodyController.text,
                  'number' : int.parse(numberController.text),
                });
                headController.text = '';
                bodyController.text = '';
                numberController.text = '';
              },
            ),
          ),

          SizedBox(height: 50,),

          Container(
            width: double.infinity,
            child: Text('hasil input :'),
          ),

          Container(
            width: double.infinity,
            child: StreamBuilder(
              stream: collectionReference.snapshots(),
              builder: (_, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: snapshot.data!.docs.map((e)
                    => ShowData(
                      head: (e.data() as dynamic)['head'].toString(),
                      body: (e.data() as dynamic)['body'].toString(),
                      number: (e.data() as dynamic)['number'].toString(),
                      onDelete: (){collectionReference.doc(e.id).delete();},
                      numberDecrement: (){
                        // testingFirestore.doc(e.id).update({'number': e.data()?['number'] - 1});
                        //dulu sih caranya begini anjir, asulah semenjak update

                        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                        int number = data['number'] as int;
                        collectionReference.doc(e.id).update({'number': number - 1});
                      },
                      numberIncrement: (){
                        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                        int number = data['number'] as int;
                        collectionReference.doc(e.id).update({'number': number + 1});
                      },
                      toEditPage: () async{
                        DocumentSnapshot documentSnapshot = await collectionReference.doc(e.id).get();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return EditPage(documentSnapshot: documentSnapshot);
                          },
                        ));
                      },
                    )).toList(),
                  );
                } else{
                  return Center(child: CircularProgressIndicator());
                }
                },
            ),
          )
        ],
      ),
    );
  }


}
