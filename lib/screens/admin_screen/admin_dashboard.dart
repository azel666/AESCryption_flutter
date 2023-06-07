import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sistem_kriptografi/resources/firestore_method.dart';

import 'package:sistem_kriptografi/screens/admin_screen/admin_home.dart';
import 'package:sistem_kriptografi/screens/admin_screen/admin_tab_bar.dart';
import 'package:sistem_kriptografi/services/decrypt.dart';

import 'package:sistem_kriptografi/services/encrypt.dart';
import 'package:sistem_kriptografi/utils/my_color.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String imageUrl = "";
  bool isLoading = false;

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
    const AdminHome(),
    const AdminTabBar(),
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
                      Icons.home,
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
                      Icons.folder,
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

  Future<void> uploadImageEncrypt() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDir = referenceRoot.child('images_encrypt');
    Reference referenceImageUpload = referenceDir.child(fileName);

    final ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      try {
        loadingDialogEncrypt();
        final result =
            await ImageEncryption().encryptImageFile(File(imageFile.path));
        await referenceImageUpload.putData(result);
        imageUrl = await referenceImageUpload.getDownloadURL();

        final res = await FirestoreMethod()
            .addImageEncrypt(imageFile.name.toString(), imageUrl);

        if (res == 'Success') {
          Navigator.of(context).pop();
          showAddDataSuccessDialog();
        } else {}
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }
  }

  Future<void> uploadImageDecrypt() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDir = referenceRoot.child('images_decrypt');
    Reference referenceImageUpload = referenceDir.child(fileName);

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      File file = File(result.files.single.path!);

      final fileName = result.files.first.name;

      try {
        loadingDialogDecrypt();
        final result = await ImageDecryption().decryptedImageFile(file);
        await referenceImageUpload.putData(result);
        imageUrl = await referenceImageUpload.getDownloadURL();

        final res = await FirestoreMethod().addImageDecrypt(fileName, imageUrl);
        if (res == 'Success') {
          Navigator.of(context).pop();
          showAddDataSuccessDialog();
        }
      } on FirebaseException catch (e) {
        print(e.message);
      }
    } else {
      // User canceled the picker
      null;
    }
  }

  void loadingDialogEncrypt() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                "enkripsi file...",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void loadingDialogDecrypt() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                "dekripsi file...",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
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
                  onPressed: uploadImageEncrypt,
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
                  onPressed: uploadImageDecrypt,
                  child: Text('Decrypt'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF2E4053)),
                  ),
                ),
              ],
            ),
          ),
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
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
