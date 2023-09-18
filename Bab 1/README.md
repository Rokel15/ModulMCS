# BAB 1 
# Widget-widget dasar pada Flutter
### Pada bab ini akan diperkenalkan cara membentuk sebuah halaman aplikasi beserta isinya dengan komponen-komponen yang tersedia dari flutter
### Material App
MaterialApp adalah Widget paling dasar dalam membentuk suatu aplikasi, untuk menggunakan MaterialApp maka perlu import 'package:flutter/material.dart';

Struktur dari Material App
```dart
    MaterialApp(
      title: ...,
      debugShowCheckedModeBanner: ...,
      theme: ...,
      home: ....
      initialRoute: ...,
      routes: {...}
      //dan lain lain
    );
```
### Scaffold
Scaffold adalah Widget yang umum untuk membuat halaman pada aplikasi, pada Scaffold mempunyai prpperty untuk membiat halaman seperti appBar:, body:, floatingActionButton: drawer: bottomNavigationBar: dan lain-lain

Struktur dri Scaffold :
```dart
    Scaffold(
      appBar: ...,
      body: ...,
      floatingActionButton: ...,
      drawer: ...,
      bottomNavigationBar: ...,
    )
```
untuk dapat menggunakan komponen-komponen pada flutter maka widget ditulis dalam class yang di**extend** dari StatelessWidget ataupun StatefulWidget. StatelessWidget dan StatfulWidget memiliki beberapa perbedaan. Beberpa perbedaan tersebut ialah

StatelessWidget
- Hanya fokus pada tampilan
- Tidak dapat menangani perubahan tampilan. Misal terdapat angka 1 pada halaman kemudian ingin dilakukakn perubahan tertentu dengan aktivitas tertentu pada angka tersebut, dengan StatelessWdget hal tersebut tidak bisa dilakukan
- Dibuat dengan extends dari StatelessWidget
- Biasanya hanya digunakan untuk mengembalikan MaterialApp
- Contoh StatelessWidget :
  ```dart
        class MyApp extends StatelessWidget {
          const MyApp({super.key});
          @override
          Widget build(BuildContext context) {
            return MaterialApp(
              title: ...,
              theme: ...,
              home: ...,
            );
          }
        }
    ```

StatefulWidget
- Dapat menangani perubahan tampilan,  Misal terdapat angka 1 pada halaman kemudian ingin dilakukakn perubahan tertentu dengan aktivitas tertentu pada angka tersebut, dengan StatefulWdget hal tersebut bisa dilakukan
- Dibuat dengan extends dari StatefulWidget
- Menggunakan 2 class(widget dan state)
- Contoh StatefulWidget :

        class MyHomePage extends StatefulWidget {
          
            @override
            State<MyHomePage> createState() => _MyHomePageState();
        }
        
        class _MyHomePageState extends State<MyHomePage> {
            @override
            //...
        }
## Praktikum Bab 1
Tampilan aplikasi yang akan dibangun

Tampilan Awal
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%201/tampilan%20bab%201.PNG" alt="Teks Pengganti">
</div>

---
Tampilan Message Receiver
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%201/message%20receiver.PNG" alt="Teks Pengganti">
</div>

Dari tampilan di atas terdapat button '<' dan '>' untuk menambah angka dan mengurangi angka. Di bawahnya merupakan kalkulator penjumlahan sederhana, tampilan result adalah hasil dari penjumlahan dan icon restart untuk reset hasil penjumlahan. Di bawahnya lagi terdapat textfield, apabila user mengisi textfield tersebut lalu klik icon send maka halaman akan berpindah dan data yang diisi akan dikirim ke halaman berikutnya untuk ditampilkan. Terakhir yang paling bawah adalah 
button untuk menuju link [Google](https://flutter.dev)

Buatlah project baru dan beri nama praktikum_mcs_bab1(untuk nama bebas) dan pilihlah folder untuk tempat menyimpan project. Buka main.dart untuk memulai penulisan code. perhatikan struktur folder project seperti di bawah ini dan lihat main.dart berada

Struktur folder
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%201/Struktur%20Folder.PNG" alt="Teks Pengganti">
</div>

code bawaan dari flutter pada main.dart bisa dihapus atau bisa juga tidak pada bagian-bagian tertentu seperti

    import 'package:flutter/material.dart';
dan

    void main() {
      runApp(const MyApp());
    }

dari kode diatas bisa dianjut untuk melanjutkan praktikum dan buatlah kelas MyApp dengan extends StatelessWidget, runApp pada fungsi main menjalankan class MyApp dan pada MyApp terdapat method Widget build dengan return MaterialApp

    import 'package:flutter/material.dart';
    
    class MyApp extends StatelessWidget {
      const MyApp({super.key});
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Bab 1',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green
          ),
          home: HomePage()
        );
      }
    }


