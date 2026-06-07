import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {

  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(

        backgroundColor: const Color(0xFF6C4EF6),

        elevation: 0,

        title: const Text(
          "Kalender Deadline",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [

          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            // ================= HEADER =================

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: const Color(0xFF6C4EF6),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: const [

                  Text(

                    "Deadline Tugas",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(

                    "Pantau seluruh deadline tugas kuliah",

                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= LIST TASK =================

            Expanded(

              child: ListView(

                children: [

                  buildTaskCard(
                    "Belajar Laravel",
                    "25 Mei 2026",
                    "Pending",
                    Colors.orange,
                  ),

                  buildTaskCard(
                    "Membuat Laporan UTS",
                    "30 Mei 2026",
                    "Selesai",
                    Colors.green,
                  ),

                  buildTaskCard(
                    "Presentasi Project",
                    "5 Juni 2026",
                    "Proses",
                    Colors.blue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ================= TASK CARD =================

  Widget buildTaskCard(
    String title,
    String date,
    String status,
    Color color,
  ){

    return Container(

      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(

            color: Colors.grey.withOpacity(0.15),

            blurRadius: 10,

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(

        children: [

          Expanded(

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

                const SizedBox(height: 8),

                Text(

                  date,

                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Container(

            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            decoration: BoxDecoration(

              color: color,

              borderRadius: BorderRadius.circular(12),
            ),

            child: Text(

              status,

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}