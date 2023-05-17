import 'package:aha_demo/routes/app_routes.dart';
import 'package:aha_demo/values/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_validator.dart';
import '../../utils/show_alert.dart';
import '../../values/app_text_style.dart';
import '../widgets/app_card.dart';
import '../widgets/app_filled_button.dart';
import '../widgets/language_switcher.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _vm = LoginViewModel();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _vm.onSignedIn = () {
      context.go(AppRoute.main.path);
    };

    _vm.onError = (e) {
      showAlert(
        context: context,
        title: e.toString(),
      );
    };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: AppCard(
            radius: 16,
            child: Form(
              key: _formKey,
              child: buildLoginForm(),
            ),
          ),
        ),
      );

  Widget buildLoginForm() => Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 24,
        children: [
          _buildEmailInput(),
          _buildPasswordInput(),
          _buildEmailLoginButton(),
          _buildRegisterButton(),
          const Divider(),
          _buildFacebookLoginButton(),
          _buildGoogleLoginButton(),
          ValueListenableBuilder(
            valueListenable: _vm.onLoading,
            builder: (BuildContext context, bool loading, Widget? child) => IgnorePointer(
              ignoring: loading,
              child: const LanguageSwitcher(),
            ),
          ),
        ],
      );

  Widget _buildEmailInput() => TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: tr('email_address'),
        ),
        validator: AppValidator.email,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  Widget _buildPasswordInput() => TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: tr('password'),
        ),
        validator: AppValidator.password,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  Widget _buildEmailLoginButton() => AppFilledButton(
        child: Text(
          tr('login'),
        ),
        onPressed: () async {
          // TODO
          // await _vm.onSignIn(
          //   'gary6lin@gmail.com',
          //   '12qw!@QW',
          // );

          final emailError = AppValidator.email(_emailController.text);
          final passwordError = AppValidator.password(_passwordController.text);

          // Submit only if there is no error
          if (emailError == null && passwordError == null) {
            await _vm.signIn(_emailController.text, _passwordController.text);
          }

          // Validates to show errors if any
          _formKey.currentState?.validate();
        },
      );

  Widget _buildRegisterButton() => TextButton(
        style: TextButton.styleFrom(
          textStyle: AppTextStyle.bodyRegular,
          foregroundColor: AppColors.textLight.withOpacity(0.6),
        ),
        child: Text(
          tr('register'),
        ),
        onPressed: () {
          context.go(AppRoute.register.path);
        },
      );

  Widget _buildFacebookLoginButton() => AppFilledButton(
        color: AppColors.facebookBlue,
        child: Text(
          tr('continue_with_facebook'),
        ),
        onPressed: () async {
          // TODO
        },
      );

  Widget _buildGoogleLoginButton() => AppFilledButton(
        color: AppColors.googleWhite,
        child: Text(
          tr('continue_with_google'),
          style: const TextStyle(color: AppColors.textDark),
        ),
        onPressed: () async {
          // TODO
        },
      );
}
