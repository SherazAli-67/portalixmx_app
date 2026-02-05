import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/firebase_options.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/authentication_provider/authentication_provider.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/providers/maintenance_provider.dart';
import 'package:portalixmx_app/providers/profile_provider.dart';
import 'package:portalixmx_app/providers/request_access_provider.dart';
import 'package:portalixmx_app/providers/user_info_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_constants.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> AuthenticationProvider()),
      ChangeNotifierProvider(create: (_)=> UserInfoProvider()),
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaledProvider>(context);

    return MaterialApp.router(
        title: AppConstants.appTitle,
        locale: provider.getLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
            fontFamily: AppConstants.appFontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            scaffoldBackgroundColor: AppColors.primaryColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors.primaryColor,)
        ),
        builder: (ctx, child){
          return child!;
        },
      routerConfig: appRouter,
        /*home: Consumer<UserInfoProvider>(builder: (ctx, provider, _) {
          return
            provider.isLoggedIn
                ? provider.isResidentAdmin ? ResidentAdminMainMenuPage() : ResidentMainMenuPage()
                : LoginPage();
        })*/
    );
  }
}
