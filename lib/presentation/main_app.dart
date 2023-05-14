import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../routes/app_routes.dart';
import '../values/app_colors.dart';
import '../values/app_text_style.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    // Rebuild all children on locale changed
    void rebuild(Element e) {
      e.markNeedsBuild();
      e.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);

    return MaterialApp.router(
      title: 'Aha Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        // textTheme: const TextTheme(
        //   titleLarge: TextStyle(color: Colors.deepPurpleAccent),
        // ),
        canvasColor: AppColors.secondary,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: AppTextStyle.bodyBold,
            backgroundColor: AppColors.primary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: AppTextStyle.bodyRegular,
          floatingLabelStyle: AppTextStyle.bodyLargeRegular,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: AppColors.background.withOpacity(0.3),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.5, color: Colors.white24),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: AppColors.primary),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
        ),

        /// Set default font for the material widgets
        fontFamily: AppTextStyle.fontFamily,
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 850, name: MOBILE),
          const Breakpoint(start: 851, end: 1100, name: TABLET),
          const Breakpoint(start: 1101, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      routerConfig: AppRoute.goRouter,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
