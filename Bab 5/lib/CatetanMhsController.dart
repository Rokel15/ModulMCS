import 'package:get/get.dart';
import 'package:mcs_bab_5/CatetanMhsModel.dart';
import 'DB.dart';

class CatetanMhsController extends GetxController{

  @override
  void onReady() {
    super.onReady();
  }

  var CatetanMhsList = [].obs;

  //get all data from table
  void getCatetanMhsData() async{
    List<Map<String, dynamic>> CatetanMhsData = await DB.query();
    CatetanMhsList.assignAll(CatetanMhsData.map((e) => new CatetanMhsModel.fromJson(e)).toList());
  }

  //input atau tambah data
  Future<int> addCatetanMhs({required CatetanMhsModel catetanMhsModel}) async{
    return await DB.insert(catetanMhsModel!);
  }

  //delete
  void delete(CatetanMhsModel catetanMhsModel) async{
    DB.delete(catetanMhsModel);
  }

  //update warna 0
  void warna0(int id) async{
    await DB.updateWarna0(id);
  }

  //update warna 1
  void warna1(int id) async{
    await DB.updateWarna1(id);
  }

  //update warna 2
  void warna2(int id) async{
    await DB.updateWarna2(id);
  }

  //update warna 3
  void warna3(int id) async{
    await DB.updateWarna3(id);
  }

  //empty Tugas 1
  void emptyTugas1(int id) async{
    await DB.emptyTugas1(id);
  }

  //empty Tugas 2
  void emptyTugas2(int id) async{
    await DB.emptyTugas2(id);
  }

  //empty Tugas 3
  void emptyTugas3(int id) async{
    await DB.emptyTugas3(id);
  }
}