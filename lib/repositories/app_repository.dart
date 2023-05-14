import 'local/app_local_data_source.dart';
import 'remote/app_remote_data_source.dart';

abstract class AppRepository {
  factory AppRepository(AppLocalDataSource local, AppRemoteDataSource remote) => _AppRepositoryImp(local, remote);

  Future<String?> getAccessToken();
  Future<void> setAccessToken(String token);
}

class _AppRepositoryImp implements AppRepository {
  final AppLocalDataSource _local;
  final AppRemoteDataSource _remote;

  _AppRepositoryImp(this._local, this._remote);

  @override
  Future<String?> getAccessToken() async {
    return await _local.readAccessToken();
  }

  @override
  Future<void> setAccessToken(String token) async {
    return await _local.writeAccessToken(token);
  }
}
