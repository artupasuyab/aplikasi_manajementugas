import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {

  final String title;
  final String description;
  final String status;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(

            title,

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(description),

          const SizedBox(height: 10),

          Chip(
            label: Text(status),
          )
        ],
      ),
    );
  }
}