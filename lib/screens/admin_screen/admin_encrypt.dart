import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_kriptografi/screens/admin_screen/widget/admin_encrypt_card.dart';
import 'package:sistem_kriptografi/screens/auth/login_screen.dart';

class AdminEncrypt extends StatefulWidget {
  const AdminEncrypt({super.key});

  @override
  State<AdminEncrypt> createState() => _AdminEncryptState();
}

class _AdminEncryptState extends State<AdminEncrypt> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection("images_encrypt");
    return data.orderBy("createdAt", descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        // backgroundColor: "#2E4053".toColor(),
        backgroundColor: Colors.grey,
        title: const Text(
          'Admin Encrypt',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: logout,
              icon: Icon(
                Icons.logout,
              )),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: content(),
      ),
    );
  }

  Widget content() {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final listAllDocument = snapshot.data!.docs;
            return AdminEncryptCard(listAllDocument: listAllDocument);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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
