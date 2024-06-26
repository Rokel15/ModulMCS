# Bab 4
# Firestore
### Pada bab ini kita akan mempelajari firestore
Firebase adalah layanan yang disediakan oleh google dan dapat digunakan oleh pengembang aplikasi mobile ataupun web, dengan adanya firebase para pengembang dapat mengembangkan aplikasi tanpa harus membangun back end dari awal. Salah satu fitur yang terdapat pada firebase adalah firestore, firestore adalah database berbentuk document (nosql).
## Praktikum Bab 4
Bab sebelumnya kita mempelajari database yang disimpan di storage lokal, dan pada praktikum kali ini kita akan membuat database yang berjalan secara online

Pada praktikum bab 4 kita tidak akan berfokus pada tampilan, namun kita akan fokus pada fungsi yaitu bagaimana cara membuat database, mengambil data dari database dan melalukan perubahan pada database(update dan delete)

tampilan aplikasi akan seperti berikut

![MainPage](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%205/MainPage.PNG)

tampilan di atas adalah tampilan utama, apabila user memasukan data dan press tombol input maka data akan masuk ke database dan data diambil dari database lalu ditampilkan di bawah tulisan hasil input pada halaman aplikasi

![hasil input](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%205/hasil%20input.PNG)

lalu icon-icon yang berada di sebelah data hasil input memiliki masing-masing fungsi

![icons](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%205/icons%20in%20mainpage.PNG)

Icons.delete_forever digunakann untuk menghapus 1 document(jika di database sql disebutnya 1 record)

Icons.arrow_circle_down digunakan untuk mengubah number menjadi berkurang

Icons.arrow_circle_up digunakan untuk mengubah number menjadi bertambah

Icons.chevron_right digunakan untuk berpindah halaman ke halaman EditPage

adapun halaman EditPage adalah sebagai berikut

![EditPage](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%205/Editpage.PNG)

terdapat juga button delete dan update, apa yang diperbarui pada head dan body apabila user menekan tombol button update maka data pada database akan berubah dan halaman aplikasi akan balik ke halaman MainPage.

---
### Konfigurasi Firebase
Kita akan mengatur agar firebase dapat terhubung dengan aplikasi, konfigurasi firebase yang akan kita kerjakan bisa dilihat pada dokumentasi [https://firebase.google.com/docs/cli#install-cli-windows](https://firebase.google.com/docs/cli#install-cli-windows) dan [https://firebase.google.com/docs/flutter/setup?platform=android](https://firebase.google.com/docs/flutter/setup?platform=android). Kita melakukan konfigurasi firebase menggunakan CLI.

1. Unduh [node js](https://nodejs.org/en) dan install [node js](https://nodejs.org/en)

2. setelah melakukan instalasi tambahkan path C:\Users\<nama user pada perangkat>\AppData\Local\Pub\Cache\bin ke environment user variable

3. Buka command prompt(cmd)

4. ketik pada cmd npm install -g firebase-tools untuk melakukan instalasi tools dari firebase. Tunggu hingga proses instalasi selesai
```cmd
npm install -g firebase-tools
```
5. lalu ketik firebase login, nanti akan terdapat url dan langsung diarahkan ke browser dengan url yang dituju untuk login akun google
```cmd
firebase login
```
6. Jika sudah login dan apabila sebelumnya pernah membuat project pada firebase maka list dari project yang pernah dibuat tersebut dapat dilihat dengan mengunakan command firebase projects:list
```cmd
firebase projects:list
```
8. Lakukan instalasi flutterfire cli
```cmd
dart pub global activate flutterfire_cli
```
9. Pergi ke flutter project directory yang anda buat

10. Ketik flutterfire configure untuk konfigurasi firebase dalam project
```cmd
flutterfire configure
```
12. Nanti akan muncul file firebase_options.dart pada folder lib yang dibuat secara otomatis setelah memasukkan command flutterfire configure

![](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%205/firebase_options.dart.png)

14. Tambahkan package firebase_core: ^2.20.0(versi ini adalah terbaru saat modul ini dibuat, mungkin nanti ada perubahan) ke pubspec.yaml dan juga tambahkan package cloud_firestore: ^4.12.1(versi ini adalah terbaru saat modul ini dibuat, mungkin nanti ada perubahan) karena kita akan menggunakan firestore untuk menyimpan data.

---
### Membuat Aplikasi
PErhatikan file-file berikut

![project files](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%205/project%20files.PNG)

buatlah file Mainpage.dart, EditPage.dart, ShowData.dart. Lalu kita mulai untuk membuat aplikasinya

code pada main.dart
```dart
import 'package:bab_4_mcs/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mcs bab4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
```
Penjelasan code

    void main() async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      runApp(const MyApp());
    }
Buatlah void main menjadi asynchronous, dalam body main tambahkan WidgetsFlutterBinding.ensureInitialized(); untuk memastikan sebelum aplikasi berjalan  inisialisasi yang diperlukan untuk pengelolaan widget, rendering, dan fungsi-fungsi dasar lainnya telah selesai dan tambahkan await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); untuk menginisialisasi firebase pada aplikasi.

    class MyApp extends StatelessWidget {
      const MyApp({super.key});
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'mcs bab4',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.dark(),
            useMaterial3: true,
          ),
          home: const MainPage(),
        );
      }
    }
