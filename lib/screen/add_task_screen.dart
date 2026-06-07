import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

class _AddTaskScreenState
    extends State<AddTaskScreen> {

  TextEditingController title =
      TextEditingController();

  TextEditingController description =
      TextEditingController();

  TextEditingController deadline =
      TextEditingController();

  String status = "pending";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F6FA),

      appBar: AppBar(

        backgroundColor:
            const Color(0xFF6C4EF6),

        title: const Text(
          "Tambah Tugas",
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Container(

          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(20),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.grey.withOpacity(0.2),

                blurRadius: 10,

                offset: const Offset(0, 5),
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
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller: title,

                decoration: InputDecoration(

                  hintText:
                      "Masukkan judul tugas",

                  filled: true,

                  fillColor:
                      Colors.grey.shade100,

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(12),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // DESKRIPSI
              const Text(

                "Deskripsi",

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller: description,

                maxLines: 4,

                decoration: InputDecoration(

                  hintText:
                      "Masukkan deskripsi tugas",

                  filled: true,

                  fillColor:
                      Colors.grey.shade100,

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(12),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // DEADLINE
              const Text(

                "Deadline",

                style: TextStyle(
                  fontWeight: FontWeight.bold,
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

                    initialDate: DateTime.now(),

                    firstDate: DateTime(2020),

                    lastDate: DateTime(2100),

                    builder: (context, child) {

                      return Theme(

                        data: Theme.of(context).copyWith(

                          colorScheme: const ColorScheme.light(

                            primary: Color(0xFF6C4EF6),
                          ),
                        ),

                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {

                    String formattedDate =
                        "${pickedDate.year}-"
                        "${pickedDate.month.toString().padLeft(2, '0')}-"
                        "${pickedDate.day.toString().padLeft(2, '0')}";

                    setState(() {

                      deadline.text = formattedDate;
                    });
                  }
                },

                decoration: InputDecoration(

                  hintText: "Pilih tanggal deadline",

                  suffixIcon:
                      const Icon(Icons.calendar_month),

                  filled: true,

                  fillColor:
                    Colors.grey.shade100,

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(12),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // STATUS
              const Text(

                "Status",

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(

                value: status,

                items: const [

                  DropdownMenuItem(
                    value: "pending",
                    child: Text("Pending"),
                  ),

                  DropdownMenuItem(
                    value: "process",
                    child: Text("Process"),
                  ),

                  DropdownMenuItem(
                    value: "done",
                    child: Text("Done"),
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

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // BUTTON
              SizedBox(

                width: double.infinity,
                height: 55,

                child: ElevatedButton(

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

                  onPressed: isLoading
                      ? null
                      : () async {

                    // VALIDASI
                    if (title.text.isEmpty ||
                        description.text.isEmpty ||
                        deadline.text.isEmpty) {

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

                    try {

                      setState(() {
                        isLoading = true;
                      });

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      String token =
                          prefs.getString('token') ?? '';

                      ApiService api =
                          ApiService();

                      final response =
                          await api.addTask(

                        token,

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
                            content: Text(
                              "Tugas berhasil disimpan",
                            ),
                          ),
                        );

                        Navigator.pop(
                          context,
                          true,
                        );

                      } else {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(

                          SnackBar(
                            content: Text(
                              response['message']
                                  .toString(),
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

                    } finally {

                      if (mounted) {

                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },

                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "SIMPAN TUGAS",
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