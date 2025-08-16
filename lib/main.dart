import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/authentication/login_page.dart';
import 'package:portalixmx_app/features/main_menu/resident_admin_main_menu.dart';
import 'package:portalixmx_app/features/main_menu/resident_main_menu_page.dart';
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

      ChangeNotifierProvider(create: (_)=> UserInfoProvider()),
      ChangeNotifierProvider(create: (_)=> HomeProvider()),
      ChangeNotifierProvider(create: (_)=> MaintenanceProvider()),
      ChangeNotifierProvider(create: (_)=> LocaledProvider()),
      ChangeNotifierProvider(create: (_)=> RequestAccessProvider()),
      ChangeNotifierProvider(create: (_)=> ProfileProvider()),


    ], child: const MyApp(),)
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Timer? _tokenCheckTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Start periodic token check (every 5 minutes)
    _tokenCheckTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      _checkTokenExpiry();
    });
    
    // Check token expiry on app start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkTokenExpiry();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tokenCheckTimer?.cancel();
    super.dispose();
  }

  void _checkTokenExpiry() {
    final userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    if (userInfoProvider.isLoggedIn && userInfoProvider.isTokenExpired) {
      userInfoProvider.reset();
      // The Consumer in build method will automatically redirect to LoginPage
      // when isLoggedIn becomes false
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkTokenExpiry();
    }
  }

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
        home: Consumer<UserInfoProvider>(builder: (ctx, provider, _) {
          return
            provider.isLoggedIn
                ? provider.isResidentAdmin ? ResidentAdminMainMenuPage() : ResidentMainMenuPage()
                : LoginPage();
        })
    );
  }
}
