class RegisterDto {
  final String email;
  final String password;
  final String displayName;

  RegisterDto({
    required this.email,
    required this.password,
    required this.displayName,
  });

  RegisterDto.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        displayName = json['displayName'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'displayName': displayName,
      };
}
