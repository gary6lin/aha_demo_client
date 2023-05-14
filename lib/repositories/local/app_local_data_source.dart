import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AppLocalDataSource {
  factory AppLocalDataSource() = _AppLocalDataSourceImp;

  Future<String?> readAccessToken();
  Future<void> writeAccessToken(String token);
}

class _AppLocalDataSourceImp implements AppLocalDataSource {
  final _storage = const FlutterSecureStorage();

  @override
  Future<String?> readAccessToken() async {
    return await _storage.read(key: 'token');
  }

  @override
  Future<void> writeAccessToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }
}
