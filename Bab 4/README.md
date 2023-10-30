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

1 Unduh [node js](https://nodejs.org/en) dan install [node js](https://nodejs.org/en)

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

![]{}

14. 14
