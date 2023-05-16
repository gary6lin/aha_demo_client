import 'package:aha_demo/presentation/widgets/app_card.dart';
import 'package:aha_demo/routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_validator.dart';
import '../../values/app_text_style.dart';
import '../../values/constants.dart';
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
  final _currentPwdController = TextEditingController();
  final _newPwdController = TextEditingController();
  final _confirmPwdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _vm.onSignedOut = () {
      context.go(AppRoute.login.path);
    };

    _vm.onLoad();
  }

  @override
  Widget build(BuildContext context) => MainContentFrame(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(),
            const SizedBox(height: defaultPadding),
            _buildNameChange(),
            const SizedBox(height: defaultPadding),
            _buildPasswordChange(),
            const SizedBox(height: defaultPadding),
            _buildSignOutButton(),
          ],
        ),
      );

  Widget _buildUserInfo() => AppCard(
        width: null,
        child: ValueListenableBuilder(
          valueListenable: _vm.onUser,
          builder: (BuildContext context, User? user, Widget? child) => Row(
            children: [
              _buildAvatar(user),
              const SizedBox(width: 20),
              Column(
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
              ),
            ],
          ),
        ),
      );

  Widget _buildAvatar(User? user) => SizedBox(
        width: 96,
        height: 96,
        child: CircleAvatar(
          child: Builder(
            builder: (BuildContext context) => user?.photoURL != null
                ? Image.network(user!.photoURL!)
                : Text(
                    user?.displayName?.characters.first ?? '#',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
          ),
        ),
      );

  Widget _buildNameChange() => ExpandingDropdownTile(
        titleText: tr('update_name'),
        body: Column(
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
              // onPressed: () {
              //   // TODO
              // },
            ),
          ],
        ),
      );

  Widget _buildPasswordChange() => ExpandingDropdownTile(
        titleText: tr('change_password'),
        body: Column(
          children: [
            TextFormField(
              controller: _currentPwdController,
              decoration: InputDecoration(
                labelText: tr('current_password'),
              ),
              validator: AppValidator.password,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 28),
            TextFormField(
              controller: _newPwdController,
              decoration: InputDecoration(
                labelText: tr('new_password'),
              ),
              validator: AppValidator.password,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 28),
            TextFormField(
              controller: _confirmPwdController,
              decoration: InputDecoration(
                labelText: tr('confirm_password'),
              ),
              validator: (value) => value != _newPwdController.text ? tr('confirm_password_error') : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 28),
            AppFilledButton(
              child: Text(
                tr('change_password_submission'),
              ),
              // onPressed: () {
              //   // TODO
              // },
            ),
          ],
        ),
      );

  Widget _buildSignOutButton() => AppFilledButton(
        child: Text(
          tr('log_out'),
        ),
        onPressed: () async {
          await _vm.onSignOut();
        },
      );
}
