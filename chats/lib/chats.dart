import 'dart:async';
import 'dart:developer';
import 'package:chats/data/db.dart';
import 'package:chats/data/grpc_interceptors.dart';
import 'package:chats/env.dart';
import 'package:grpc/grpc.dart';

Future<void> startServer() async {
  runZonedGuarded(() async {
    final authServer = Server([], <Interceptor>[
      GrpsInterceptors.tokenInterceptor,
    ], CodecRegistry(codecs: [GzipCodec()]));

    await authServer.serve(port: Env.port);
    log("Server listen port ${authServer.port}");
    db = initDatebse();
    db.open();
  }, (error, stack) {
    log("Error", error: error);
  });
}
