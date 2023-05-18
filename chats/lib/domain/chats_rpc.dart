import 'dart:isolate';

import 'package:chats/data/chat/chat.dart';
import 'package:chats/data/db.dart';
import 'package:chats/generated/chats.pbgrpc.dart';
import 'package:chats/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:stormberry/stormberry.dart';

class ChatRpc extends ChatsRpcServiceBase {
  @override
  Future<ResponseDto> createChat(ServiceCall call, ChatDto request) async {
    final id = Utils.getIdFromMetadata(call);
    if (request.name.isEmpty) {
      throw GrpcError.invalidArgument("Chat name not found");
    }
    await db.chats.insertOne(
      ChatInsertRequest(
        name: request.name,
        authorId: id.toString(),
      ),
    );
    return ResponseDto(message: "success");
  }

  @override
  Future<ResponseDto> deleteChat(ServiceCall call, ChatDto request) async {
    final authorId = Utils.getIdFromMetadata(call);
    final chatId = int.tryParse(request.id);
    if (chatId == null) throw GrpcError.invalidArgument("Chat id not found");
    final chat = await db.chats.queryChat(chatId);
    if (chat == null) throw GrpcError.notFound("Chat not found");
    if (chat.authorId == authorId.toString()) {
      await db.chats.deleteOne(chatId);
      return ResponseDto(message: "success");
    } else {
      throw GrpcError.permissionDenied();
    }
  }

  @override
  Future<ResponseDto> deletemesage(ServiceCall call, MessageDto request) {
    // TODO: implement deletemesage
    throw UnimplementedError();
  }

  @override
  Future<ListChatsDto> fetchAllChats(
      ServiceCall call, RequestDto request) async {
    final id = Utils.getIdFromMetadata(call);
    final listChats =
        await db.chats.queryChats(QueryParams(where: "author_id='$id'"));
    if (listChats.isEmpty) return ListChatsDto(chats: []);
    return Isolate.run(() => Utils.parseChats(listChats));
  }

  @override
  Future<ChatDto> fetchChat(ServiceCall call, ChatDto request) {
    // TODO: implement fetchChat
    throw UnimplementedError();
  }

  @override
  Stream<MessageDto> listenChat(ServiceCall call, ChatDto request) {
    // TODO: implement listenChat
    throw UnimplementedError();
  }

  @override
  Future<ResponseDto> sendMessage(ServiceCall call, MessageDto request) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
