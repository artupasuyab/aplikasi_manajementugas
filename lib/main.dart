import 'dart:async';

import 'package:flutter/material.dart';

import 'screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Task Management',

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Poppins',
      ),

      home: const SplashScreen(),
    );
  }
}

// ================= SPLASH SCREEN =================

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

    Timer(
      const Duration(seconds: 3),
      () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(
            builder: (_) =>
                const LoginScreen(),
          ),
        );
      },
    );
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

              padding:
                  const EdgeInsets.all(25),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(30),
              ),

              child: const Icon(

                Icons.task_alt,

                size: 80,

                color: Color(0xFF6C4EF6),
              ),
            ),

            const SizedBox(height: 30),

            // TITLE
            const Text(

              "Task Management",

              style: TextStyle(

                fontSize: 30,

                fontWeight:
                    FontWeight.bold,

                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              "Kelola tugasmu lebih mudah",

              style: TextStyle(

                fontSize: 16,

                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 40),

            // LOADING
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}