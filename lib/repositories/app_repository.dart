import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'dto/request/create_user_dto.dart';
import 'dto/request/update_user_dto.dart';
import 'dto/response/users_result_dto.dart';
import 'errors/user_not_found_error.dart';
import 'firebase_auth_exception_handler.dart';
import 'invalid_password_format_handler.dart';
import 'local/app_local_data_source.dart';
import 'remote/app_remote_data_source.dart';

abstract class AppRepository {
  factory AppRepository(AppLocalDataSource local, AppRemoteDataSource remote) => _AppRepositoryImp(local, remote);

  Future<User?> getCurrentUser();
  Future<void> reloadUser();

  Future<String?> getIdToken();
  Future<bool> accessAllowed();

  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> register(String email, String password, String displayName);
  Future<void> emailVerification(String oobCode);
  Future<void> updateProfile({
    String? displayName,
    String? currentPassword,
    String? newPassword,
  });
  Future<UsersResultDto> findUsers(int maxResults, String? pageToken);
}

class _AppRepositoryImp implements AppRepository {
  final AppLocalDataSource _local;
  final AppRemoteDataSource _remote;
  final _firebaseAuth = FirebaseAuth.instance;

  String? _token;

  _AppRepositoryImp(this._local, this._remote);

  @override
  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> reloadUser() async {
    await _firebaseAuth.currentUser?.reload();
  }

  @override
  Future<String?> getIdToken() async {
    if (_token == null) {
      final token = await _firebaseAuth.currentUser?.getIdToken();
      _token = token;
    }
    return _token;
  }

  @override
  Future<bool> accessAllowed() async {
    final idToken = await getIdToken();
    final emailVerified = _firebaseAuth.currentUser?.emailVerified;
    return idToken != null && emailVerified == true;
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> register(String email, String password, String displayName) async {
    try {
      // 1. Create users via the server API to enforce additional validation or business logic.
      await _remote.createUser(
        CreateUserDto(
          email: email,
          password: password,
          displayName: displayName,
        ),
      );

      // 2. User sign in to send email verification
      final userCred = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await userCred.user?.sendEmailVerification();
    } on DioError catch (e) {
      // Handle errors from server
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      InvalidPasswordFormatHandler.handle(e.message);
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
    }
  }

  @override
  Future<void> emailVerification(String oobCode) async {
    // 3. Verify the email via the generated verification link
    try {
      await _firebaseAuth.applyActionCode(oobCode);
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
    }
  }

  @override
  Future<void> updateProfile({
    String? displayName,
    String? currentPassword,
    String? newPassword,
  }) async {
    // 1. Get the current user
    final user = await getCurrentUser();
    if (user == null) throw UserNotFoundError();

    try {
      // 2. Update users via the server API to enforce additional validation or business logic.
      await _remote.updateUser(
        user.uid,
        UpdateUserDto(
          displayName: displayName,
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
    } on DioError catch (e) {
      // Handle errors from server
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      InvalidPasswordFormatHandler.handle(e.message);
    }
  }

  @override
  Future<UsersResultDto> findUsers(int maxResults, String? pageToken) async {
    try {
      return await _remote.findUsers(maxResults, pageToken);
    } on DioError catch (e) {
      // Handle errors from server
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      rethrow;
    }
  }
}