Untuk bagian ini masih sama seperti bab-bab sebelumnya. Ketika aplikasi berjalan halaman awal aplikasi adalah halaman yang dibentuk dari class MainPage().

code pada MainPage.dart
```dart
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
```
Penjelasan code

    TextEditingController headController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    TextEditingController numberController = TextEditingController();
Membuat controller untuk TextFormField yang akan dimuat pada halaman aplikasi dan Tambahkan dispose untuk menghindari kebocoran penyimpanan aplikasi

    @override
    void dispose() {
      headController.dispose();
      bodyController.dispose();
      numberController.dispose();
      super.dispose();
    }

Di dalam method build buatlah instance dari firestore dan buatlah koleksi dengan anam bebas(jika di database sql sebutannya adalah nama table)
    
    @override
    Widget build(BuildContext context) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection('mcs bab 4');
  
      return Scaffold(
        appBar: AppBar(title: Text('mcs bab 4'), backgroundColor: Colors.black,),
        body: ListView(...)
      );
    }
Property body pada Scaffold menggunakan ListView dan di dalam ListView terdapat beberapa widget

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
Di setiap Row terdapat TextFormField dengan controller dan hintText yang sudah ditentukan, pada TextFormField yang terakhir keyboardType diatur agar tipe keyboard yang muncul hanya angka saja dan inputFormatters dibuat agar hanya angka saja yang dapat masuk ke dalam TextFormField.

Kemudian di bawahnya terdapat elevatedbutton

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
dengan button ini kita menambahkan data dari TextFormField ke collection lalu TextFormField dikosongkan kembali. Di website firebase akam terlihat bahwa data telah masuk ke database seperti gambar di bawah

![data di firestore](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%205/hasil%20input%20data.PNG)

Data pada gambar di atas hanyalah contoh apabila user memasukkan head = "qwer" untuk body = "qwertyuiop" dan number = 3

Selanjutnya pada halaman aplikasi tepat di bawah tulisan 'hasil input :' kita akan menampilkan data yang dibaca dari database menggunakan Strea,Builder()

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
StreamBuilder() bersifat relatime, appabila kita melakukan perubahan baik melalui aplikasi ataupun langsung dari firestore maka data yang dibaca dengan StreamBuilder() akan langsung berubah sesuai yang ada pada firestore. Pada code di atas memiliki return Column(). Di dalam Column tidak seperti List biasanya namun akan dibuat menjadi children: snapshot.data!.docs.map((e) => ShowData()).toList dimana kita akan mapping data lalu kita konversi ke dalam bentuk list dengan toList(). Adapun ShowData() adalah sebuah class yang digunakan untuk menampilkan data yang ada pada firestore, oleh karena itu class ShowData memiliki constructor seperti head, body, number, onDelete, numberDecrement dan numberIncrement.
```
head: (e.data() as dynamic)['head'].toString(),
```
constructor head akan diisi untuk menampilkan 'head' dari firestore
```
body: (e.data() as dynamic)['body'].toString(),
```
constructor body akan diisi untuk menampilkan 'body' dari firestore
```
number: (e.data() as dynamic)['number'].toString(),
```
constructor number akan diisi untuk menampilkan 'number' dari firestore
```
onDelete: (){collectionReference.doc(e.id).delete();},
```
constructor onDelete akan diisi untuk menghapus 1 document(1 record) dari firestore
```
numberDecrement: (){
  Map<String, dynamic> data = e.data() as Map<String, dynamic>;
  int number = data['number'] as int;
  collectionReference.doc(e.id).update({'number': number - 1});
}
```
constructor numberDecrement akan diisi untuk membuat perubahan pada nilai number dikurang 1 setiap kali user klik Icons.arrow_circle_down
```
numberIncrement: (){
  Map<String, dynamic> data = e.data() as Map<String, dynamic>;
  int number = data['number'] as int;
  collectionReference.doc(e.id).update({'number': number + 1});
},
```
constructor numberIncrement akan diisi untuk membuat perubahan pada nilai number ditambah 1 setiap kali user klik Icons.arrow_circle_up
```
toEditPage: () async{
  DocumentSnapshot documentSnapshot = await collectionReference.doc(e.id).get();
  Navigator.push(context, MaterialPageRoute(
    builder: (context){
      return EditPage(documentSnapshot: documentSnapshot);
    },
  ));
},
```
constructor toEditPage akan diisi untuk perpindahan halaman ke EditPage. Halaman EditPage dibentuk dari class EditPage yang nantinya digunakan untuk melakukan perubahan data, class EditPage mempunyai constructor untuk mengisi documentSnapshot, agar ketika class EditPage dipanggil dari MainPage data documentSnapshot dapat dikirim ke class EditPage. documentSnapshot berisi = await collectionReference.doc(e.id).get(); untuk mengambil nilai document dengan method get()

