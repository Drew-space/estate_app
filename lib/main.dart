import 'package:estate_app/firebase_options.dart';
import 'package:estate_app/real-estate/auth/auth_screen.dart';
import 'package:estate_app/real-estate/provider/connectivity_provider.dart';
import 'package:estate_app/real-estate/splash_screen.dart';
import 'package:estate_app/real-estate/utils/real_navbar.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  await Hive.openBox("favouritesBox");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(connectivityProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const AuthScreen(),
    );
  }
}
