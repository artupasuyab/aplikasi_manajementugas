import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';
import 'add_task_screen.dart';
import 'calendar_screen.dart';
import 'detail_task_screen.dart';
import 'edit_task_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  List tasks = [];

  int currentIndex = 0;

  bool isLoading = true;

  // ================= GET TASKS =================

  Future<void> getTasks() async {

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
          await api.getTasks(token);

      setState(() {

        tasks = List.from(response);

        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

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
  }

  // ================= INIT =================

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F6FA),

      // ================= APPBAR =================

      appBar: AppBar(

        backgroundColor:
            const Color(0xFF6C4EF6),

        foregroundColor:
            Colors.white,

        elevation: 0,

        title: const Text(
          "Manajemen Tugas",
        ),

        actions: [

          IconButton(

            onPressed: () async {

              SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              String token =
                  prefs.getString('token') ?? '';

              ApiService api = ApiService();

              await api.logout(token);

              await prefs.remove('token');

              if (!mounted) return;

              Navigator.pushReplacement(

                context,

                MaterialPageRoute(
                  builder: (_) =>
                      const LoginScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),

      // ================= BODY =================

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : tasks.isEmpty

              ? const Center(
                  child: Text(
                    "Belum ada tugas",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )

              : ListView.builder(

                  padding:
                      const EdgeInsets.all(15),

                  itemCount: tasks.length,

                  itemBuilder:
                      (context, index) {

                    return Container(

                      margin:
                          const EdgeInsets.only(
                        bottom: 15,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                                Colors.grey.withValues(
                              alpha: 0.15,
                            ),

                            blurRadius: 10,

                            offset:
                                const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: ListTile(

                        contentPadding:
                            const EdgeInsets.all(20),

                        // ================= TITLE =================

                        title: Text(

                          tasks[index]['title']
                              .toString(),

                          style: const TextStyle(

                            fontSize: 18,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        // ================= SUBTITLE =================

                        subtitle: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const SizedBox(
                              height: 10,
                            ),

                            Text(
                              tasks[index]['description']
                                  .toString(),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Row(

                              children: [

                                const Icon(
                                  Icons.calendar_month,
                                  size: 18,
                                  color: Colors.grey,
                                ),

                                const SizedBox(
                                  width: 5,
                                ),

                                Text(
                                  tasks[index]['deadline']
                                      .toString(),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),

                              decoration: BoxDecoration(

                                color:
                                    tasks[index]['status']
                                                .toString() ==
                                            "Selesai"

                                        ? Colors.green

                                        : tasks[index]['status']
                                                    .toString() ==
                                                "Proses"

                                            ? Colors.orange

                                            : Colors.red,

                                borderRadius:
                                    BorderRadius.circular(
                                  20,
                                ),
                              ),

                              child: Text(

                                tasks[index]['status']
                                    .toString(),

                                style: const TextStyle(

                                  color: Colors.white,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // ================= MENU =================

                        trailing:
                            PopupMenuButton(

                          itemBuilder: (context) {

                            return [

                              const PopupMenuItem(
                                value: 'detail',
                                child: Text(
                                  "Detail",
                                ),
                              ),

                              const PopupMenuItem(
                                value: 'edit',
                                child: Text(
                                  "Edit",
                                ),
                              ),

                              const PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  "Hapus",
                                ),
                              ),
                            ];
                          },

                          onSelected:
                              (value) async {

                            // ================= DETAIL =================

                            if (value == 'detail') {

                              Navigator.push(

                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailTaskScreen(
                                    task:
                                        tasks[index],
                                  ),
                                ),
                              );
                            }

                            // ================= EDIT =================

                            if (value == 'edit') {

                              final result =
                                  await Navigator.push(

                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditTaskScreen(
                                    task:
                                        tasks[index],
                                  ),
                                ),
                              );

                              if (result == true) {
                                getTasks();
                              }
                            }

                            // ================= DELETE =================

                            if (value == 'delete') {

                              SharedPreferences prefs =
                                  await SharedPreferences
                                      .getInstance();

                              String token =
                                  prefs.getString(
                                        'token',
                                      ) ??
                                      '';

                              ApiService api =
                                  ApiService();

                              await api.deleteTask(

                                token,

                                int.parse(
                                  tasks[index]['id']
                                      .toString(),
                                ),
                              );

                              getTasks();

                              if (!mounted) return;

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(

                                const SnackBar(
                                  content: Text(
                                    "Tugas berhasil dihapus",
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),

      // ================= FLOATING BUTTON =================

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            const Color(0xFF6C4EF6),

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: () async {

          final result =
              await Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) =>
                  const AddTaskScreen(),
            ),
          );

          if (result == true) {
            getTasks();
          }
        },
      ),

      // ================= BOTTOM NAVIGATION =================

      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex: currentIndex,

        selectedItemColor:
            const Color(0xFF6C4EF6),

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });

          // HOME
          if (index == 0) {}

          // KALENDER
          if (index == 1) {

            Navigator.push(

              context,

              MaterialPageRoute(
                builder: (_) =>
                    const CalendarScreen(),
              ),
            );
          }
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon:
                Icon(Icons.calendar_month),
            label: "Kalender",
          ),
        ],
      ),
    );
  }
}