import 'package:aha_demo/routes/app_routes.dart';
import 'package:aha_demo/values/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_locale.dart';
import '../../values/constants.dart';
import '../widgets/language_switcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            decoration: ShapeDecoration(
              color: AppColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
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
          const LanguageSwitcher(
            languages: SupportedLocale.values,
          ),
        ],
      );

  Widget _buildEmailInput() => TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: tr('email_address'),
        ),
        validator: (value) {
          final validated = AppRegex.emailValidation.hasMatch(value ?? '');
          return validated ? null : tr('invalid_email_address');
        },
      );

  Widget _buildPasswordInput() => TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
          labelText: tr('password'),
        ),
      );

  Widget _buildEmailLoginButton() => FilledButton(
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          alignment: Alignment.center,
          child: Text(
            tr('login'),
          ),
        ),
        onPressed: () {
          // TODO
          context.go(AppRoute.main.path);
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
          context.go(AppRoute.login.register.path);
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
