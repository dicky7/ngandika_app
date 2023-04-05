class ChatContactModel{
  final String name;
  final String profilePicture;
  final String contactId;
  final String lastMessage;
  final DateTime timeSent;

  const ChatContactModel({
    required this.name,
    required this.profilePicture,
    required this.contactId,
    required this.lastMessage,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePicture': profilePicture,
      'contactId': contactId,
      'lastMessage': lastMessage,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory ChatContactModel.fromMap(Map<String, dynamic> map) {
    return ChatContactModel(
      name: map['name'] as String,
      profilePicture: map['profilePicture'] as String,
      contactId: map['contactId'] as String,
      lastMessage: map['lastMessage'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}