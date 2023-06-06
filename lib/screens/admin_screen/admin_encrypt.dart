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
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
