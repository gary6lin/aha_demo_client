class UpdateUserInfoDto {
  final String? displayName;

  UpdateUserInfoDto({
    required this.displayName,
  });

  UpdateUserInfoDto.fromJson(Map<String, dynamic> json) : displayName = json['displayName'];

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
      };
}
