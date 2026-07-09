import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/firebase_messaging_background.dart';
import 'package:portalixmx_app/firebase_options.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/authentication_provider/authentication_provider.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/providers/profile_provider.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:portalixmx_app/services/push_notification_service/push_notification_service.dart';
import 'package:provider/provider.dart';
import 'core/res/app_colors.dart';
import 'core/res/app_constants.dart';
import 'providers/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await PushNotificationService.instance.initialize(router: appRouter);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LocaledProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.primaryColor,
        ),
      ),
      builder: (ctx, child) {
        return child!;
      },
      routerConfig: appRouter,
    );
  }
}
