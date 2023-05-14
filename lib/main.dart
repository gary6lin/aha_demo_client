import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app_locale.dart';
import 'firebase_options.dart';
import 'presentation/main_app.dart';
import 'repositories/app_repository.dart';
import 'repositories/local/app_local_data_source.dart';
import 'repositories/remote/app_remote_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Dependency injection
  GetIt.I.registerSingleton(
    Dio(),
  );
  GetIt.I.registerSingleton(
    AppLocalDataSource(),
  );
  GetIt.I.registerSingleton(
    AppRemoteDataSource(
      GetIt.I<Dio>(),
    ),
  );
  GetIt.I.registerSingleton(
    AppRepository(
      GetIt.I<AppLocalDataSource>(),
      GetIt.I<AppRemoteDataSource>(),
    ),
  );

  runApp(
    EasyLocalization(
      path: 'res/l10n', // Default to use .json format
      supportedLocales: AppLocale.supportedLocales,
      fallbackLocale: AppLocale.fallbackLocale,
      child: const MainApp(),
    ),
  );
}
