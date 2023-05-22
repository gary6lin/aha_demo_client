class AppError implements Exception {
  final String? errorCode;
  final String errorMessage;

  AppError(this.errorMessage, [this.errorCode = 'app']);

  @override
  String toString() => '[${errorCode ?? 'unknown'}] $errorMessage';
}