Membuat class ShowData pada file ShowData.dart

code pada ShowData.dart
```dart
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
```
Penjelasan code

Kita membuat constructor pada class ShowData, dari constructor tersebut data yang didapatkan bermacam-macam digunakan ke dalam widget sesuai kegunaannya, seperti
```
Text('head : ${widget.head}'),
Text('body : ${widget.body}'),
```
digunakan untuk menampilkan data dari firestore

adapun yg lainnya
```
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
```
Menggunakan function onDelete(), numberDecrement(), numberIncrement() dan toEditPage(). Selanjutnya kita membuat halaman EditPage, halaman yang digunakan untuk melakukan perubahan data, kita membuat file baru bernama EditPage yang berisikan class EditPage untuk membuat halaman EditPage.

code pada EditPage.dart
```dart
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

  @override
  void dispose() {
    headController.dispose();
    bodyController.dispose();
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
```
Penjelasan code

Kita sediakan terlebih dahulu controllernya dan juga disposenya untuk menghindari kebocoran memori aplikasi, karena nanti kita akan membuat TextFormField untuk mengisi pembaruan data pada firestore
```
class EditPage extends StatefulWidget {

  //...

}
class _EditPageState extends State<EditPage> {
  TextEditingController headController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    headController.dispose();
    bodyController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //...
  }
}
```
Membuat variabel data
```
class EditPage extends StatefulWidget {

  //...

}
class _EditPageState extends State<EditPage> {
  
  //...
  
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.documentSnapshot.data() as Map<String, dynamic>;

    headController.text = data['head'];
    bodyController.text = data['body'];

    return Scaffold(
        appBar: AppBar(title: Text('Edit Page'),),
        body: ListView(
          //...
        )
    );
  }
}
```
variabel data menampung documentSnapshot dan dibuat sebagai Map dengan Map, lalu headController.text = data['head']; dan bodyController.text = data['body']; agar ketika halaman EditPage dibuka maka TextFormField sudah memiliki isi dari documentSnapshot.

Lalu berikutnya pada Button
```
class EditPage extends StatefulWidget {

  //...

}

class _EditPageState extends State<EditPage> {

  //...
  
  @override
  Widget build(BuildContext context) {

    //...

    return Scaffold(
      appBar: AppBar(title: Text('Edit Page'),),
      body: ListView(
        children: [
          //...

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
```
Untuk button yang bertuliskan delete digunakan untuk menghapus 1 document(1 record) dengan documentSnapshot.reference.delete(); dan button yang bertuliskan update digunakan untuk memperbarui data dengan format mapping dan pastikan penamaan sama dengan yang ada di document, misal yang terdapat pada document adalah 'head' maka saat update juga harus sama persis 'head'.

---
## Laporan pendahuluan(LP)
1. Jelaskan apa itu database noSQL!

2. Jelaskan apa itu firebase!

3. Jelaskan apa itu cloud firestore!

4. Seberapa penting peranan database noSQL pada suatu sistem!
## Laporan Akhir(LA)
1. Berikan kesimpulan singkat pada Bab 4!
