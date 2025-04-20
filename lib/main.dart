import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gupae/presentation/google_map_screen/google_map_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const GupaeApp());
}

class GupaeApp extends StatelessWidget {
  const GupaeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '급해',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const GoogleMapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
