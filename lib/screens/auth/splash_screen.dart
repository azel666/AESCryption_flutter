import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_kriptografi/screens/admin_screen/admin_dashboard.dart';

import 'package:sistem_kriptografi/screens/auth/login_screen.dart';
import 'package:sistem_kriptografi/screens/user_screen/user_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;
  String? role = "";
  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    super.initState();
    openHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('AESCryption',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }

  openHome() {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot snap) {
          if (snap.exists) {
            if (snap.get('role') == 'admin') {
              Get.off(() => const AdminDashboard());
            } else if (snap.get('role') == 'user') {
              Get.off(() => const UserDashboard());
            }
          }
        });
      } else {
        Get.off(const Login());
      }
    });
  }
}
