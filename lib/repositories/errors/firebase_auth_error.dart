import 'app_error.dart';

class FirebaseAuthError extends AppError {
  FirebaseAuthError(String? e) : super(e ?? 'unknown');
}
