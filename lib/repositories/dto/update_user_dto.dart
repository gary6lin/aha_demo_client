class UpdateUserDto {
  final String? displayName;
  final String? currentPassword;
  final String? newPassword;

  UpdateUserDto({
    required this.displayName,
    required this.currentPassword,
    required this.newPassword,
  });

  UpdateUserDto.fromJson(Map<String, dynamic> json)
      : displayName = json['displayName'],
        currentPassword = json['currentPassword'],
        newPassword = json['newPassword'];

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      };
}
