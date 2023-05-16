import 'package:aha_demo/routes/app_routes.dart';
import 'package:aha_demo/values/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_validator.dart';
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

  @override
  void initState() {
    super.initState();

    _vm.onSignedIn = () {
      context.go(AppRoute.main.path);
    };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: AppCard(
            radius: 16,
            child: buildLoginForm(),
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
          const LanguageSwitcher(),
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
          await _vm.onSignIn(
            'gary6lin@gmail.com',
            '12qw!@QW',
          );

          // await _vm.onSignIn(_emailController.text, _passwordController.text);
        },
      );

  Widget _buildRegisterButton() => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textLight.withOpacity(0.6),
        ),
        child: Text(
          tr('register'),
        ),
        onPressed: () {
          context.go(AppRoute.register.path);
        },
      );

  Widget _buildFacebookLoginButton() => FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.facebookBlue,
        ),
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          alignment: Alignment.center,
          child: Text(
            tr('continue_with_facebook'),
          ),
        ),
        onPressed: () {
          // TODO
        },
      );

  Widget _buildGoogleLoginButton() => FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.googleWhite,
        ),
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          alignment: Alignment.center,
          child: Text(
            tr('continue_with_google'),
            style: const TextStyle(color: AppColors.textDark),
          ),
        ),
        onPressed: () {
          // TODO
        },
      );
}
