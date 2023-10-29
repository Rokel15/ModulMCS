import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  String head;
  String body;
  String number;
  Function() onDelete;
  Function() numberIncrement;
  Function() numberDecrement;
  Function() toEditPage;

  ShowData({
    required this.head,
    required this.body,
    required this.number,
    required this.onDelete,
    required this.numberDecrement,
    required this.numberIncrement,
    required this.toEditPage,
  });

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  TextEditingController isiHead = TextEditingController();

  @override
  void initState() {
    isiHead.text = widget.head;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('head : ${widget.head}'),
              Text('body : ${widget.body}'),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              child: Icon(Icons.delete_forever),
              onTap: (){widget.onDelete();},
            ),


            GestureDetector(
              child: Icon(Icons.arrow_circle_down),
              onTap: (){widget.numberDecrement();},
            ),
            Text(widget.number),
            GestureDetector(
              child: Icon(Icons.arrow_circle_up),
              onTap: (){widget.numberIncrement();},
            ),

            GestureDetector(
              child: Icon(Icons.chevron_right),
              onTap: (){widget.toEditPage();},
            )
          ],
        ),
      ],
    );
  }
}