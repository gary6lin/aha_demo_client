const defaultPadding = 16.0;

class AppRegex {
  AppRegex._();

  static final emailValidation = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
}
