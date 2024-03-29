import 'dart:isolate';

import 'package:auth/data/db.dart';
import 'package:auth/data/user/user.dart';
import 'package:auth/env.dart';
import 'package:auth/generated/auth.pbgrpc.dart';
import 'package:auth/generated/auth_sms.pbgrpc.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:stormberry/stormberry.dart';
import 'package:username_generator/username_generator.dart';

class AuthRpc extends AuthRpcServiceBase {
  late final ClientChannel _channel;
  late final AuthSmsRpcClient _smsClient;

  AuthRpc() {
    _channel = ClientChannel(
      "auth_sms",
      port: Env.portSms,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _smsClient = AuthSmsRpcClient(_channel);
  }

  @override
  Future<ResponseDto> deleteUser(ServiceCall call, RequestDto request) async {
    final id = Utils.getIdFromMetadata(call);
    await db.users.deleteOne(id);
    return ResponseDto(message: "success");
  }

  @override
  Future<UserDto> fetchUser(ServiceCall call, RequestDto request) async {
    final id = Utils.getIdFromMetadata(call);
    final user = await db.users.queryUser(id);
    if (user == null) throw GrpcError.notFound("user not found");
    return Utils.convertUserDto(user);
  }

  @override
  Future<TokensDto> refreshToken(ServiceCall call, TokensDto request) async {
    if (request.refreshToken.isEmpty) {
      throw GrpcError.invalidArgument("Refresh token not found");
    }

    final id = Utils.getIdFromToken(request.refreshToken);
    final user = await db.users.queryUser(id);
    if (user == null) throw GrpcError.notFound("user not found");
    return _createTokens(user.id.toString());
  }

  @override
  Future<TokensDto> signIn(ServiceCall call, UserDto request) async {
    if (request.email.isEmpty) {
      throw GrpcError.invalidArgument("Email not found");
    }
    if (request.password.isEmpty) {
      throw GrpcError.invalidArgument("Password not found");
    }

    final hashPassword = Utils.getHashPassword(request.password);
    final query = "email='${Utils.encryptField(request.email)}'";
    final users = await db.users.queryUsers(QueryParams(where: query));

    if (users.isEmpty) throw GrpcError.notFound("User not found");
    final user = users.first;
    if (hashPassword != user.password) {
      throw GrpcError.unauthenticated("Password wrong");
    }
    return _createTokens(user.id.toString());
  }

  @override
  Future<TokensDto> signUp(ServiceCall call, UserDto request) async {
    if (request.email.isEmpty) {
      throw GrpcError.invalidArgument("Email not found");
    }
    if (request.password.isEmpty) {
      throw GrpcError.invalidArgument("Password not found");
    }
    if (request.username.isEmpty) {
      throw GrpcError.invalidArgument("Username not found");
    }

    final id = await db.users.insertOne(
      UserInsertRequest(
        username: request.username,
        email: Utils.encryptField(request.email),
        password: Utils.getHashPassword(request.password),
      ),
    );

    return _createTokens(id.toString());
  }

  @override
  Future<UserDto> updateUser(ServiceCall call, UserDto request) async {
    final id = Utils.getIdFromMetadata(call);
    await db.users.updateOne(UserUpdateRequest(
      id: id,
      username: request.username.isEmpty ? null : request.username,
      email: request.email.isEmpty ? null : Utils.encryptField(request.email),
      password: request.password.isEmpty
          ? null
          : Utils.getHashPassword(request.password),
    ));
    final user = await db.users.queryUser(id);
    if (user == null) throw GrpcError.notFound("user not found");
    return Utils.convertUserDto(user);
  }

  TokensDto _createTokens(String id) {
    final accsessTokenSet = JwtClaim(
      maxAge: Duration(hours: Env.accessTokenLife),
      otherClaims: {"user_id": id},
    );
    final refreshTokenSet = JwtClaim(
      maxAge: Duration(hours: Env.refreshTokenLife),
      otherClaims: {"user_id": id},
    );

    return TokensDto(
      accessToken: issueJwtHS256(accsessTokenSet, Env.sk),
      refreshToken: issueJwtHS256(refreshTokenSet, Env.sk),
    );
  }

  @override
  Future<ListUsersDto> findeUser(ServiceCall call, FindDto request) async {
    final limit = int.tryParse(request.limit) ?? 100;
    final offset = int.tryParse(request.offset) ?? 0;
    final key = request.key;
    if (key.isEmpty) return ListUsersDto(users: []);
    final query = "username LIKE '%$key%'";
    final listUsers = await db.users.queryUsers(QueryParams(
      limit: limit,
      offset: offset,
      orderBy: "username",
      where: query,
    ));
    return await Isolate.run(() => Utils.parseUsers(listUsers));
  }

  @override
  Future<TokensDto> sendSms(ServiceCall call, RequestDto request) async {
    if (request.phone.isEmpty) {
      throw GrpcError.invalidArgument("Phone not found");
    }
    if (request.code.isEmpty) {
      throw GrpcError.invalidArgument("Code not found");
    }
    final users = await db.users.queryUsers(QueryParams(
        limit: 1, where: "phone='${Utils.encryptField(request.phone)}'"));
    if (users.isEmpty) {
      throw GrpcError.notFound("User not found");
    } else {
      if (users.first.code != request.code) {
        throw GrpcError.unauthenticated("Code wrong");
      }
      return _createTokens(users.first.id.toString());
    }
  }

  @override
  Future<ResponseDto> signInSms(ServiceCall call, RequestDto request) async {
    if (request.phone.isEmpty) {
      throw GrpcError.invalidArgument("Phone not found");
    }
    try {
      final response =
          await _smsClient.authSms(SmsRequestDto(phone: request.phone));
      final users = await db.users.queryUsers(QueryParams(
          limit: 1, where: "phone='${Utils.encryptField(request.phone)}'"));
      if (users.isEmpty) {
        await db.users.insertOne(UserInsertRequest(
          username: _getRandomUsername(),
          phone: Utils.encryptField(request.phone),
          code: response.sms,
        ));
      } else {
        await db.users.updateOne(UserUpdateRequest(
          id: users.first.id,
          code: response.sms,
        ));
      }
      return ResponseDto(message: "Code sent");
    } catch (e) {
      throw GrpcError.internal(e.toString());
    }
  }

  String _getRandomUsername() => UsernameGenerator().generateRandom();
}
