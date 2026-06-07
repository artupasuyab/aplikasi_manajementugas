import 'package:flutter/material.dart';

class DetailTaskScreen extends StatelessWidget {

  final dynamic task;

  const DetailTaskScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detail"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              task['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(task['description']),
          ],
        ),
      ),
    );
  }
}