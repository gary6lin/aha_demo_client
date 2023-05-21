class UpdateUserPasswordDto {
  final String? currentPassword;
  final String newPassword;

  UpdateUserPasswordDto({
    this.currentPassword,
    required this.newPassword,
  });

  UpdateUserPasswordDto.fromJson(Map<String, dynamic> json)
      : currentPassword = json['currentPassword'],
        newPassword = json['newPassword'];

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      };
}
