import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:bab_1/Receiver.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int start = 0;

  void increment(){
    setState(() {
      start++;
    });
  }

  void decrement(){
    setState(() {
      start--;
      if(start<=0){
        start = 0;
      }
    });
  }

  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();
  int result = 0;

  void sumOfTwo(){
    dynamic x = int.parse(input1.text);
    dynamic y = int.parse(input2.text);
    setState(() {
      this.result = x + y;
    });
  }

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bab 1')),
      body: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [

              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 40),
                child: Center(
                    child: Text(
                        '$start',
                        style: TextStyle(
                            fontSize: 52
                        )
                    )
                ),
              ),

              //incrementButton and decrementButton
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Icon(Icons.keyboard_arrow_left),
                        onPressed: (){
                          decrement();
                        }
                    ),
                    SizedBox(width: 40,),
                    ElevatedButton(
                        child: Icon(Icons.keyboard_arrow_right),
                        onPressed: (){
                          increment();
                        }
                    )
                  ],
                ),
              ),

              //controller: input1
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: TextFormField(
                  controller: input1,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'input angka',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.orange,
                        style: BorderStyle.solid,
                        width: 5
                      ),
                    ),
                    labelText: 'input angka'
                  ),
                ),
              ),

              //controller: input2
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: TextFormField(
                  controller: input2,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 22),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'input angka'
                  ),
                ),
              ),

              //sumButton
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
                    onPressed: (){
                      sumOfTwo();
                    },
                  ),
                ],
              ),

              //Result
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text('Result : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                FontWeight.w600
                            ),
                          ),
                          Text(
                            '$result',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.restart_alt,
                        size: 26,
                        color: Colors.black,
                      ),
                      onTap: (){
                        setState(() {
                          input1.text = '';
                          input2.text = '';
                          result = 0;
                        });
                      },
                    )
                  ],
                ),
              ),

              // send message
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: message,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          labelText: 'Message',
                          hintText: 'type the message'
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      child: Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 26,
                      ),
                      onTap: (){
                        final route = MaterialPageRoute(builder: (BuildContext context) => Receiver(receiveMessage: message.text,));
                        Navigator.push(
                            context,
                            route
                        );

                      },
                    )
                  ],
                ),
              ),

              //go_to_websiteButton
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff445069),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      width: MediaQuery.of(context).size.width/2,
                      height: 50,
                      child: Center(
                        child: Text(
                          'https://flutter.dev',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    onTap: () async{
                      await launchUrl(Uri.parse('https://flutter.dev'));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
