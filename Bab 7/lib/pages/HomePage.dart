import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: deprecated_member_use
  final DatabaseReference databaseReference =
      // ignore: deprecated_member_use
      FirebaseDatabase.instance.reference();
  int dataValue = 0;

  @override
  void initState() {
    super.initState();
    listenToDataChanges();
  }

  void listenToDataChanges() {
    databaseReference.child('dataSensor').onValue.listen((event) {
      if (event.snapshot.exists) {
        dynamic value = event.snapshot.value;
        if (value is int) {
          setState(() {
            dataValue = value;
          });
        }
      }
    });
  }

  //button
  bool isButtonState = true;
  bool isButtonEnable = false;
  var btnText = 'ON';
  Color btncolor = Colors.grey;

  void btnOn() {
    isButtonState = false;
    databaseReference.child('btnStatus').set(1);
    setState(() {
      btnText = 'OFF';
    });
  }

  void btnOff() {
    isButtonState = true;
    databaseReference.child('btnStatus').set(0);
    setState(() {
      btnText = 'ON';
    });
  }

  //Tampilan
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase MCS App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5, // atur elevasi card sesuai keinginan
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Sensor:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$dataValue °C',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text("Auto"),
                            Switch(
                              value: isButtonEnable,
                              onChanged: (value) {
                                setState(() {
                                  isButtonEnable = value;
                                  value ? btncolor = Colors.blue : btncolor = Colors.grey;
                                  value
                                      ? databaseReference.child('btnStatus').set(0)
                                      : databaseReference.child('btnStatus').set(2);
                                });
                              },
                            ),
                            Text("Manual"),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (isButtonEnable == true) {
                              if (isButtonState == true) {
                                btnOn();
                              } else if (isButtonState == false) {
                                btnOff();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: btncolor),
                          child: Text(btnText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
