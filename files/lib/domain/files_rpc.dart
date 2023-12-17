import 'dart:async';
import 'dart:typed_data';

import 'package:files/domain/i_storage.dart';
import 'package:files/generated/files.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/src/server/call.dart';

final class FilesRpc extends FilesRpcServiceBase {
  final IStorage storage;

  FilesRpc(this.storage);

  @override
  Future<ResponseDto> deleteAvatar(ServiceCall call, AvatarDto request) {
    // TODO: implement deleteAvatar
    throw UnimplementedError();
  }

  @override
  Future<ResponseDto> deleteFile(ServiceCall call, FileDto request) async {
    _checkFields(request);
    if (request.name.isEmpty) {
      throw GrpcError.invalidArgument("Name not found");
    }
    try {
      final message =
          await storage.deleteFile(bucket: request.bucket, name: request.name);
      return ResponseDto(
        isComplete: true,
        message: message,
      );
    } on Object catch (e) {
      throw GrpcError.internal("Delete file is error $e");
    }
  }

  void _checkFields(FileDto request) {
    if (request.bucket.isEmpty) {
      throw GrpcError.invalidArgument("Bucket not found");
    }
  }

  @override
  Future<AvatarDto> fetchAvatar(ServiceCall call, AvatarDto request) {
    // TODO: implement fetchAvatar
    throw UnimplementedError();
  }

  @override
  Stream<FileDto> fetchFile(ServiceCall call, FileDto request) async* {
    _checkFields(request);
    try {
      yield* storage
          .fetchFile(bucket: request.bucket, name: request.name)
          .transform(StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          final arr = Uint8List.fromList(data);
          sink.add(FileDto(data: arr));
        },
      ));
    } catch (e) {
      throw GrpcError.internal("FetchFile is error $e");
    }
  }

  @override
  Future<ResponseDto> putAvatar(ServiceCall call, AvatarDto request) {
    // TODO: implement putAvatar
    throw UnimplementedError();
  }

  @override
  Future<ResponseDto> putFiles(ServiceCall call, FileDto request) async {
    if (request.bucket.isEmpty) {
      throw GrpcError.invalidArgument("Bucket not found");
    }
    if (request.name.isEmpty) {
      throw GrpcError.invalidArgument("Name not found");
    }
    if (request.data.isEmpty) {
      throw GrpcError.invalidArgument("File not found");
    }

    try {
      final tag = await storage.putFile(
        bucket: request.bucket,
        name: request.name,
        data: request.data as Uint8List,
      );
      return ResponseDto(
        isComplete: true,
        message: "PutFile is complete",
        tag: tag,
      );
    } catch (e) {
      throw GrpcError.internal("PutFile is error $e");
    }
  }
}
