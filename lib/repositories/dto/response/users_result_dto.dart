class UsersResultDto {
  final UserRecord users;
  final String pageToken;

  UsersResultDto({
    required this.users,
    required this.pageToken,
  });

  UsersResultDto.fromJson(Map<String, dynamic> json)
      : users = json['users'],
        pageToken = json['pageToken'];

  Map<String, dynamic> toJson() => {
        'users': users,
        'pageToken': pageToken,
      };
}

class UserRecord {
  final String email;
  final String photoURL;
  final String displayName;
  final UserMetadata metadata;

  UserRecord({
    required this.email,
    required this.photoURL,
    required this.displayName,
    required this.metadata,
  });

  UserRecord.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        photoURL = json['photoURL'],
        displayName = json['displayName'],
        metadata = json['metadata'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'photoURL': photoURL,
        'displayName': displayName,
        'metadata': metadata,
      };
}

class UserMetadata {
  final String creationTime;
  final String lastSignInTime;
  final String lastRefreshTime;

  UserMetadata({
    required this.creationTime,
    required this.lastSignInTime,
    required this.lastRefreshTime,
  });

  UserMetadata.fromJson(Map<String, dynamic> json)
      : creationTime = json['creationTime'],
        lastSignInTime = json['lastSignInTime'],
        lastRefreshTime = json['lastRefreshTime'];

  Map<String, dynamic> toJson() => {
        'creationTime': creationTime,
        'lastSignInTime': lastSignInTime,
        'lastRefreshTime': lastRefreshTime,
      };
}
