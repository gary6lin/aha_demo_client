import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../values/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
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
          Text(
            tr('create_new_account'),
          ),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: tr('display_name'),
            ),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: tr('email_address'),
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: tr('password'),
            ),
          ),
          _buildSubmitButton(),
        ],
      );

  Widget _buildSubmitButton() => FilledButton(
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          alignment: Alignment.center,
          child: Text(
            tr('register_submission'),
          ),
        ),
        onPressed: () async {
          // TODO

          // final ds = GetIt.I<AppRemoteDataSource>();
          // await ds.register(
          //   RegisterDto(
          //     email: 'gary6lin@gmail.com',
          //     password: '12qw!@QW',
          //     displayName: 'G8',
          //   ),
          // );

          final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: 'gary6lin@gmail.com',
            password: '12qw!@QW',
          );

          // final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
          //   email: 'gary6lin@gmail.com',
          //   password: '12qw!@QW',
          // );
          cred.user?.sendEmailVerification(
            ActionCodeSettings(url: 'http://localhost:51483/?email=gary6lin@gmail.com'),
          );
        },
      );
}
