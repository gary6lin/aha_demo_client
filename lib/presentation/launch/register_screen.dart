import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../values/app_colors.dart';
import '../widgets/app_filled_button.dart';
import '../widgets/language_switcher.dart';
import 'register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _vm = RegisterViewModel();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _vm.onRegistered = () {
      context.go(
        AppRoute.verification.path,
        extra: tr('email_verification_sent'),
      );
    };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: buildLoginForm(),
          ),
        ),
      );

  Widget buildLoginForm() => Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 24,
        children: [
          Text(
            tr('create_new_account'),
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: tr('display_name'),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: tr('email_address'),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: tr('password'),
            ),
          ),
          _buildSubmitButton(),
          const LanguageSwitcher(),
        ],
      );

  Widget _buildSubmitButton() => AppFilledButton(
        child: Text(
          tr('register_submission'),
        ),
        onPressed: () async {
          // TODO
          await _vm.onRegister(
            'gary6lin@gmail.com',
            '12qw!@QW',
            'GGG',
          );
        },
      );
}
