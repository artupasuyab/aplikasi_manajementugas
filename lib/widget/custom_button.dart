import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: double.infinity,
      height: 55,

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(

          backgroundColor:
              const Color(0xFF6C4EF6),

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15),
          ),
        ),

        onPressed: onPressed,

        child: Text(text),
      ),
    );
  }
}