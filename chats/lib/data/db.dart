import 'package:stormberry/stormberry.dart';

late Database db;

Database initDatebse() => Database(
      host: "127.0.0.1",
      port: 4501,
      useSSL: false,
      user: "vafin",
      password: "vafin",
    );
