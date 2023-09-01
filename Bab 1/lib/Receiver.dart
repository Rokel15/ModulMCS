import 'package:flutter/material.dart';

class Receiver extends StatefulWidget {
  String? receiveMessage;
  Receiver({required this.receiveMessage});

  @override
  State<Receiver> createState() => _ReceiverState(receiveMessage: receiveMessage);
}

class _ReceiverState extends State<Receiver> {
  String? receiveMessage;

  _ReceiverState({required this.receiveMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //menghapus backbutton pada AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'the message :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),
            Text(
              '$receiveMessage',
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.justify,
            )

          ],
        ),
      ),
    );
  }
}
