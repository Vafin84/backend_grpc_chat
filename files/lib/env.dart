import 'dart:io';

abstract class Env {
  static int port = int.parse(Platform.environment["PORT"] ?? "4402");
  static String sk = Platform.environment["SK"]!;
  static String skFile =
      Platform.environment["FILES_SK_FILE"] ?? "McQfTjWnZr4u7x!A";
  static String accessKey = Platform.environment["FILES_ACCESS_KEY"] ?? "admin";
  static String secretKey =
      Platform.environment["FILES_SECRET_KEY"] ?? "FILES_SECRET_KEY";
  static bool storageUseSSL =
      bool.tryParse(Platform.environment["FILES_USE_SSL"] ?? "false") ?? false;
  static int storagePort =
      int.tryParse(Platform.environment["FILES_STORAGE_PORT"] ?? "9000") ??
          9000;
  static String storageHost =
      Platform.environment["FILES_STORAGE_HOST"] ?? "localhost";
}
