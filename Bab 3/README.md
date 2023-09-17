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
Pada bab ini kita akan menggunakan studi yang sudah ada bab 2 namun menambahkan State Management Bloc di dalamnya, dengan State Management Bloc aplikasi pada bab 2 akan dibuat tampilan loading selama beberapa detik ketika aplikasi dijalankan, setelah tampilan loading selama beberapa detik kemudian muncul informasi tentang beberapa kucing sama seperti pada bab 2

