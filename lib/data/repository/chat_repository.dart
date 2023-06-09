import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngandika_app/utils/error/exception.dart';

import '../../utils/enums/message_type.dart';
import '../../utils/error/failure.dart';
import '../datasource/chat/chat_remote_data_source.dart';
import '../models/message_model.dart';
import '../models/message_reply_model.dart';

abstract class ChatRepository {
  Stream<List<MessageModel>> getChatStream(String receiverId);

  Stream<List<MessageModel>> getGroupChatStream(String groupId);

  Future<Either<Failure, void>> sendTextMessage({
    required String text,
    required String receiverId,
    required MessageReplyModel? messageReply,
    required bool isGroupChat});

  Future<Either<Failure, void>> sendGIFMessage({
    required String gifUrl,
    required String receiverId,
    required MessageReplyModel? messageReply,
    required bool isGroupChat});

  Future<Either<Failure, void>> sendFileMessage({
    required File file,
    required String receiverId,
    required MessageType messageType,
    required MessageReplyModel? messageReply,
    required bool isGroupChat});

  Future<Either<Failure,void>> setMessageSeen(String receiverId, String messageId);
}

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<MessageModel>> getChatStream(String receiverId) {
    return remoteDataSource.getChatStream(receiverId);
  }

  @override
  Stream<List<MessageModel>> getGroupChatStream(String groupId) {
    return remoteDataSource.getGroupChatStream(groupId);
  }

  @override
  Future<Either<Failure, void>> sendTextMessage({
    required String text,
    required String receiverId,
    required MessageReplyModel? messageReply,
    required bool isGroupChat
  }) async {
    try {
      final result = await remoteDataSource.sendTextMessage(text: text, receiverId: receiverId, messageReply: messageReply, isGroupChat: isGroupChat);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendFileMessage({
    required File file,
    required String receiverId,
    required MessageType messageType,
    required MessageReplyModel? messageReply,
    required bool isGroupChat
  }) async {
    try {
      final result = await remoteDataSource.sendFileMessage(
          file: file, receiverId: receiverId, messageType: messageType, messageReply: messageReply, isGroupChat: isGroupChat);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendGIFMessage({
    required String gifUrl,
    required String receiverId,
    required MessageReplyModel? messageReply,
    required bool isGroupChat
  }) async {
    try {
      final result = await remoteDataSource.sendGIFMessage(
          gifUrl: gifUrl, receiverId: receiverId, messageReply: messageReply, isGroupChat: isGroupChat);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setMessageSeen(String receiverId, String messageId) async{
    try{
      final result = await remoteDataSource.setMessageSeen(receiverId, messageId);
      return right(result);
    }on ServerException catch(e){
      return left(ServerFailure(e.message));
    }
  }
}
