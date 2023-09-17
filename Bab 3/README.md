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

3. Isi nama Bloc, oada kasus bab ini kita beri nama cat

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
Jika pengembang menggunakan Android Studio maka hal diatas tidak bisa di*generate*, maka sebagai gantinya struktur folder dan file dibuat secara manual Ikuti struktur folder dan file untuk State Management Bloc beserta codenya juga 😅.

Buatlah class OnCatEventCalled{} dan extends dari class CatEvent{}, code menjadi berikut

    part of 'cat_bloc.dart';
    
    @immutable
    sealed class CatEvent {}
    
    class OnCatEventCalled extends CatEvent {}
class OnCatEventCalled{} merupakan extends dari CatEvent{}, ini adalah bentuk umum yang digunakan. Pengembang dapat membuat class baru lagi dengan extends dari CatEvent dengan kondisi tertentu dan mendapat warisan tertentu ketika ingin membuat suatu event. Dalam melakukan event tidak hanya menggunakan class yang extends dari abstrac class atau sealed class saja namun dapat juga langsung menggunakan abstrat atau selaed class. Penulisan di atas adalah agar class baru yang extends dari abstract atau sealed class dapat mewarisi dari abstract atau sealed class. Terakhir pengembang juga dapat membuat lebih dari 1 abstract clas sataupun sealed class.
