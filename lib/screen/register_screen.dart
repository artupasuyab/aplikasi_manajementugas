import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  TextEditingController name =
      TextEditingController();

  TextEditingController email =
      TextEditingController();

  TextEditingController password =
      TextEditingController();

  TextEditingController confirmPassword =
      TextEditingController();

  bool isLoading = false;

  bool obscurePassword = true;

  bool obscureConfirmPassword = true;

  Future<void> register() async {

    if (name.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Semua field wajib diisi",
          ),
        ),
      );

      return;
    }

    if (password.text !=
        confirmPassword.text) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Konfirmasi password tidak sama",
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final response = await http.post(

        Uri.parse(
          'http://127.0.0.1:8000/api/register',
        ),

        headers: {
          'Accept': 'application/json',
        },

        body: {

          'name': name.text,
          'email': email.text,
          'password': password.text,
        },
      );

      final data =
          jsonDecode(response.body);

      print(data);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(
            content: Text(
              "Register berhasil",
            ),
          ),
        );

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(
            builder: (_) =>
                const LoginScreen(),
          ),
        );

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(
            content: Text(
              data['message']
                  .toString(),
            ),
          ),
        );
      }

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F6FA),

      body: Center(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child: Container(

            width: 420,

            padding:
                const EdgeInsets.all(25),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(25),

              boxShadow: [

                BoxShadow(

                  color:
                      Colors.black.withOpacity(0.08),

                  blurRadius: 15,

                  offset:
                      const Offset(0, 5),
                ),
              ],
            ),

            child: Column(

              children: [

                const Icon(

                  Icons.person_add_alt_1,

                  size: 85,

                  color:
                      Color(0xFF6C4EF6),
                ),

                const SizedBox(height: 15),

                const Text(

                  "Register",

                  style: TextStyle(

                    fontSize: 32,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 35),

                // NAMA
                TextField(

                  controller: name,

                  decoration: InputDecoration(

                    hintText:
                        "Nama Lengkap",

                    prefixIcon:
                        const Icon(
                      Icons.person,
                    ),

                    filled: true,

                    fillColor:
                        Colors.grey.shade100,

                    border:
                        OutlineInputBorder(

                      borderRadius:
                          BorderRadius.circular(15),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // EMAIL
                TextField(

                  controller: email,

                  decoration: InputDecoration(

                    hintText: "Email",

                    prefixIcon:
                        const Icon(
                      Icons.email,
                    ),

                    filled: true,

                    fillColor:
                        Colors.grey.shade100,

                    border:
                        OutlineInputBorder(

                      borderRadius:
                          BorderRadius.circular(15),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // PASSWORD
                TextField(

                  controller: password,

                  obscureText:
                      obscurePassword,

                  decoration: InputDecoration(

                    hintText:
                        "Password",

                    prefixIcon:
                        const Icon(
                      Icons.lock,
                    ),

                    suffixIcon:
                        IconButton(

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
                          BorderRadius.circular(15),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // KONFIRMASI PASSWORD
                TextField(

                  controller:
                      confirmPassword,

                  obscureText:
                      obscureConfirmPassword,

                  decoration: InputDecoration(

                    hintText:
                        "Konfirmasi Password",

                    prefixIcon:
                        const Icon(
                      Icons.lock,
                    ),

                    suffixIcon:
                        IconButton(

                      onPressed: () {

                        setState(() {

                          obscureConfirmPassword =
                              !obscureConfirmPassword;
                        });
                      },

                      icon: Icon(

                        obscureConfirmPassword
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
                          BorderRadius.circular(15),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // BUTTON REGISTER
                SizedBox(

                  width: double.infinity,

                  height: 55,

                  child: ElevatedButton(

                    onPressed:
                        isLoading
                            ? null
                            : register,

                    style:
                        ElevatedButton.styleFrom(

                      backgroundColor:
                          const Color(0xFF6C4EF6),

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    child: isLoading

                        ? const CircularProgressIndicator(
                            color:
                                Colors.white,
                          )

                        : const Text(

                            "Register",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    const Text(
                      "Sudah punya akun?",
                    ),

                    TextButton(

                      onPressed: () {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                const LoginScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        "Login",
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