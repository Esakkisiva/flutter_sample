import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart';
import 'screens/settings_page.dart';
import 'screens/community_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.purpleAccent),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const HomePage(),
      routes: {
        '/profile': (context) =>  const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/community': (context) =>  const CommunityPage(),
      },
    );
  }
}

