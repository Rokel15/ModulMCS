# BAB 3
# State Management Business Logic Component (Bloc)
### Pada bab ini kita akan mempelajari contoh dari Satte Management Bloc
Pada bab ini kita akan belajar bagaimana mmebuat Bloc, Business logic component (Bloc) merupakan salah satu dari pengelolaan state dalam mengembangkan aplikasi flutter. Bloc menjadi pemisah untuk mengatur ui dan data sehingga memungkinkan pengembang aplikasi dalam mengelola state. Terdapat 2 konsep penting yang ada pada Bloc yaitu Event dan State

1. Event
Event adalah pemicu/tindakan yang akan mempengaruhi state, bisa dibilang Event adalah instruksi untuk mempengaruhi suatu keadaan.

2. State
State adalah keadaan atau kondisi. State menggambarkan tampilan dan State berubah sesuai sebagai respon terhadap Event yang diterima.

Maksud dari event dan state dalam BLoC adalah untuk memisahkan bagaimana peristiwa dan tindakan mempengaruhi keadaan aplikasi. Event digunakan untuk memicu perubahan dalam state. Ketika event diterima, BLoC akan memprosesnya dan menghasilkan state yang sesuai. State ini kemudian diberikan ke tampilan untuk di-render.
## Praktikum Bab 3
Pada bab ini kita akan menggunakan studi yang sudah ada bab 2 namun menambahkan State Management Bloc di dalamnya, dengan State Management Bloc aplikasi pada bab 2 akan dibuat tampilan loading selama beberapa detik ketika aplikasi dijalankan, setelah tampilan loading selama beberapa detik kemudian muncul informasi tentang beberapa kucing sama seperti pada bab 2. Kita akan membuat kondisi ini bernama CatLoading dan CatLoaded. State kita atur untuk dalam kondisi CatLoaded(menampilkan widget CircularProgressIndicator()) terlebih dahulu kemudian setelah itu State kita atur dlam kondisi CatLoaded(menampilkan informasi kucing).

Tampilan ketika aplikasi dijalankan/dibuka
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%203/isLoading.PNG" alt="Teks Pengganti">
</div>
Ketika aplikasi dibuka/dijalankan maka aknan menampilkan CircularProgressIndicator() selama beberapa detik sebelum menampilkan informasi tentang kucing. Kondisi ini kita beri nama CatLoading

---
Tampilan aplikasi setelah CatLoading, yaitu CatLoaded
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%203/CatLoaded.PNG" alt="Teks Pengganti">
</div>
Pada kondisi CatLoaded aplikasi menampilkan informasi tentang kucing.

---
Pertama-tama perhatikan struktur folder dan file project untuk bab 3
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%203/struktur%20folder%20dan%20file%20bab%203.PNG" alt="Teks Pengganti">
</div>

Tambahkan dependencies berikut

    bloc: ^8.1.2
    flutter_bloc: ^8.1.3
    get: ^4.6.5
    google_fonts: ^5.1.0

