import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/auth_state.dart';
import 'dto/request/create_user_dto.dart';
import 'dto/request/update_user_info_dto.dart';
import 'dto/request/update_user_password_dto.dart';
import 'dto/response/users_result_dto.dart';
import 'dto/response/users_statistic_dto.dart';
import 'errors/user_not_found_error.dart';
import 'errors/user_not_signed_in_error.dart';
import 'firebase_auth_exception_handler.dart';
import 'invalid_password_format_handler.dart';
import 'local/app_local_data_source.dart';
import 'remote/app_remote_data_source.dart';

abstract class AppRepository {
  factory AppRepository(AppLocalDataSource local, AppRemoteDataSource remote) => _AppRepositoryImp(local, remote);

  Future<User?> getCurrentUser();
  Future<void> reloadUser();

  Future<String?> getIdToken();
  Future<AuthState> getAuthState();

  Future<void> signIn(String email, String password);
  Future<void> signInWithFacebook();
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Future<void> register(String email, String password, String displayName);
  Future<void> sendEmailVerification();
  Future<void> verifyEmail(String oobCode);
  Future<void> updateUserInfo({String? displayName});
  Future<void> updateUserPassword({String? currentPassword, String? newPassword});
  Future<UsersResultDto> findUsers(int pageSize, String? pageToken);
  Future<UsersStatisticDto> findUsersStatistic();
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
  Future<AuthState> getAuthState() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return AuthState.noAuth;
    }
    final emailVerified = currentUser.emailVerified;
    if (emailVerified) {
      return AuthState.emailVerified;
    }
    return AuthState.emailNotVerified;
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      // Traditional user sign in
      final userCred = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      // Updates the user copy on our server
      await _updateUserCopy(userCred.user);
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      rethrow;
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final userCred = await _firebaseAuth.signInWithCredential(facebookAuthCredential);

      // Updates the user copy on our server
      await _updateUserCopy(userCred.user);
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'profile',
        ],
      );
      final googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCred = await _firebaseAuth.signInWithCredential(credential);

      // Updates the user copy on our server
      await _updateUserCopy(userCred.user);
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      rethrow;
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
      if (kDebugMode) print(e.toString());
      FirebaseAuthExceptionHandler.handle(e.response?.data.toString());
      InvalidPasswordFormatHandler.handle(e.response?.data.toString());
      rethrow;
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      rethrow;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = await getCurrentUser();
    if (user == null) {
      throw UserNotSignedInError();
    }
    await user.sendEmailVerification();
  }

  @override
  Future<void> verifyEmail(String oobCode) async {
    // 3. Verify the email via the generated verification link
    try {
      await _firebaseAuth.applyActionCode(oobCode);
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase
      if (kDebugMode) print(e.message);
      FirebaseAuthExceptionHandler.handle(e.message);
      rethrow;
    }
  }

  @override
  Future<void> updateUserInfo({
    String? displayName,
  }) async {
    // 1. Get the current user
    final user = await getCurrentUser();
    if (user == null) throw UserNotFoundError();

    try {
      // 2. Update users via the server API to enforce additional validation or business logic.
      await _remote.updateUserInfo(
        user.uid,
        UpdateUserInfoDto(
          displayName: displayName,
        ),
      );
    } on DioError catch (e) {
      // Handle errors from server
      if (kDebugMode) print(e.toString());
      FirebaseAuthExceptionHandler.handle(e.response?.data.toString());
      InvalidPasswordFormatHandler.handle(e.response?.data.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateUserPassword({
    String? currentPassword,
    String? newPassword,
  }) async {
    // 1. Get the current user
    final user = await getCurrentUser();
    if (user == null) throw UserNotFoundError();

    try {
      // 2. Update users via the server API to enforce additional validation or business logic.
      await _remote.updateUserPassword(
        user.uid,
        UpdateUserPasswordDto(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
    } on DioError catch (e) {
      // Handle errors from server
      if (kDebugMode) print(e.toString());
      FirebaseAuthExceptionHandler.handle(e.response?.data.toString());
      InvalidPasswordFormatHandler.handle(e.response?.data.toString());
      rethrow;
    }
  }

  @override
  Future<UsersResultDto> findUsers(int pageSize, String? pageToken) async {
    try {
      return await _remote.findUsers(pageSize, pageToken);
    } on DioError catch (e) {
      // Handle errors from server
      if (kDebugMode) print(e.toString());
      FirebaseAuthExceptionHandler.handle(e.response?.data.toString());
      rethrow;
    }
  }

  @override
  Future<UsersStatisticDto> findUsersStatistic() async {
    try {
      return await _remote.findUsersStatistic();
    } on DioError catch (e) {
      // Handle errors from server
      if (kDebugMode) print(e.toString());
      FirebaseAuthExceptionHandler.handle(e.response?.data.toString());
      rethrow;
    }
  }

  Future<void> _updateUserCopy(User? user) async {
    if (user == null) {
      throw UserNotFoundError();
    }
    await _remote.updateUser(user.uid);
  }
}
