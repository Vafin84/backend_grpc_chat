import 'dart:isolate';
import 'dart:typed_data';

import 'package:files/domain/i_storage.dart';
import 'package:files/env.dart';
import 'package:grpc/grpc.dart';
import 'package:minio/minio.dart';

final class MinioStorage implements IStorage {
  late final Minio minio;

  MinioStorage() {
    minio = Minio(
      port: Env.storagePort,
      endPoint: Env.storageHost,
      accessKey: Env.accessKey,
      secretKey: Env.secretKey,
      useSSL: Env.storageUseSSL,
    );
  }

  @override
  Future<String> putFile(
      {required String bucket,
      required String name,
      required Uint8List data}) async {
    try {
      if (!await minio.bucketExists(bucket)) {
        await minio.makeBucket(bucket);
      }
      return await Isolate.run(() => _putFile(bucket, name, data));
    } on Object {
      rethrow;
    }
  }

  Future<String> _putFile(String bucket, String name, Uint8List data) async {
    final tag =
        await minio.putObject(bucket, name, Stream<Uint8List>.value(data));
    return tag;
  }

  @override
  Future<String> deleteFile(
      {required String bucket, required String name}) async {
    try {
      if (!await minio.bucketExists(bucket)) {
        throw GrpcError.notFound("Bucket $bucket not found");
      }
      return await Isolate.run(() => _deleteFile(bucket, name));
    } on Object {
      rethrow;
    }
  }

  Future<String> _deleteFile(String bucket, String name) async {
    await minio.removeObject(bucket, name);
    return "successe";
  }
}
