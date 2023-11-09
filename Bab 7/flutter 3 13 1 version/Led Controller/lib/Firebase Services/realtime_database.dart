import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();
final btnStatus = database.child('btnStatus');
final dataSensor = database.child('dataSensor');