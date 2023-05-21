class UsersResultDto {
  final List<UserRecord> users;
  final String? pageToken;

  UsersResultDto({
    required this.users,
    required this.pageToken,
  });

  UsersResultDto.fromJson(Map<String, dynamic> json)
      : users = List.from(json['users'])
            .map(
              (e) => UserRecord.fromJson(e),
            )
            .toList(),
        pageToken = json['pageToken'];

  Map<String, dynamic> toJson() => {
        'users': users,
        'pageToken': pageToken,
      };
}

class UserRecord {
  final String uid;
  final String? email;
  final bool emailVerified;
  final String? displayName;
  final String? photoURL;
  final String? passwordHash;
  final String? passwordSalt;
  final DateTime? tokensValidAfterTime;

  final DateTime creationTime;
  final DateTime? lastSignInTime;
  final DateTime? lastRefreshTime;

  UserRecord({
    required this.uid,
    required this.email,
    required this.emailVerified,
    this.displayName,
    this.photoURL,
    this.passwordHash,
    this.passwordSalt,
    this.tokensValidAfterTime,
    required this.creationTime,
    this.lastSignInTime,
    this.lastRefreshTime,
  });

  UserRecord.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        emailVerified = json['emailVerified'],
        displayName = json['displayName'],
        photoURL = json['photoURL'],
        passwordHash = json['passwordHash'],
        passwordSalt = json['passwordSalt'],
        tokensValidAfterTime = DateTime.tryParse(json['tokensValidAfterTime'] ?? ''),
        creationTime = DateTime.parse(json['creationTime']),
        lastSignInTime = DateTime.tryParse(json['lastSignInTime'] ?? ''),
        lastRefreshTime = DateTime.tryParse(json['lastRefreshTime'] ?? '');

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'emailVerified': emailVerified,
        'displayName': displayName,
        'photoURL': photoURL,
        'passwordHash': passwordHash,
        'passwordSalt': passwordSalt,
        'tokensValidAfterTime': tokensValidAfterTime?.toIso8601String(),
        'creationTime': creationTime.toIso8601String(),
        'lastSignInTime': lastSignInTime?.toIso8601String(),
        'lastRefreshTime': lastRefreshTime?.toIso8601String(),
      };
}