Cek versi paling update di [https://pub.dev/](https://pub.dev/), cari dan salin ke dalam pubspec.yaml

Jika pengembang menggunakan Visual Studio Code untuk menulis code maka pengembang bisa unduh extension bloc dengan nama publisher Felix Angelov atau bisa diunduh manual pada [marketplace Visual Studio Code](https://marketplace.visualstudio.com/), klik [link ini](https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc) untuk menuju langsung ke tempat mengunduh extension bloc dengan nama publisher Felix Angelov.

Keuntungan dari extension ini adalah pengembang bisa *generate* otomatis folder dan file untuk kebutuhan Bloc. Folder dan file untuk kebutuhan Bloc akan di*generate* secara terstruktur sehingga Bloc siap edit dan pakai. Cara *generate* bloc
1. Click kanan folder lib yang ada pada folder project
 
2. Pilih Bloc: New Bloc

3. Isi nama Bloc, pada kasus bab ini kita beri nama cat

Folder dan file yang akan digenerate melalui langkah-langkah di atas akan menjadi seperti berikut
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%203/folder%20dan%20file%20bloc.PNG" alt="Teks Pengganti">
</div>
Di dalam file yang di generate terdapat code yang dibuat otomatis

---
Code pada cat_bloc.dart

    import 'package:bloc/bloc.dart';
    import 'package:meta/meta.dart';
    
    part 'cat_event.dart';
    part 'cat_state.dart';
    
    class CatBloc extends Bloc<CatEvent, CatState> {
      CatBloc() : super(CatInitial()) {
        on<CatEvent>((event, emit) async {});
      }
    }

---
Code pada cat_event.dart

    part of 'cat_bloc.dart';
    
    @immutable
    sealed class CatEvent {}

---
Code pada cat_state.dart

    part of 'cat_bloc.dart';
    
    @immutable
    sealed class CatState {}
    
    final class CatInitial extends CatState {}

---
Sebelumnya disiapkan terlebih dahulu data dummy dan modelnya

code pada file cat.dart untuk model

    class Cat {
      final String urlImage;
      final String name;
      final String desc;
    
      Cat({
        required this.urlImage,
        required this.name,
        required this.desc,
      });
    }
lalu code untuk data dummy pada file cat_data.dart

    List<Cat> catsData = [
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/persia.jpg",
          name: "Persia",
          desc:
              '''Persia merupakan jenis kucing dengan bulu panjang yang lebat dan wajah bulat yang menggemaskan. Mereka dikenal dengan sifat yang tenang, penyayang, dan cocok sebagai kucing peliharaan dalam ruangan.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/ragdoll.png",
          name: "Ragdoll",
          desc:
              '''Ragdoll merupakan kucing besar dengan bulu panjang yang halus dan mata biru memikat. Mereka terkenal dengan kecenderungan mereka untuk rileks dan melonggar saat diangkat, mirip dengan boneka ragdoll, dan sangat penyayang.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/siam.jpeg",
          name: "Siam",
          desc:
              '''Siam merupakan kucing dengan bulu pendek, mata biru tajam, dan tubuh yang ramping. Mereka dikenal sebagai kucing vokal yang suka berbicara dan memiliki kepribadian yang aktif serta ramah.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/sphynx.jpg",
          name: "Sphynx",
          desc:
              '''Sphynx merupakan jenis kucing tanpa bulu yang memiliki kulit lembut seperti kulit jeruk. Mereka sering menjadi perhatian dengan penampilan yang unik dan ramah serta cerdas dalam perilaku mereka.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/maine%20coon.jpg",
          name: "Maine Coon",
          desc:
              '''Maine Coon merupakan salah satu kucing terbesar dengan bulu panjang dan ekor berbulu tebal. Mereka memiliki sifat yang ramah, lembut, dan cenderung energik, serta memiliki fisik yang kuat.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/munchkin.jpg",
          name: "Munchkin",
          desc:
              '''Munchkin merupakan jenis kucing dengan tubuh pendek dan kaki yang lebih pendek dari kucing biasa. Mereka memiliki penampilan unik yang lucu dan aktif dalam bermain.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/bengal.png",
          name: "Bengal",
          desc:
              '''Bengal memiliki bulu yang berkilau dengan motif belang yang mirip macan tutul. Mereka aktif, cerdas, dan suka bermain, sering kali memiliki energi yang tinggi.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/britain%20shorthair.jpg",
          name: "Britain Shorthair",
          desc:
              '''British Shorthair memiliki penampilan gemuk dengan wajah yang bulat dan mata besar. Mereka cenderung tenang, santai, dan mudah diurus, membuat mereka menjadi kucing peliharaan yang populer.''')
    ];

---
Lanjut untuk membuat state managemenet bloc. Buatlah class OnCatEventCalled{} dan extends dari class CatEvent{}, code pada file cat_event.dart menjadi berikut

    part of 'cat_bloc.dart';
    
    @immutable
    sealed class CatEvent {}
    
    class OnCatEventCalled extends CatEvent {}
class OnCatEventCalled{} merupakan extends dari CatEvent{}, ini adalah bentuk umum yang digunakan. Pengembang dapat membuat class baru lagi dengan extends dari CatEvent dengan kondisi tertentu dan mendapat warisan tertentu ketika ingin membuat suatu event. Dalam melakukan event tidak hanya menggunakan class yang extends dari abstrac class atau sealed class saja namun dapat juga langsung menggunakan abstrat atau selaed class. Penulisan di atas adalah agar class baru yang extends dari abstract atau sealed class dapat mewarisi dari abstract atau sealed class. Terakhir pengembang juga dapat membuat lebih dari 1 abstract clas sataupun sealed class.

---
Buatlah beberapa state untuk CatLoaded dan CatLoaded, code pada file cat_state.dart menjadi berikut

    part of 'cat_bloc.dart';
    
    @immutable
    sealed class CatState {}
    
    final class CatInitial extends CatState {}
    
    final class CatLoading extends CatState {}
    
    final class CatLoaded extends CatState {
      final List<Cat> result;
    
      CatLoaded(this.result);
    }
class CatInitial digunakan untuk menginisialisasi state, class CatLoading akan digunakan untuk membuat menunggu dengan menampilkan CircularProgressIndicator() sebelum halaman informasi kucing ditampilkan dan CatLoaded digunakan untuk menampilkan informasi kucing. Pada dasarnya class-class state inilah yang akan digunakan untuk membuat ketentuan state(kondisi pada aplikasi) akan jadi seperti apa.

---
Terakhir atur Event dengan ketentuan state-state tertentu

    import 'package:bloc/bloc.dart';
    import 'package:meta/meta.dart';
    
    part 'cat_event.dart';
    part 'cat_state.dart';
    
    class CatBloc extends Bloc<CatEvent, CatState> {
      CatBloc() : super(CatInitial()) {
        on<OnCatEventCalled>((event, emit) async {
          emit(CatLoading());
          await Future.delayed(const Duration(seconds: 2));
          emit(CatLoaded(catsData));
        });
      }
    }
Dalam pengaturan kali in method on berfungsi untuk mengatur sebuah Event dan menetukan statenya. Pada code di atas bisa dilihat mengatur bloc dalam class extends dari CatEvent dan CatState, di dalam class ini kita membuat 1 method on dengan parameter OnCatEventCalled lalu di dalam method ini kita mengatur statenya. Umumnya dalam membuat State Management Bloc kita dapat membuat banyak method on dengan paraeter Event yang sudah dibuat, namun parameter pada method on tidak bisa dengan Event yang sama, parameter pada method on juga bisa menggunakan class abstract/sealed.

---
Sudah sejauh ini penulisan code kita akan lanjut membuat aplikasinya, masukkan code berikut pada file main.dart

    import 'package:flutter_bloc/flutter_bloc.dart';
    import 'package:get/get.dart';
    
    void main() {
      runApp(const CatBreedApp());
    }
    
    class CatBreedApp extends StatelessWidget {
      const CatBreedApp({Key? key}) : super(key: key);
    
      @override
      Widget build(BuildContext context) {
        return BlocProvider(
          create: (context) => CatBloc()..add(OnCatEventCalled()),
          child: GetMaterialApp(
            title: 'Cat Breed',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(colorScheme: const ColorScheme.dark()),
            home: const CatOverviewScreen(),
          ),
        );
      }
    }
Jika biasanya dalam menginisialisasi/memulai aplikasi return dari Widget build adalah MaterialApp maka kali ini menggunakan BlocProvider, karena Event akan dilakukan ketika aplikasi dijalankan/dibuka. Pada kasus yang lain Event dijalankan pada saat pengguna apllikasi meng*klik* suatu button.
pada bagian

    create: (context) => CatBloc()..add(OnCatEventCalled())
penggunaan ..add() bertujuan agar mempersingkat penulisan, jadi tidak perlu menggunakan objek lagi untuk mengakses OnCatEventCalled()

---
Masukkan code pada file cats_overview_screen.dart untuk membuat ui

    class CatOverviewScreen extends StatelessWidget {
      const CatOverviewScreen({super.key});
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Cats'),
          ),
          body: BlocBuilder<CatBloc, CatState>(
            builder: (context, state) {
              if (state is CatLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
    
              if (state is CatLoaded) {
                final cats = state.result;
                return ListView(
                  children: [
                    Center(
                      child: Text(
                        'Jenis-jenis Kucing',
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    ListView.builder(
                      itemCount: cats.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cat = cats[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: InkWell(
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.width / 4,
                                    child: Image.network(
                                      cat.urlImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    cat.name,
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.to(DetailPage(
                                cat: cat,
                              ));
                            },
                          ),
                        );
                      },
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        );
      }
    }
Dalam code ini terdapat percabangan untuk menilai kondisi dan memutuskan bagaimana halaman akan dibentuk sesuai dengan pengaturan pada bloc
          
          if (state is CatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CatLoaded) {
            final cats = state.result;
            return ListView(
              children: [
                Center(
                  child: Text(
                    'Jenis-jenis Kucing',
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                ),
                ListView.builder(
                  itemCount: cats.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {...},
                )
              ],
            );
          }
          return Container();
Sebelumnya kita sudah atur dalam bloc pada bagian

    on<OnCatEventCalled>((event, emit) async {
      emit(CatLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(CatLoaded(catsData));
    });
pada method on<OnCatEventCalled> kita akan atur state/kondisi menjadi CatLoading, dan loading akan berjalan selama 2 detik kemudian state/kondisi akan menjadi CatLoaded yang mengemnbalikan List catsData, ketika dalam kondisi CatLoading maka tampilan aplikasi akan menampilkan CircularProgressIndicator()

    if (state is CatLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
dan ketika dalam kondisi catLoaded maka aplikasi akan menampilkan informasi tentang kucing

          if (state is CatLoaded) {
            final cats = state.result;
            return ListView(
              children: [
                Center(
                  child: Text(
                    'Jenis-jenis Kucing',
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                ),
                ListView.builder(
                  itemCount: cats.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {...},
                )
              ],
            );
          }
Karena CatLoaded mengembalikan nilai bertipe List maka untuk mengakses nilai tersebut dapat menggunakan

    final cats = state.result;
Sehingga variabel cats berisikan nilai List yang dikembalikan oleh CatLoaded. Terakhir adalah code untuk menampilkan halaman detail informasi kucing berdasarkan index.

    class DetailPage extends StatefulWidget {
      const DetailPage({Key? key, required this.cat}) : super(key: key);
      final Cat cat;
      @override
      State<DetailPage> createState() => _DetailPageState();
    }
    
    class _DetailPageState extends State<DetailPage> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.cat.name),
          ),
          body: Material(
            child: ListView(
              children: [
                Image.network(widget.cat.urlImage),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Text(
                    widget.cat.desc,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
Halaman dapat berpindah dari halaman tentang informasi beberapa kucing menjadi halaman detail kucing berdasarkan index menggunakan InkWell(), InkWell() ditulis pada saat membuat halaman informasi kucing dengan menggunakan ListView.builder()

                ListView.builder(
                  itemCount: cats.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cat = cats[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4,
                                child: Image.network(
                                  cat.urlImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                cat.name,
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.to(DetailPage(
                            cat: cat,
                          ));
                        },
                      ),
                    );
                  },
                )
Halaman berpindah dengan 

    onTap: () {
      Get.to(DetailPage(
        cat: cat,
      ));
    },

---
## Laporan Pendahuluan(LP)
1. Sebutkan jenis-jenis State Management pada Flutter!

2. Jelaskan apa itu State Management Bloc!
   
3. Jelaskan apa yang dimaksud dengan Event dan State!
 
4. Apakah bisa menggunakan jenis Event yang sama pada 2 method on atau lebih?

## Laporan Akhir(LA)
1. Berikan kesimpulan singkat pada Bab 3!
