import 'package:aha_demo/utils/show_alert.dart';
import 'package:aha_demo/values/app_text_style.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _vm.onRegistered = () {
      context.go(AppRoute.verification.path);
    };

    _vm.onError = (e) {
      showAlert(
        context: context,
        title: e.errorMessage,
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
          Text(
            tr('create_new_account'),
            style: AppTextStyle.titleRegular,
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
            keyboardType: TextInputType.emailAddress,
            validator: AppValidator.email,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: tr('password'),
            ),
            obscureText: true,
            validator: AppValidator.password,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
          final emailError = AppValidator.email(_emailController.text);
          final passwordError = AppValidator.password(_passwordController.text);
          final nameError = AppValidator.name(_nameController.text);

          // Submit only if there is no error
          if (emailError == null && passwordError == null && nameError == null) {
            await _vm.register(
              _emailController.text,
              _passwordController.text,
              _nameController.text,
            );
          }

          // Validates to show errors if any
          _formKey.currentState?.validate();
        },
      );
}
