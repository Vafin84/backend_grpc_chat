import 'dart:convert';

import 'package:auth/data/user/user.dart';
import 'package:auth/env.dart';
import 'package:auth/generated/auth.pb.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class Utils {
  static String getHashPassword(String password) {
    final List<int> bytes = utf8.encode(password + Env.sk);
    return sha256.convert(bytes).toString();
  }

  static String encryptField(String value, {bool isDecode = false}) {
    final key = Key.fromUtf8(Env.dbsk);
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key, mode: AESMode.ecb));

    return isDecode
        ? encryptor.decrypt64(value, iv: iv)
        : encryptor.encrypt(value, iv: iv).base64;
  }

  static int getIdFromToken(String token) {
    final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
    final id = int.tryParse(jwtClaim["user_id"]);
    if (id == null) throw GrpcError.dataLoss("User id not found");
    return id;
  }

  static int getIdFromMetadata(ServiceCall serviceCall) {
    final accessToken = serviceCall.clientMetadata?["token"] ?? "";
    return getIdFromToken(accessToken);
  }

  static UserDto convertUserDto(UserView user) => UserDto(
        id: user.id.toString(),
        email: encryptField(user.email ?? "", isDecode: true),
        username: user.username,
      );
  static ListUsersDto parseUsers(List<UserView> users) {
    try {
      return ListUsersDto(users: [...users.map((e) => convertUserDto(e))]);
    } catch (e) {
      throw GrpcError.internal('Error in parseUsers ${e.toString()}');
    }
  }
}
