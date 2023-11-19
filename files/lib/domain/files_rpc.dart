// import 'dart:async';
// import 'dart:isolate';

// import 'package:chats/data/chat/chat.dart';
// import 'package:chats/data/db.dart';
// import 'package:chats/data/message/message.dart';
// import 'package:chats/generated/chats.pbgrpc.dart';
// import 'package:chats/utils.dart';
// import 'package:grpc/grpc.dart';
// import 'package:protobuf/protobuf.dart';
// import 'package:stormberry/stormberry.dart';

// class ChatRpc extends ChatsRpcServiceBase {
//   final StreamController<MessageDto> _streamController =
//       StreamController.broadcast();
//   @override
//   Future<ResponseDto> createChat(ServiceCall call, ChatDto request) async {
//     final id = Utils.getIdFromMetadata(call);
//     if (request.name.isEmpty) {
//       throw GrpcError.invalidArgument("Chat name not found");
//     }
//     if (request.memberId.isEmpty) {
//       throw GrpcError.invalidArgument("Member id not found");
//     }
//     await db.chats.insertOne(
//       ChatInsertRequest(
//           name: request.name,
//           authorId: id.toString(),
//           memberId: request.memberId),
//     );
//     return ResponseDto(message: "success");
//   }

//   @override
//   Future<ResponseDto> deleteChat(ServiceCall call, ChatDto request) async {
//     final authorId = Utils.getIdFromMetadata(call);
//     final chatId = int.tryParse(request.id);
//     if (chatId == null) throw GrpcError.invalidArgument("Chat id not found");
//     final chat = await db.chats.queryShortView(chatId);
//     if (chat == null) throw GrpcError.notFound("Chat not found");
//     if (chat.authorId == authorId.toString()) {
//       await db.chats.deleteOne(chatId);
//       return ResponseDto(message: "success");
//     } else {
//       throw GrpcError.permissionDenied();
//     }
//   }

//   @override
//   Future<ResponseDto> deletemesage(ServiceCall call, MessageDto request) async {
//     final messageId = int.tryParse(request.id);
//     if (messageId == null) {
//       throw GrpcError.invalidArgument("Message id not found");
//     }
//     final message = await db.messages.queryMessage(messageId);
//     if (message == null) throw GrpcError.invalidArgument("Message not found");
//     final userId = Utils.getIdFromMetadata(call);
//     if (message.authorId == userId.toString()) {
//       await db.messages.deleteOne(messageId);
//       return ResponseDto(message: "success");
//     } else {
//       throw GrpcError.permissionDenied();
//     }
//   }

//   @override
//   Future<ListChatsDto> fetchAllChats(
//       ServiceCall call, RequestDto request) async {
//     final id = Utils.getIdFromMetadata(call);
//     final listChats = await db.chats.queryShortViews(
//         QueryParams(where: "author_id='$id' OR member_id='$id'"));
//     if (listChats.isEmpty) return ListChatsDto(chats: []);
//     return Isolate.run(() => Utils.parseChats(listChats));
//   }

//   @override
//   Future<ChatDto> fetchChat(ServiceCall call, ChatDto request) async {
//     final chatId = int.tryParse(request.id);
//     if (chatId == null) throw GrpcError.invalidArgument("Chat id not found");
//     final chat = await db.chats.queryFullView(chatId);
//     if (chat == null) throw GrpcError.invalidArgument("Chat not found");
//     final userId = Utils.getIdFromMetadata(call);
//     if (chat.authorId == userId.toString() ||
//         chat.memberId == userId.toString()) {
//       return await Isolate.run(() => Utils.parseChat(chat));
//     } else {
//       throw GrpcError.permissionDenied();
//     }
//   }

//   @override
//   Stream<MessageDto> listenChat(ServiceCall call, ChatDto request) async* {
//     if (request.id.isEmpty) {
//       throw GrpcError.invalidArgument("Chat id not found");
//     }
//     yield* _streamController.stream
//         .where((event) => event.chatId == request.id);
//   }

//   @override
//   Future<ResponseDto> sendMessage(ServiceCall call, MessageDto request) async {
//     final authorId = Utils.getIdFromMetadata(call);
//     final chatId = int.tryParse(request.chatId);
//     if (chatId == null) throw GrpcError.invalidArgument("Chat id not found");
//     if (request.body.isEmpty) throw GrpcError.invalidArgument("Body is empty");
//     final id = await db.messages.insertOne(MessageInsertRequest(
//       body: request.body,
//       authorId: authorId.toString(),
//       chatId: chatId,
//     ));
//     _streamController.add(request.deepCopy()
//       ..id = id.toString()
//       ..authorId = authorId.toString());
//     return ResponseDto(message: "success");
//   }
// }
