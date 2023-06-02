import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sistem_kriptografi/resources/firestore_method.dart';
import 'package:sistem_kriptografi/screens/admin_screen/admin_decrypt.dart';
import 'package:sistem_kriptografi/screens/admin_screen/admin_encrypt.dart';

import 'package:sistem_kriptografi/services/encrypt.dart';
import 'package:sistem_kriptografi/utils/my_color.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String imageUrl = "";

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

  final List<Widget> pages = [
    const AdminEncrypt(),
    const AdminDecrypt(),
    // AdminTabBar(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
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
                      Icons.lock,
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
                    padding: EdgeInsets.only(left: 10),
                    onPressed: () {
                      _updated_index(1);
                    },
                    icon: Icon(
                      Icons.lock_open,
                      color: _selected_index == 1
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
        floatingActionButton: FloatingActionButton(
            backgroundColor: "#99A3A4".toColor(),
            child: Icon(
              Icons.add,
              size: 35,
            ),
            onPressed: choiceShow),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: IndexedStack(
          index: _selected_index,
          children: pages,
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDir = referenceRoot.child('images');
    Reference referenceImageUpload = referenceDir.child(fileName);

    final ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      try {
        final result =
            await ImageEncryption().encryptAndUploadImage(File(imageFile.path));
        await referenceImageUpload.putData(result);
        imageUrl = await referenceImageUpload.getDownloadURL();

        await FirestoreMethod()
            .addImageEncrypt(imageFile.name.toString(), imageUrl);
        showAddDataSuccessDialog();
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }
  }

  void choiceShow() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(
            'pilih salah satu',
            textAlign: TextAlign.center,
          ),

          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Encrypt'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF2E4053)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Decrypt'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF2E4053)),
                  ),
                ),
              ],
            ),
          ),
          // actions: [
          //   ElevatedButton(
          //     child: Text('Batal'),
          //     onPressed: () {
          //       Get.back();
          //     },
          //   ),
          //   ElevatedButton(
          //     child: Text('Simpan'),
          //     onPressed: () async {
          //       // final ref = await FirebaseFirestore.instance
          //       //     .collection('aduan')
          //       //     .where('image')
          //       //     .get()
          //       //     .then((value) => addData());

          //       Get.back();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  void showAddDataSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'data upload',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Data berhasil ditambahkan',
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
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Get.offAll(AdminDashboard());
              },
            ),
          ],
        );
      },
    );
  }
}
