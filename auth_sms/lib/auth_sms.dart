import 'dart:async';
import 'dart:developer';

import 'package:auth_sms/domain/auth_sms_rpc.dart';
import 'package:auth_sms/env.dart';
import 'package:grpc/grpc.dart';

Future<void> startServer() async {
  runZonedGuarded(() async {
    final authSmsServer = Server.create(
      services: [AuthSmsRpc()],
      codecRegistry: CodecRegistry(codecs: [GzipCodec()]),
    );

    await authSmsServer.serve(port: Env.port);
    log("Server authSmsServer listen port ${authSmsServer.port}");
  }, (error, stack) {
    log("Error", error: error);
  });
}
