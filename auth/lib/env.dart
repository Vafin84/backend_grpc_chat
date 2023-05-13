import 'dart:io';

abstract class Env {
  static String sk = Platform.environment["SK"] ?? "SK";
  static String dbsk = Platform.environment["DBSK"] ?? "McQfTjWnZr4u7x!A";

  static int accessTokenLife =
      int.tryParse(Platform.environment["ACCESS_TOKEN_LIFE"] ?? "5") ?? 5;
  static int refreshTokenLife =
      int.tryParse(Platform.environment["REFRESH_TOKEN_LIFE"] ?? "10") ?? 10;
}
