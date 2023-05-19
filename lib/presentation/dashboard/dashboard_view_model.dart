import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/app_repository.dart';
import '../../repositories/dto/response/users_result_dto.dart';
import '../../repositories/errors/app_error.dart';

class DashboardViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onUserRecordPages = ValueNotifier<List<List<UserRecord>>>([]);

  void Function()? onUpdatedDisplayName;
  void Function()? onChangedPassword;
  void Function()? onSignedOut;
  void Function(Object)? onError;

  String? pageToken;

  Future<void> loadDashboard() async {
    try {
      final usersResult = await _repo.findUsers(20, pageToken);
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
