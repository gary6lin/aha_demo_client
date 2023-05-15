const defaultPadding = 16.0;

class AppRegex {
  AppRegex._();

  static final emailValidation = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');

  static final pwdLowerChar = RegExp(r'^(?=.*[a-z]).*$');
  static final pwdUpperChar = RegExp(r'^(?=.*[A-Z]).*$');
  static final pwdNumberChar = RegExp(r'^(?=.*\d).*$');
  static final pwdSpecialChar = RegExp(r'^(?=.*[^a-zA-Z0-9\d\s]).*$');
  static final pwdLength = RegExp(r'^.{8,}$');
  static final pwdNoWhitespace = RegExp(r'^\S*$');
}
