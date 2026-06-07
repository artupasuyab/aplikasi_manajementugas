import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class EditTaskScreen extends StatefulWidget {

  final Map task;

  const EditTaskScreen({
    super.key,
    required this.task,
  });

  @override
  State<EditTaskScreen> createState() =>
      _EditTaskScreenState();
}

class _EditTaskScreenState
    extends State<EditTaskScreen> {

  late TextEditingController title;

  late TextEditingController description;

  late TextEditingController deadline;

  String status = "pending";

  bool isLoading = false;

  @override
  void initState() {

    super.initState();

    title = TextEditingController(
      text: widget.task['title'],
    );

    description = TextEditingController(
      text: widget.task['description'],
    );

    deadline = TextEditingController(
      text: widget.task['deadline'],
    );

    status = widget.task['status'];
  }

  Future<void> updateTask() async {

    if (title.text.isEmpty ||
        description.text.isEmpty ||
        deadline.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text("Semua field wajib diisi"),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      String token =
          prefs.getString('token') ?? '';

      ApiService api = ApiService();

      final response =
          await api.updateTask(

        token,

        widget.task['id'],

        {

          'title': title.text,

          'description':
              description.text,

          'deadline':
              deadline.text,

          'status': status,
        },
      );

      print(response);

      if (!mounted) return;

      if (response['success'] == true) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(
            content:
                Text("Tugas berhasil diupdate"),
          ),
        );

        Navigator.pop(
          context,
          true,
        );

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(
            content:
                Text("Gagal update tugas"),
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

      appBar: AppBar(

        backgroundColor:
            const Color(0xFF6C4EF6),

        title: const Text(
          "Edit Tugas",
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Container(

          padding:
              const EdgeInsets.all(20),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(20),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withOpacity(0.08),

                blurRadius: 10,

                offset:
                    const Offset(0, 5),
              ),
            ],
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // JUDUL
              const Text(

                "Judul",

                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller: title,

                decoration: InputDecoration(

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

              // DESKRIPSI
              const Text(

                "Deskripsi",

                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller:
                    description,

                maxLines: 4,

                decoration: InputDecoration(

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

              // DEADLINE
              const Text(

                "Deadline",

                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller: deadline,

                readOnly: true,

                onTap: () async {

                  DateTime? pickedDate =
                      await showDatePicker(

                    context: context,

                    initialDate:
                        DateTime.now(),

                    firstDate:
                        DateTime(2020),

                    lastDate:
                        DateTime(2100),
                  );

                  if (pickedDate != null) {

                    String formattedDate =

                        "${pickedDate.year}-"
                        "${pickedDate.month.toString().padLeft(2, '0')}-"
                        "${pickedDate.day.toString().padLeft(2, '0')}";

                    setState(() {

                      deadline.text =
                          formattedDate;
                    });
                  }
                },

                decoration: InputDecoration(

                  suffixIcon:
                      const Icon(
                    Icons.calendar_month,
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

              const SizedBox(height: 20),

              // STATUS
              const Text(

                "Status",

                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(

                value: status,

                items: const [

                  DropdownMenuItem(
                    value: "pending",
                    child:
                        Text("Pending"),
                  ),

                  DropdownMenuItem(
                    value: "process",
                    child:
                        Text("Proses"),
                  ),

                  DropdownMenuItem(
                    value: "done",
                    child:
                        Text("Selesai"),
                  ),
                ],

                onChanged: (value) {

                  setState(() {
                    status = value!;
                  });
                },

                decoration: InputDecoration(

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

              // BUTTON
              SizedBox(

                width: double.infinity,

                height: 55,

                child: ElevatedButton(

                  onPressed:
                      isLoading
                          ? null
                          : updateTask,

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

                      ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )

                      : const Text(
                          "UPDATE",
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}