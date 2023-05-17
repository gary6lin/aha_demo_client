import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../utils/app_validator.dart';
import '../widgets/app_card.dart';
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
          Text(
            tr('create_new_account'),
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: tr('display_name'),
            ),
            validator: AppValidator.name,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: tr('email_address'),
            ),
            validator: AppValidator.email,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: tr('password'),
            ),
            validator: AppValidator.password,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          _buildSubmitButton(),
          ValueListenableBuilder(
            valueListenable: _vm.onLoading,
            builder: (BuildContext context, bool loading, Widget? child) => IgnorePointer(
              ignoring: loading,
              child: const LanguageSwitcher(),
            ),
          ),
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

          // await _vm.onRegister(
          //   _emailController.text,
          //   _passwordController.text,
          //   _nameController.text,
          // );
        },
      );
}
