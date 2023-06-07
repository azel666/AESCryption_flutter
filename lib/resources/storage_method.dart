import 'dart:io';

import 'package:dio/dio.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sistem_kriptografi/resources/firestore_method.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String imgUrl = "";

  Future uploadImageToStorage(File image, String imageName) async {
    String res = "Some error occurred";
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = _storage.ref();
    Reference referenceDir = referenceRoot.child('images');
    Reference referenceImageUpload = referenceDir.child(fileName);

    try {
      await referenceImageUpload.putFile(File(image.path));
      imgUrl = await referenceImageUpload.getDownloadURL();
      await FirestoreMethod().addImage(imageName, imgUrl);
      res = "Success";
    } on FirebaseAuthException catch (err) {
      res = err.toString();
    }
    return res;
  }

  //download encrypt
  Future<void> downloadEncryptImage(String imageUrl, String imageName) async {
    // Mendapatkan direktori unduhan lokal
    var dir = await getExternalStorageDirectory();

    print(dir);

    // Mendapatkan nama file dari URL

    if (imageUrl.isNotEmpty) {
      // Mendownload file ke lokasi lokal
      final downloadsDirectory = '${dir!.path}/${imageName}';

      // final File file = File(downloadsDirectory);
      // await storageRef.writeToFile(file);
      try {
        await Dio().download(imageUrl, downloadsDirectory);
      } catch (e) {
        print(e);
      }
    }
  }

  //download decrypt
  Future<void> downloadDecryptImage(String imageUrl, String imageName) async {
    // Mendapatkan direktori unduhan lokal
    var dir = await getExternalStorageDirectory();

    // Mendapatkan nama file dari URL

    if (imageUrl.isNotEmpty) {
      // Mendownload file ke lokasi lokal
      final downloadsDirectory = '${dir!.path}/${imageName}.jpg';
      print(downloadsDirectory);
      // final File file = File(downloadsDirectory);
      // await storageRef.writeToFile(file);
      try {
        await Dio().download(imageUrl, downloadsDirectory);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> downloadImageUser(String imageUrl, String imageName) async {
    // Mendapatkan direktori unduhan lokal
    var dir = await getExternalStorageDirectory();
    Directory directory = Directory('/storage/emulated/0/Download');

    // Mendapatkan nama file dari URL

    if (imageUrl.isNotEmpty) {
      // Mendownload file ke lokasi lokal

      final downloadsDirectory = '${directory.path}/${imageName}';
      final extDirectory = '${dir!.path}/${imageName}';

      // final File file = File(downloadsDirectory);
      // await storageRef.writeToFile(file);
      try {
        await Dio().download(imageUrl, extDirectory);
        print(downloadsDirectory);
        print(extDirectory);
      } catch (e) {
        print(e);
      }
    }
  }

  //delete update previous foto
  void deleteEncryptImage(String imageUrl) async {
    if (imageUrl.isNotEmpty) {
      final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();
    }
  }
}