title adalah label atau deskripsi aplikasi, debugShowCheckedModeBanner dikondisikan false agar menghilangkan banner yang terletak di kana atas, theme untuk mengatur tema warna tampilan dan home adalah properti yang digunakan untuk mengatur hal apa yang dijalankan pertama. home bisa diisi dengan suatu class ataupun langsung memanggil Scaffold. Di sini home berisi HomePage artinya class HomePage akan dijalankan terlebih dahulu sebelum class yang lain.

Buatalah file baru bernama HomePage.dart berisi class HomePage

    import 'package:flutter/material.dart';
    
    class HomePage extends StatefulWidget {
        const HomePage({Key? key}) : super(key: key);
    
        @override
        State<HomePage> createState() => _HomePageState();
    }
    
    class _HomePageState extends State<HomePage> {
        //...
    }
Masukkan semua atribut dan method yang nantinya akan dibutuhkan untuk membangun project di dalam class _HomePageState

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
      Widget build(BuildContext context) {...}
    }
Pada method override build berikan return Scaffold untuk membuat halaman aplikasi, ListView pada property body berguna untuk membuat halaman dapat bergulitr ke bawah

    class _HomePageState extends State<HomePage> {
    
      //...
      
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
    
                    //...
    
                ],
              ),
            ),
          ),
        );
      }
    }

Di dalam ListView disini akan menggunakan komponen-komponen(Widget) untuk membangun isi halaman aplikasi
            
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            child: Icon(Icons.keyboard_arrow_left),
                            onPressed: (){
                              decrement();
                            }
                        ),
                        
                        ElevatedButton(
                            child: Icon(Icons.keyboard_arrow_right),
                            onPressed: (){
                              increment();
                            }
                        )
                      ],
                    ),
                  ),

                  //...
                  
                ],
              ),

Text dibuat untuk menampilkan int start dan 2 ElevatedButton(kiri dan kanan) untuk membuat perubahan pada nilai start dengan memanggil method increment() dan decrement. Lalu selanjutnya

        child: ListView(
            children: [

              //...

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

              //...
              
            ],
          ),
Untuk meng*input* angka maka dibutuhkan TextFormField(bisa dilihat atas dan bawah) dan dibungkus dengan Padding untuk merapihkan tampilan, kemudian pada bawahnya terdapat ElevatedButton yang memanggil methos sumOfTwo() untuk menjumlahkan 2 angka yang di*input*, ElevatedButton dibungkus didalam Row dan mengatur mainAxisAlignment: MainAxisAlignment.end agar Button berada di kiri. Pada bagian Text yang mngambil nilai result digunakan untuk menampilkan hasil penjumlahan dan yang terakhir Icons.restart_alt digunakan untuk membuat result menjadi 0 dan mengosongkan controller pada 2 TextFormField atas dan bawah, pada dasarnya banyak icon biasa tidak mampu membuat perubahan(seperti onTap, onPress, onChanged) maka harus menggunakan GestureDetector. Lalu selanjutnya 

    child: ListView(
        children: [

          //...

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

          //...
          
        ],
      ),
TextFormField manampung isian dari user, lalu dengan Icons.send yang dibungkus dengan GestureDetector apabila di*click* maka akan berpindah halaman dan pada halaman baru terdapat pesan yang di*input* oleh user. Buatlah file baru bernama Receiver.dart untuk membuat class, pada class tersebut membuat halaman untuk menerima pesan yang telah dikirim.

Import Receiver.dart terlebih dahulu pada file HomePage.dart agar bisa memanggil class yang terdapat pada Receiver.dart. import bisa dilakukan dengan 2 cara

cara 1

    import 'package:<nama_app>/Receiver.dart';
Cara 2

    import 'Receiver.dart';
Code yang ada pada Receiver.dart

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

Lalu Widget terakhir pada halaman

Sebelumnya buka link [https://pub.dev/](https://pub.dev/) dan cari url_launcher: ^6.1.12(versi bisa berubah). Salin dan paste ke file pubspec.yaml pada bagian dependencies, lihat gambar di bawah

<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%201/url_launcher%20on%20pubspec.yaml.png">
</div>

import pada file HomePage.dart

    import 'package:url_launcher/url_launcher.dart';
    import 'package:flutter/services.dart';

Dan tambahkan code

    child: ListView(
        children: [
    
          //...

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

BApabila Button ini di*klik* maka pengguna akan menuju halaman web https://flutter.dev di browser. Button yang terakhir bukan button bawaan dari flutter melainkan button yang terbuat dari Container dan GestureDetector yang diatur panjang lebarnya.


## Laporan Pendahuluan(LP)
1. Jelaskan apa itu Android!
   
2. Jelaskan apa itu Flutter!
 
3. Jelas apa itu MaterialApp!

4. Berikan keterangan perbedaan StatelessWidget dan StatefulWidget!

## Laporan Akhir(LA)
1. Berikan kesimpulan singkat pada Bab 1!
