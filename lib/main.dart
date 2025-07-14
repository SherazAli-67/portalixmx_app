import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/authentication/login_page.dart';
import 'package:portalixmx_app/features/main_menu/main_menu_page.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/providers/maintenance_provider.dart';
import 'package:portalixmx_app/providers/profile_provider.dart';
import 'package:portalixmx_app/providers/request_access_provider.dart';
import 'package:portalixmx_app/providers/tab_change_provider.dart';
import 'package:portalixmx_app/providers/user_info_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_constants.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';
import 'providers/language_provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> TabChangeProvider()),

      ChangeNotifierProvider(create: (_)=> UserViewModel()),
      ChangeNotifierProvider(create: (_)=> HomeProvider()),
      ChangeNotifierProvider(create: (_)=> MaintenanceProvider()),
      ChangeNotifierProvider(create: (_)=> LocaledProvider()),
      ChangeNotifierProvider(create: (_)=> RequestAccessProvider()),
      ChangeNotifierProvider(create: (_)=> ProfileProvider()),


    ], child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaledProvider>(context);

    return MaterialApp(
        title: AppConstants.appTitle,
        locale: provider.getLocale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        theme: ThemeData(
            fontFamily: AppConstants.appFontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            scaffoldBackgroundColor: AppColors.primaryColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors.primaryColor,)
        ),
        home: Consumer<UserViewModel>(builder: (ctx, provider, _) {
          return provider.userID != null ? MainMenuPage() : LoginPage();
        })
    );
  }
}
