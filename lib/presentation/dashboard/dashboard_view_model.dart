import 'package:aha_demo/repositories/dto/response/users_statistic_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/app_repository.dart';
import '../../repositories/dto/response/users_result_dto.dart';
import '../../repositories/errors/app_error.dart';

class DashboardViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onUsersStatistics = ValueNotifier<UsersStatisticDto?>(null);
  final onUserRecordPages = ValueNotifier<List<List<UserRecord>>>([]);

  void Function()? onUpdatedDisplayName;
  void Function()? onChangedPassword;
  void Function()? onSignedOut;
  void Function(Object)? onError;

  String? pageToken;

  void loadUserList() async {
    try {
      _repo.findUsers(20, pageToken).then(
        (usersResult) {
          onUserRecordPages.value = List.of(
            onUserRecordPages.value..add(usersResult.users),
          );
          pageToken = usersResult.pageToken;
        },
      );
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }

  void loadUsersStatistic() {
    try {
      _repo.findUsersStatistic().then(
            (usersStatistic) => onUsersStatistics.value = usersStatistic,
          );
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }
}
