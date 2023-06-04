import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_kriptografi/screens/admin_screen/widget/admin_decrypt_card.dart';

class AdminDecrypt extends StatefulWidget {
  const AdminDecrypt({super.key});

  @override
  State<AdminDecrypt> createState() => _AdminDecryptState();
}

class _AdminDecryptState extends State<AdminDecrypt> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection("images_decrypt");
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
          'Admin Decrypt',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
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
            return AdminDecryptCard(listAllDocument: listAllDocument);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
