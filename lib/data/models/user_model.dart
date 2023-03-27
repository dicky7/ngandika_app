class UserModel {
  final String name;
  final String uId;
  final String profilePicture;
  final bool isOnline;
  final String status;
  final String phoneNumber;
  final DateTime lastSeen;
  final List<String> groupId;

  const UserModel({
    required this.name,
    required this.uId,
    required this.profilePicture,
    required this.isOnline,
    required this.status,
    required this.lastSeen,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'profilePicture': profilePicture,
      'isOnline': isOnline,
      'status': status,
      'phoneNumber': phoneNumber,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uId: map['uId'] as String,
      profilePicture: map['profilePicture'] as String,
      isOnline: map['isOnline'] as bool,
      status: map['status'] as String,
      phoneNumber: map['phoneNumber'] as String,
      groupId: List<String>.from(map['groupId']),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen']),
    );
  }
}
