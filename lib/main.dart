import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';
import 'quiz_provider.dart';
import 'auth_screen.dart';
import 'register_screen.dart';
import 'profile_screen.dart';
import 'dashboard_screen.dart';
import 'quiz_list_screen.dart';
import 'intro_screen.dart';
import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => QuizProvider()..loadQuizzes()),
      ],
      child: MaterialApp(
        title: 'ATU Quiz App',
        theme: appTheme, // Use the custom theme
        home: const IntroScreen(),
        routes: {
          '/auth': (context) => const AuthScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/quiz-list': (context) => const QuizListScreen(),
          '/register': (context) => const RegisterScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
