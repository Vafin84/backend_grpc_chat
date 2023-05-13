import 'package:stormberry/stormberry.dart';

late Database db;

Database initDatebse()=>Database(
  debugPrint: true,
  port: 4500,
  password: "vafin",
  user: "vafin",
  useSSL: false,
);