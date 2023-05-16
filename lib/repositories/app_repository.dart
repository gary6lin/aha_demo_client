import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'dto/register_dto.dart';
import 'firebase_auth_exception_handler.dart';
import 'invalid_password_format_handler.dart';
import 'local/app_local_data_source.dart';
import 'remote/app_remote_data_source.dart';

abstract class AppRepository {
  factory AppRepository(AppLocalDataSource local, AppRemoteDataSource remote) => _AppRepositoryImp(local, remote);

  Future<bool?> accessAllowed();
  Future<String?> getAccessToken();

  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> register(String email, String password, String displayName);
  Future<void> emailVerification(String oobCode);
}

class _AppRepositoryImp implements AppRepository {
  final AppLocalDataSource _local;
  final AppRemoteDataSource _remote;
  final _firebaseAuth = FirebaseAuth.instance;

  String? _token;

  _AppRepositoryImp(this._local, this._remote);

  @override
  Future<bool?> accessAllowed() async {
    final accessToken = await getAccessToken();
    final emailVerified = _firebaseAuth.currentUser?.emailVerified;
    print('accessToken: $accessToken');
    print('emailVerified: $emailVerified');
    return accessToken != null && emailVerified == true;
  }

  @override
  Future<String?> getAccessToken() async {
    if (_token == null) {
      final token = await _firebaseAuth.currentUser?.getIdToken();
      _token = token;
    }
    return _token;

    // Deprecated
    // return await _local.readAccessToken();
  }

  @override
  Future<String?> signIn(String email, String password) async {
    final userCred = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    final accessToken = userCred.credential?.accessToken;
    print('accessToken: $accessToken');

    final token = userCred.credential?.token;
    print('token: $token');

    final idToken = await userCred.user?.getIdToken();
    print('idToken: $idToken');

    // Deprecated
    // if (accessToken != null) {
    //   await _local.writeAccessToken(accessToken);
    // }

    return accessToken;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> register(String email, String password, String displayName) async {
    // 1. Creating users on the server using the Firebase Admin SDK,
    // to enforce additional validation or business logic.
    try {
      await _remote.createUser(
        RegisterDto(
          email: email,
          password: password,
          displayName: displayName,
        ),
      );
    } on DioError catch (e) {
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      InvalidPasswordFormatHandler.handle(e.message);
    }

    // 2. User sign in to send email verification
    final userCred = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    await userCred.user?.sendEmailVerification();
  }

  @override
  Future<void> emailVerification(String oobCode) async {
    // 3. Verify the email via the generated verification link
    try {
      await _firebaseAuth.applyActionCode(oobCode);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
    }
  }
}
