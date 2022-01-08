import 'package:event_app/configs/theme/theme.dart';
import 'package:event_app/modules/home/ui/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: AppTheme.themeData,
      home: const EventScreen(),
    );
  }
}
