import 'package:dartz/dartz.dart';
import 'package:ngandika_app/utils/error/exception.dart';

import '../../utils/error/failure.dart';
import '../datasource/chat/chat_remote_data_source.dart';
import '../models/message_model.dart';

abstract class ChatRepository{
  Future<Either<Failure, void>> sendTextMessage({required String text, required String receiverId});
  Stream<List<MessageModel>> getChatStream(String receiverId);
}
class ChatRepositoryImpl extends ChatRepository{
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> sendTextMessage({required String text, required String receiverId}) async {
    try{
      final result = await remoteDataSource.sendTextMessage(text: text, receiverId: receiverId);
      return right(result);
    } on ServerException catch(e){
      return left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Stream<List<MessageModel>> getChatStream(String receiverId) {
    return remoteDataSource.getChatStream(receiverId);
  }

}