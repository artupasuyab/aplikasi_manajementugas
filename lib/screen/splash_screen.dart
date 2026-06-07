import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    startSplash();
  }

  void startSplash() async {

    await Future.delayed(
      const Duration(seconds: 3),
    );

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String token =
        prefs.getString('token') ?? '';

    if (!mounted) return;

    // JIKA SUDAH LOGIN
    if (token.isNotEmpty) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) =>
              const DashboardScreen(),
        ),
      );

    } else {

      // JIKA BELUM LOGIN
      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) =>
              const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFF6C4EF6),

      body: Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // ICON
            Container(

              width: 120,
              height: 120,

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(30),
              ),

              child: const Icon(

                Icons.task_alt,

                size: 70,

                color: Color(0xFF6C4EF6),
              ),
            ),

            const SizedBox(height: 30),

            // TITLE
            const Text(

              "Task Management",

              style: TextStyle(

                color: Colors.white,

                fontSize: 28,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              "Kelola tugas lebih mudah",

              style: TextStyle(

                color: Colors.white70,

                fontSize: 16,
              ),
            ),

            const SizedBox(height: 50),

            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}