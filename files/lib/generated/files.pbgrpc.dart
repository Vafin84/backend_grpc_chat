///
//  Generated code. Do not modify.
//  source: files.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'files.pb.dart' as $0;
export 'files.pb.dart';

class FilesRpcClient extends $grpc.Client {
  static final _$putFiles = $grpc.ClientMethod<$0.FileDto, $0.ResponseDto>(
      '/FilesRpc/PutFiles',
      ($0.FileDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$fetchFile = $grpc.ClientMethod<$0.FileDto, $0.FileDto>(
      '/FilesRpc/FetchFile',
      ($0.FileDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FileDto.fromBuffer(value));
  static final _$deleteFile = $grpc.ClientMethod<$0.FileDto, $0.ResponseDto>(
      '/FilesRpc/DeleteFile',
      ($0.FileDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$putAvatar = $grpc.ClientMethod<$0.AvatarDto, $0.ResponseDto>(
      '/FilesRpc/PutAvatar',
      ($0.AvatarDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$fetchAvatar = $grpc.ClientMethod<$0.AvatarDto, $0.AvatarDto>(
      '/FilesRpc/FetchAvatar',
      ($0.AvatarDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AvatarDto.fromBuffer(value));
  static final _$deleteAvatar =
      $grpc.ClientMethod<$0.AvatarDto, $0.ResponseDto>(
          '/FilesRpc/DeleteAvatar',
          ($0.AvatarDto value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));

  FilesRpcClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.ResponseDto> putFiles($0.FileDto request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$putFiles, request, options: options);
  }

  $grpc.ResponseStream<$0.FileDto> fetchFile($0.FileDto request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$fetchFile, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteFile($0.FileDto request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteFile, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> putAvatar($0.AvatarDto request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$putAvatar, request, options: options);
  }

  $grpc.ResponseFuture<$0.AvatarDto> fetchAvatar($0.AvatarDto request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchAvatar, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteAvatar($0.AvatarDto request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAvatar, request, options: options);
  }
}

abstract class FilesRpcServiceBase extends $grpc.Service {
  $core.String get $name => 'FilesRpc';

  FilesRpcServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.FileDto, $0.ResponseDto>(
        'PutFiles',
        putFiles_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FileDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FileDto, $0.FileDto>(
        'FetchFile',
        fetchFile_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.FileDto.fromBuffer(value),
        ($0.FileDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FileDto, $0.ResponseDto>(
        'DeleteFile',
        deleteFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FileDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AvatarDto, $0.ResponseDto>(
        'PutAvatar',
        putAvatar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AvatarDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AvatarDto, $0.AvatarDto>(
        'FetchAvatar',
        fetchAvatar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AvatarDto.fromBuffer(value),
        ($0.AvatarDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AvatarDto, $0.ResponseDto>(
        'DeleteAvatar',
        deleteAvatar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AvatarDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
  }

  $async.Future<$0.ResponseDto> putFiles_Pre(
      $grpc.ServiceCall call, $async.Future<$0.FileDto> request) async {
    return putFiles(call, await request);
  }

  $async.Stream<$0.FileDto> fetchFile_Pre(
      $grpc.ServiceCall call, $async.Future<$0.FileDto> request) async* {
    yield* fetchFile(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteFile_Pre(
      $grpc.ServiceCall call, $async.Future<$0.FileDto> request) async {
    return deleteFile(call, await request);
  }

  $async.Future<$0.ResponseDto> putAvatar_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AvatarDto> request) async {
    return putAvatar(call, await request);
  }

  $async.Future<$0.AvatarDto> fetchAvatar_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AvatarDto> request) async {
    return fetchAvatar(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteAvatar_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AvatarDto> request) async {
    return deleteAvatar(call, await request);
  }

  $async.Future<$0.ResponseDto> putFiles(
      $grpc.ServiceCall call, $0.FileDto request);
  $async.Stream<$0.FileDto> fetchFile(
      $grpc.ServiceCall call, $0.FileDto request);
  $async.Future<$0.ResponseDto> deleteFile(
      $grpc.ServiceCall call, $0.FileDto request);
  $async.Future<$0.ResponseDto> putAvatar(
      $grpc.ServiceCall call, $0.AvatarDto request);
  $async.Future<$0.AvatarDto> fetchAvatar(
      $grpc.ServiceCall call, $0.AvatarDto request);
  $async.Future<$0.ResponseDto> deleteAvatar(
      $grpc.ServiceCall call, $0.AvatarDto request);
}
