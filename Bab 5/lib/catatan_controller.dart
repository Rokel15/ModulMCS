import 'package:get/get.dart';
import 'package:mcs_bab_5/catatan_model.dart';
import 'DB.dart';

class CatatanController extends GetxController {
  var catatanList = [].obs;

  //get all data from table
  void getCatatanData() async {
    List<Map<String, dynamic>> catatanData = await DB.query();
    catatanList.assignAll(catatanData.map((e) => Catatan.fromJson(e)).toList());
  }

  //input atau tambah data
  Future<int> addCatatan({required Catatan catatan}) async {
    return await DB.insert(catatan);
  }

  //delete
  void delete(Catatan catatan) async {
    DB.delete(catatan);
  }

  //update warna 0
  void warna0(int id) async {
    await DB.updateWarna0(id);
  }

  //update warna 1
  void warna1(int id) async {
    await DB.updateWarna1(id);
  }

  //update warna 2
  void warna2(int id) async {
    await DB.updateWarna2(id);
  }

  //update warna 3
  void warna3(int id) async {
    await DB.updateWarna3(id);
  }

  //empty Tugas 1
  void emptyTugas1(int id) async {
    await DB.emptyTugas1(id);
  }

  //empty Tugas 2
  void emptyTugas2(int id) async {
    await DB.emptyTugas2(id);
  }

  //empty Tugas 3
  void emptyTugas3(int id) async {
    await DB.emptyTugas3(id);
  }
}
