import 'dart:async';

import 'package:auth/data/db.dart';
import 'package:auth/env.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

final _excludeMethodos = [
  "SignUp",
  "SignIn",
  "RefreshToken",
  "SendSms",
  "signInSms",
];

abstract class GrpsInterceptors {
  static FutureOr<GrpcError?> tokenInterceptor(
    ServiceCall call,
    ServiceMethod serviceMethod,
  ) {
    _checkDatabase();
    try {
      if (_excludeMethodos.contains(serviceMethod.name)) return null;
      final token = call.clientMetadata?["token"] ?? "";
      final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
      jwtClaim.validate();
      return null;
    } catch (_) {
      return GrpcError.unauthenticated();
    }
  }

  static void _checkDatabase() {
    if (db.connection().isClosed) {
      db = initDatebse();
    }
  }
}
