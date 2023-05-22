import 'package:aha_demo/repositories/dto/response/users_statistic_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/app_repository.dart';
import '../../repositories/dto/response/users_result_dto.dart';
import '../../repositories/errors/app_error.dart';
import '../../values/constants.dart';

class DashboardViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onUsersStatistics = ValueNotifier<UsersStatisticDto?>(null);
  final onUserRecordPages = ValueNotifier<List<List<UserRecord>>>([]);

  int currentPage = 0;
  bool get isFirstPage => currentPage == 0;
  int get totalPages => onUserRecordPages.value.length;

  void Function()? onUpdatedDisplayName;
  void Function()? onChangedPassword;
  void Function()? onSignedOut;
  void Function(Object)? onError;

  String? pageToken;

  void loadUserList() async {
    _repo.findUsers(pageSize, null).then(
      (usersResult) {
        onUserRecordPages.value = [usersResult.users];
        pageToken = usersResult.pageToken;
      },
    ).onError(
      (error, stackTrace) {
        if (kDebugMode) print(error);
        if (error is AppError) {
          onError?.call(error.errorMessage);
        } else {
          onError?.call('$error');
        }
      },
    );
  }

  void loadUsersStatistic() {
    _repo.findUsersStatistic().then(
      (usersStatistic) {
        onUsersStatistics.value = usersStatistic;
      },
    ).onError(
      (error, stackTrace) {
        if (kDebugMode) print(error);
        if (error is AppError) {
          onError?.call(error.errorMessage);
        } else {
          onError?.call('$error');
        }
      },
    );
  }

  Future<void> loadPreviousPage() async {
    if (isFirstPage) return;
    currentPage -= 1;
    onUserRecordPages.value = List.of(onUserRecordPages.value);
  }

  Future<void> loadMoreUserList() async {
    if (currentPage < totalPages - 1) {
      currentPage += 1;
      onUserRecordPages.value = List.of(onUserRecordPages.value);
      return;
    }

    try {
      final usersResult = await _repo.findUsers(pageSize, pageToken);
      if (usersResult.users.isEmpty) return;
      currentPage += 1;
      onUserRecordPages.value = List.of(
        onUserRecordPages.value..add(usersResult.users),
      );
      pageToken = usersResult.pageToken;
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }
}
