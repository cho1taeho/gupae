import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gupae/core/di/di_set_up.dart';
import 'package:gupae/presentation/google_map_screen/google_map_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/route/router.dart';
import 'firebase_options.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  diSetUp();
  runApp(const GupaeApp());
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
