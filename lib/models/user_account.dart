part of 'models.dart';

class UserAccount {
  UserAccount({
    required this.uid,
    required this.username,
    required this.email,
    this.password,
    this.photoUrl,
  });

  String uid;
  String username;
  String email;
  String? password;
  String? photoUrl;

  factory UserAccount.fromMap(Map<String, dynamic> map) => UserAccount(
        uid: map[columnUserAccountUid],
        username: map[columnUserAccountUsername],
        email: map[columnUserAccountEmail],
        photoUrl: map[columnUserAccountPhotoUrl],
      );

  Map<String, dynamic> toMap() => {
        columnUserAccountUid: uid,
        columnUserAccountUsername: username,
        columnUserAccountEmail: email,
        columnUserAccountPhotoUrl: photoUrl,
      };

  Map<String, dynamic> toFirestoreMap() => toMap()
    ..removeWhere(
      (key, value) => {
        columnUserAccountUid,
        columnUserAccountPhotoUrl,
      }.contains(key),
    );

  UserAccount copyWith({
    String? uid,
    String? username,
    String? email,
    String? photoUrl,
  }) =>
      UserAccount(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
      );
}
