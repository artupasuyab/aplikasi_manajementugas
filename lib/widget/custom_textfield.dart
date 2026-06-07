import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hint;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: controller,

      decoration: InputDecoration(

        hintText: hint,

        filled: true,

        fillColor: Colors.grey.shade100,

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(15),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}