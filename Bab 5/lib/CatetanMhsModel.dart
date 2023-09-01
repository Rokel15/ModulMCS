class CatetanMhsModel {
  int? id;
  String? tanggal;
  int? warna;
  String? tugas1;
  String? tugas2;
  String? tugas3;
  String? entryTime;

  CatetanMhsModel({
    this.id,
    required this.tanggal,
    required this.warna,
    required this.tugas1,
    required this.tugas2,
    required this.tugas3,
    this.entryTime,
  });

  //toJson
  Map<String, dynamic> tojson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tanggal'] = this.tanggal;
    data['warna'] = this.warna;
    data['tugas1'] = this.tugas1;
    data['tugas2'] = this.tugas2;
    data['tugas3'] = this.tugas3;
    data['entryTime'] = this.entryTime;
    return data;
  }

  //fromJson
  CatetanMhsModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    tanggal = json['tanggal'];
    warna = json['warna'];
    tugas1 = json['tugas1'];
    tugas2 = json['tugas2'];
    tugas3 = json['tugas3'];
    entryTime = json['entryTime'];
  }
}