import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/current_user.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_validator.dart';
import '../../values/app_colors.dart';
import '../../values/app_text_style.dart';
import '../../values/constants.dart';
import '../widgets/app_card.dart';
import '../widgets/app_filled_button.dart';
import '../widgets/expanding_dropdown_tile.dart';
import '../widgets/main_content_frame.dart';
import 'profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _vm = ProfileViewModel();

  final _nameController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _updateNameExpandableController = ExpandableController();
  final _changePasswordExpandableController = ExpandableController();

  final _nameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _vm.onUpdatedDisplayName = () {
      _updateNameExpandableController.expanded = false;
    };

    _vm.onChangedPassword = () {
      _changePasswordExpandableController.expanded = false;
    };

    _vm.onSignedOut = () {
      context.go(AppRoute.login.path);
    };

    _vm.loadProfile();
  }

  @override
  Widget build(BuildContext context) => MainContentFrame(
        child: ValueListenableBuilder(
          valueListenable: _vm.onIsEmailAuth,
          builder: (BuildContext context, bool isEmailAuth, Widget? child) => Column(
            children: [
              _buildUserProfile(),
              const SizedBox(height: defaultPadding),
              _buildDisplayNameChange(),
              const SizedBox(height: defaultPadding),
              if (isEmailAuth) _buildPasswordChange(),
              if (isEmailAuth) const SizedBox(height: defaultPadding),
              _buildSignOutButton(),
            ],
          ),
        ),
      );

  Widget _buildUserProfile() => AppCard(
        width: null,
        child: ValueListenableBuilder(
          valueListenable: _vm.onUserModel,
          builder: (BuildContext context, CurrentUser? user, Widget? child) => Row(
            children: [
              _buildAvatar(user),
              const SizedBox(width: 20),
              _buildUserInfo(user),
            ],
          ),
        ),
      );

  Widget _buildAvatar(CurrentUser? user) => SizedBox(
        width: 96,
        height: 96,
        child: CircleAvatar(
          foregroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
          child: Text(
            user?.displayName?.characters.first.toUpperCase() ?? '#',
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      );

  Widget _buildUserInfo(CurrentUser? user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user?.displayName ?? '#',
            style: AppTextStyle.bodyRegular,
          ),
          const SizedBox(height: 8),
          Text(
            user?.email ?? '#',
            style: AppTextStyle.bodyRegular,
          ),
        ],
      );

  Widget _buildDisplayNameChange() => Form(
        key: _nameFormKey,
        child: ExpandingDropdownTile(
          controller: _updateNameExpandableController,
          titleText: tr('update_name'),
          content: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: tr('display_name'),
                ),
                validator: AppValidator.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 28),
              AppFilledButton(
                child: Text(
                  tr('update_name_submission'),
                ),
                onPressed: () async {
                  final nameError = AppValidator.name(_nameController.text);

                  // Submit only if there is no error
                  if (nameError == null) {
                    await _vm.updateDisplayName(
                      _nameController.text,
                    );
                  }

                  // Validates to show errors if any
                  _nameFormKey.currentState?.validate();
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildPasswordChange() => Form(
        key: _passwordFormKey,
        child: ExpandingDropdownTile(
          controller: _changePasswordExpandableController,
          titleText: tr('change_password'),
          content: Column(
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: tr('current_password'),
                ),
                obscureText: true,
                validator: AppValidator.password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: tr('new_password'),
                ),
                obscureText: true,
                validator: AppValidator.password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: tr('confirm_password'),
                ),
                obscureText: true,
                validator: (value) => AppValidator.passwordConfirm(value, _newPasswordController.text),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 28),
              AppFilledButton(
                child: Text(
                  tr('change_password_submission'),
                ),
                onPressed: () async {
                  final currentPassword = _currentPasswordController.text;
                  final newPassword = _newPasswordController.text;
                  final confirmPassword = _confirmPasswordController.text;

                  final currentPasswordError = AppValidator.password(currentPassword);
                  final newPasswordError = AppValidator.password(newPassword);
                  final confirmPasswordError = AppValidator.passwordConfirm(newPassword, confirmPassword);

                  // Submit only if there is no error
                  if (currentPasswordError == null && newPasswordError == null && confirmPasswordError == null) {
                    await _vm.changePassword(
                      currentPassword,
                      newPassword,
                    );
                  }

                  // Validates to show errors if any
                  _passwordFormKey.currentState?.validate();
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildSignOutButton() => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.error,
        ),
        child: Text(
          tr('log_out'),
        ),
        onPressed: () async {
          await _vm.onSignOut();
        },
      );
}
