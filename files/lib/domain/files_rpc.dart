import 'dart:async';
import 'dart:typed_data';

import 'package:files/domain/i_storage.dart';
import 'package:files/generated/files.pbgrpc.dart';
import 'package:files/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/src/server/call.dart';

final class FilesRpc extends FilesRpcServiceBase {
  final IStorage storage;

  FilesRpc(this.storage);

  @override
  Future<ResponseDto> deleteAvatar(ServiceCall call, FileDto request) async {
    try {
      final id = Utils.getIdFromMetadata(call);
      await storage.deleteFile(bucket: "avatars", name: id.toString());
      return ResponseDto(
        isComplete: true,
        message: "Delete avatar is complete",
      );
    } catch (e) {
      throw GrpcError.internal("Delete avatar is error $e");
    }
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
  Future<FileDto> fetchAvatar(ServiceCall call, FileDto request) {
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
  Future<ResponseDto> putAvatar(ServiceCall call, FileDto request) async {
    if (request.data.isEmpty) {
      throw GrpcError.invalidArgument("File not found");
    }
    if (request.data.length > 1000000) {
      throw GrpcError.invalidArgument("Avatar is very big");
    }
    try {
      final id = Utils.getIdFromMetadata(call);
      final tag = await storage.putFile(
          bucket: "avatars",
          name: id.toString(),
          data: request.data as Uint8List);

      return ResponseDto(
        isComplete: true,
        message: "Put avatar is complete",
        tag: tag,
      );
    } catch (e) {
      throw GrpcError.internal("PutAvatar is error $e");
    }
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
