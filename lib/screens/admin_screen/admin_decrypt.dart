import 'package:flutter/material.dart';

class AdminDecrypt extends StatefulWidget {
  const AdminDecrypt({super.key});

  @override
  State<AdminDecrypt> createState() => _AdminDecryptState();
}

class _AdminDecryptState extends State<AdminDecrypt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('decrypt'),
      ),
    );
  }
}
