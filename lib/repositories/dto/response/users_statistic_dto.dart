class UsersStatisticDto {
  final int totalUsers;
  final int activeUsers;
  final int averageActiveUsers;

  UsersStatisticDto({
    required this.totalUsers,
    required this.activeUsers,
    required this.averageActiveUsers,
  });

  UsersStatisticDto.fromJson(Map<String, dynamic> json)
      : totalUsers = json['totalUsers'],
        activeUsers = json['activeUsers'],
        averageActiveUsers = json['averageActiveUsers'];

  Map<String, dynamic> toJson() => {
        'totalUsers': totalUsers,
        'activeUsers': activeUsers,
        'averageActiveUsers': averageActiveUsers,
      };
}
