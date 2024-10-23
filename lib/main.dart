// ignore_for_file: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:textingslap/auth/authGate.dart';
import 'package:textingslap/auth/authService.dart';
import 'package:textingslap/provider/themesProvider.dart';
import '../pages/notification.dart';
import '../pages/notificationSreen.dart';
import 'package:textingslap/theme/firstTheme/themes/themesProvider.dart';
import 'package:sizer/sizer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await Future.delayed(Duration(seconds: 10));
  // FlutterNativeSplash.remove();

  await Firebase.initializeApp();
  await AuthService().initNotificatoins();
  runApp(ChangeNotifierProvider(
    create: (context) {
      return ThemeProvider();
    },
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return ThemesProvider();
        }),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return MaterialApp(
            // theme: theme.getTheme(),
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: AuthGate(),
          );
        },
      ),
    );
  }
}
