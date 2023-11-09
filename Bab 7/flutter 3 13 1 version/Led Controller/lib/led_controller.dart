import 'package:flutter/material.dart';
import 'Firebase Services/realtime_database.dart';

class LedController extends StatefulWidget {
  const LedController({Key? key}) : super(key: key);

  @override
  State<LedController> createState() => _LedControllerState();
}

class _LedControllerState extends State<LedController> {
  bool isButtonEnable = false;
  dynamic buttonStatus;
  dynamic sensorResult;

  @override
  void initState() {
    btnStatus.onValue.listen((event) {
      final getStatusButton = event.snapshot;
      setState(() {
        buttonStatus = getStatusButton.value;
      });
    });
    dataSensor.onValue.listen((event) {
      final getSensorResult = event.snapshot;
      setState(() {
        sensorResult = getSensorResult.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Data sensor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          Text('$sensorResult °C', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
                          ElevatedButton(
                            child: Text('cek data'),
                            onPressed: (){
                              SnackBar snackbarMessage = SnackBar(content: Text('data button = $buttonStatus'));
                              ScaffoldMessenger.of(context).showSnackBar(snackbarMessage);
                            },
                          )
                        ],
                      ),

                      Row(
                        children: [
                          const Text('Manual'),
                          Switch(
                            value: isButtonEnable,
                            focusColor: Colors.deepPurple,
                            onChanged: (value) async{
                              setState(() {
                                isButtonEnable = value;
                              });
                              await btnStatus.set(2);
                            },
                          ),
                          const Text('Auto'),
                        ],
                      ),

                      ElevatedButton(
                        child:
                        isButtonEnable==false?
                        Text(
                          buttonStatus==0? 'on' : 'off',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ) :
                        Text(
                          'auto',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          buttonStatus==0? Color(0xff363062) : Color(0xff5C4B99),
                          side: BorderSide(color: Colors.black),
                          disabledBackgroundColor: Colors.grey
                        ),
                        onPressed: isButtonEnable==false? () async{
                          try {
                            await buttonStatus==0? await btnStatus.set(1) : await btnStatus.set(0);
                          }catch(e){
                            SnackBar snackbarMessage = SnackBar(content: Text('gagal update data'));
                            ScaffoldMessenger.of(context).showSnackBar(snackbarMessage);
                          }
                        } : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}