import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  DocumentSnapshot documentSnapshot;

  EditPage({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
    Map<String, dynamic> data = widget.documentSnapshot.data() as Map<String, dynamic>;

    headController.text = data['head'];
    bodyController.text = data['body'];

    return Scaffold(
      appBar: AppBar(title: Text('Edit Page'),),
      body: ListView(
        children: [
          Row(
            children: [
              Text('head :'),
              Expanded(
                child: TextFormField(
                  controller: headController,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Text('body :'),
              Expanded(
                child: TextFormField(
                  controller: bodyController
                ),
              ),
            ],
          ),

          SizedBox(height: 15,),

          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: Text('Delete'),
                onPressed: (){
                  widget.documentSnapshot.reference.delete();
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Update'),
                onPressed: (){
                  widget.documentSnapshot.reference.update({
                    'head' : headController.text,
                    'body' : bodyController.text,
                    // data['body'] : body.text, bentuk seperti ini tidak bisa
                  },);
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
