import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:ngandika_app/data/models/group_model.dart';
import 'package:ngandika_app/data/repository/message_groups_repository.dart';


part 'message_groups_state.dart';

class MessageGroupsCubit extends Cubit<MessageGroupsState> {
  final MessageRepository repository;

  MessageGroupsCubit(this.repository) : super(GroupsInitial());

  List<String> selectedContactUId = [];

  Future<void> selectContact(String uIdContact) async {
    selectedContactUId.add(uIdContact);
    print("selectedContactUId $selectedContactUId");
    emit(SelectContactSuccess());
  }

  Future<void> createGroup(String name, File profilePicture, List<String> selectedUidContact) async{
    final result = await repository.createGroup(name, profilePicture, selectedUidContact);
    result.fold(
      (l) => emit(CreateGroupsError(l.message)),
      (r){
        selectedContactUId = [];
        emit(CreateGroupsSuccess());
      },
    );
  }

  Stream<List<GroupModel>> getChatGroups() {
    return repository.getChatGroups();
  }

  Stream<int> getNumOfMessageNotSeen(String senderId) =>
      repository.getNumOfMessageNotSeen(senderId);
}
