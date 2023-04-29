class GroupModel{
  final String senderId;
  final String name;
  final String groupId;
  final String lastMessage;
  final String groupProfilePic;
  final List<String> membersUid;

  const GroupModel({
    required this.senderId,
    required this.name,
    required this.groupId,
    required this.lastMessage,
    required this.groupProfilePic,
    required this.membersUid,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'name': name,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'groupProfilePic': groupProfilePic,
      'membersUid': membersUid,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      senderId: map['senderId'] as String,
      name: map['name'] as String,
      groupId: map['groupId'] as String,
      lastMessage: map['lastMessage'] as String,
      groupProfilePic: map['groupProfilePic'] as String,
      membersUid: List<String>.from(map['membersUid']),
    );
  }
}