import 'package:flutter/material.dart';
import 'package:sistem_kriptografi/screens/admin_screen/admin_decrypt.dart';
import 'package:sistem_kriptografi/screens/admin_screen/admin_encrypt.dart';

class AdminTabBar extends StatefulWidget {
  const AdminTabBar({super.key});

  @override
  State<AdminTabBar> createState() => _AdminTabBarState();
}

class _AdminTabBarState extends State<AdminTabBar>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Encrypt Decrypt Image',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(
              text: 'Encrypt',
              icon: Icon(Icons.lock),
            ),
            Tab(
              text: 'Decrypt',
              icon: Icon(Icons.lock_open),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          const AdminEncrypt(),
          const AdminDecrypt(),
        ],
      ),
    );
  }
}
