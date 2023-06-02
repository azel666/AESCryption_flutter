import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_kriptografi/utils/my_color.dart';

import '../auth/login_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selected_index = 0;

  void _updated_index(int index) {
    setState(() {
      _selected_index = index;
    });
  }

  Future<bool> onBackPressed() {
    if (_selected_index != 0) {
      setState(() {
        _selected_index = 0;
      });
      return Future.value(false); // Tidak tindak lanjuti navigasi kembali
    }
    return Future.value(true); // Tindak lanjuti navigasi kembali
  }

  final pages = [
    Center(child: const Text('page 1')),
    Center(child: const Text('page 2')),
    Center(child: const Text('page 3')),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          // backgroundColor: "#2E4053".toColor(),
          backgroundColor: Colors.white,
          title: const Text(
            'Dashboard Admin',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Poppins',
              color: Color(0xFF2E4053),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: logout,
                icon: Icon(Icons.logout, color: Colors.black)),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.only(bottom: 5),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: "#2E4053".toColor().withOpacity(0.8),
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.only(right: 20),
                    onPressed: () {
                      _updated_index(0);
                    },
                    icon: Icon(
                      Icons.verified,
                      color: _selected_index == 0
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      _updated_index(1);
                    },
                    icon: Icon(
                      Icons.history,
                      color: _selected_index == 1
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.only(left: 10),
                    onPressed: () {
                      _updated_index(2);
                    },
                    icon: Icon(
                      Icons.assignment_ind,
                      color: _selected_index == 2
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _selected_index,
          children: pages,
        ),
      ),
    );
  }

  void logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Apakah anda ingin keluar?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2E4053)),
              ),
              child: const Text(
                'Ya',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.deleteAll();
                Get.offAll(const Login());
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2E4053)),
              ),
              child: const Text(
                'Tidak',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
