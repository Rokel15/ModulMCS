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
Pada bab ini kita akan menggunakan studi yang sudah ada bab 2 namun menambahkan State Management Bloc di dalamnya, dengan State Management Bloc aplikasi pada bab 2 akan dibuat tampilan loading selama beberapa detik ketika aplikasi dijalankan, setelah tampilan loading selama beberapa detik kemudian muncul informasi tentang beberapa kucing sama seperti pada bab 2. Kita akan membuat kondisi ini bernama isLoading dan isLoaded. State kita atur untuk dalam kondisi isLoading(menampilkan widget CircularProgressIndicator()) terlebih dahulu kemudian setelah itu State kita atur dlam kondisi isLoaded(menampilkan informasi kucing).

Tampilan ketika aplikasi dijalankan/dibuka
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%203/isLoading.PNG" alt="Teks Pengganti">
</div>
Ketika aplikasi dibuka/dijalankan maka aknan menampilkan CircularProgressIndicator() selama beberapa detik sebelum menampilkan informasi tentang kucing. Kondisi ini kita beri nama isLoading

---
Tampilan aplikasi setelah isLoading, yaitu isLoaded
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%203/isLoaded.PNG" alt="Teks Pengganti">
</div>
Pada kondisi isLoaded aplikasi menampilkan informasi tentang kucing.

---
Pertama-tama tambahkan dependencies berikut

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
Jika pengembang menggunakan Android Studio maka hal diatas tidak bisa di*generate*, maka sebagai gantinya struktur folder dan file dibuat secara manual Ikuti struktur folder dan file untuk State Management Bloc beserta codenya juga 😅.

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
Buatlah beberapa state untuk isLoading dan isLoaded, code pada file cat_state.dart menjadi berikut

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

