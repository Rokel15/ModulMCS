# Bab 6
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
