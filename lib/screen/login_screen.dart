import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_screen.dart';
import '../services/api_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController email =
      TextEditingController();

  final TextEditingController password =
      TextEditingController();

  bool isLoading = false;

  bool obscurePassword = true;

  void login() async {

    setState(() {
      isLoading = true;
    });

    try {

      ApiService api = ApiService();

      final response = await api.login(
        email.text,
        password.text,
      );

      print(response);

      if (response['token'] != null) {

        SharedPreferences prefs =
            await SharedPreferences.getInstance();

        await prefs.setString(
          'token',
          response['token'],
        );

        if (!mounted) return;

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(
            builder: (_) =>
                const DashboardScreen(),
          ),
        );

      } else {

        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(
            content: Text(
              response['message'] ??
                  "Login gagal",
            ),
          ),
        );
      }

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F6FA),

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Container(

            width: 400,

            padding: const EdgeInsets.all(25),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(20),

              boxShadow: [

                BoxShadow(

                  color: Colors.grey
                      .withValues(alpha: 0.2),

                  blurRadius: 10,

                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Column(

              children: [

                // ICON
                const Icon(

                  Icons.school,

                  size: 90,

                  color: Color(0xFF6C4EF6),
                ),

                const SizedBox(height: 15),

                // TITLE
                const Text(

                  "Login",

                  style: TextStyle(

                    fontSize: 32,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // EMAIL
                TextField(

                  controller: email,

                  decoration: InputDecoration(

                    hintText: "Email",

                    prefixIcon:
                        const Icon(Icons.email),

                    filled: true,

                    fillColor:
                        Colors.grey.shade100,

                    border:
                        OutlineInputBorder(

                      borderRadius:
                          BorderRadius.circular(12),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // PASSWORD
                TextField(

                  controller: password,

                  obscureText: obscurePassword,

                  decoration: InputDecoration(

                    hintText: "Password",

                    prefixIcon:
                        const Icon(Icons.lock),

                    suffixIcon: IconButton(

                      onPressed: () {

                        setState(() {

                          obscurePassword =
                              !obscurePassword;
                        });
                      },

                      icon: Icon(

                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),

                    filled: true,

                    fillColor:
                        Colors.grey.shade100,

                    border:
                        OutlineInputBorder(

                      borderRadius:
                          BorderRadius.circular(12),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // BUTTON LOGIN
                SizedBox(

                  width: double.infinity,

                  height: 55,

                  child: ElevatedButton(

                    onPressed:
                        isLoading ? null : login,

                    style:
                        ElevatedButton.styleFrom(

                      backgroundColor:
                          const Color(0xFF6C4EF6),

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),

                    child: isLoading

                        ? const SizedBox(

                            height: 22,
                            width: 22,

                            child:
                                CircularProgressIndicator(

                              color: Colors.white,

                              strokeWidth: 2,
                            ),
                          )

                        : const Text(

                            "Login",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // REGISTER
                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    const Text(
                      "Belum punya akun?",
                    ),

                    TextButton(

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                const RegisterScreen(),
                          ),
                        );
                      },

                      child: const Text(

                        "Register",

                        style: TextStyle(

                          color:
                              Color(0xFF6C4EF6),

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}