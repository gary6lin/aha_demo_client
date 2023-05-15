import 'package:firebase_auth/firebase_auth.dart';

import 'dto/register_dto.dart';
import 'errors/email_verification_error.dart';
import 'local/app_local_data_source.dart';
import 'remote/app_remote_data_source.dart';

abstract class AppRepository {
  factory AppRepository(AppLocalDataSource local, AppRemoteDataSource remote) => _AppRepositoryImp(local, remote);

  Future<String?> getAccessToken();

  Future<void> signIn(String email, String password);
  Future<void> register(String email, String password, String displayName);
  Future<void> emailVerification(String oobCode);
}

class _AppRepositoryImp implements AppRepository {
  final AppLocalDataSource _local;
  final AppRemoteDataSource _remote;
  final _firebaseAuth = FirebaseAuth.instance;

  _AppRepositoryImp(this._local, this._remote);

  @override
  Future<String?> getAccessToken() async {
    return await _local.readAccessToken();
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

    if (accessToken != null) {
      await _local.writeAccessToken(accessToken);
    }

    return accessToken;
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
    } on FirebaseAuthException catch (e) {
      final error = EmailVerificationErrorHandler.handle(e.message);
      throw error.message;
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
      final error = EmailVerificationErrorHandler.handle(e.message);
      throw error.message;
    }
  }
}
