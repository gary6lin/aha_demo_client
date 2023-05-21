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
  final String? email;
  final bool emailVerified;
  final String? displayName;
  final String? photoURL;
  final String? passwordHash;
  final String? passwordSalt;
  final DateTime? tokensValidAfterTime;

  final DateTime creationTime;
  final DateTime lastSignInTime;
  final DateTime? lastRefreshTime;

  UserRecord({
    required this.email,
    required this.emailVerified,
    required this.displayName,
    required this.photoURL,
    required this.passwordHash,
    required this.passwordSalt,
    required this.tokensValidAfterTime,
    required this.creationTime,
    required this.lastSignInTime,
    required this.lastRefreshTime,
  });

  UserRecord.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        emailVerified = json['emailVerified'],
        displayName = json['displayName'],
        photoURL = json['photoURL'],
        passwordHash = json['passwordHash'],
        passwordSalt = json['passwordSalt'],
        tokensValidAfterTime = DateTime.tryParse(json['tokensValidAfterTime']),
        creationTime = DateTime.parse(json['creationTime']),
        lastSignInTime = DateTime.parse(json['lastSignInTime']),
        lastRefreshTime = DateTime.tryParse(json['lastRefreshTime']);

  Map<String, dynamic> toJson() => {
        'email': email,
        'emailVerified': emailVerified,
        'displayName': displayName,
        'photoURL': photoURL,
        'passwordHash': passwordHash,
        'passwordSalt': passwordSalt,
        'tokensValidAfterTime': tokensValidAfterTime?.toIso8601String(),
        'creationTime': creationTime.toIso8601String(),
        'lastSignInTime': lastSignInTime.toIso8601String(),
        'lastRefreshTime': lastRefreshTime?.toIso8601String(),
      };
}
