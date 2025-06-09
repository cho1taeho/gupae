import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gupae/core/di/di_set_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/route/router.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  diSetUp();
  runApp(const ProviderScope()
  );
}

class GupaeApp extends StatelessWidget {
  const GupaeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '급해',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
