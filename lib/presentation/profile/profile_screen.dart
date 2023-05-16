import 'package:aha_demo/presentation/widgets/app_card.dart';
import 'package:aha_demo/values/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../values/constants.dart';
import '../widgets/main_content_frame.dart';
import 'profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _vm = ProfileViewModel();

  @override
  Widget build(BuildContext context) => MainContentFrame(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUser(),
            ],
          ),
        ),
      );

  Widget _buildUser() => AppCard(
        child: ValueListenableBuilder(
          valueListenable: _vm.onUser,
          builder: (BuildContext context, User? user, Widget? child) {
            return Row(
              children: [
                CircleAvatar(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Builder(
                      builder: (BuildContext context) => user?.photoURL != null
                          ? Image.network(user!.photoURL!)
                          : Text(
                              user?.displayName?.split('').take(3).toString() ?? '',
                              style: AppTextStyle.titleRegular,
                            ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
