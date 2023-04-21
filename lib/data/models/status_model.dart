class StatusModel{
  final String uId;
  final String username;
  final String phoneNumber;
  final List<String> photoUrl;
  final DateTime createdAt;
  final String profilePicture;
  final String statusId;
  final List<String> idOnAppUser;   // id user who can see our status, which mean already install app
  final String caption;

  const StatusModel({
    required this.uId,
    required this.username,
    required this.phoneNumber,
    required this.photoUrl,
    required this.createdAt,
    required this.profilePicture,
    required this.statusId,
    required this.idOnAppUser,
    required this.caption,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'profilePicture': profilePicture,
      'statusId': statusId,
      'idOnAppUser': idOnAppUser,
      'caption': caption,
    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      uId: map['uId'] ?? "",
      username: map['username'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      photoUrl: List<String>.from(map['photoUrl']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      profilePicture: map['profilePicture'] ?? '',
      statusId: map['statusId'] ?? '',
      idOnAppUser:  List<String>.from(map['idOnAppUser']),
      caption: map['caption'] ?? '',
    );
  }
}