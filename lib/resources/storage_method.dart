import 'dart:io';

import 'package:dio/dio.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadImageToStorage(String imgUrl, XFile image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = _storage.ref();
    Reference referenceDir = referenceRoot.child('images');
    Reference referenceImageUpload = referenceDir.child(fileName);

    try {
      await referenceImageUpload.putFile(File(image.path));
      imgUrl = await referenceImageUpload.getDownloadURL();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  //download encrypt
  Future<void> downloadEncryptImage(String imageUrl, String imageName) async {
    // Mendapatkan direktori unduhan lokal
    var dir = await getExternalStorageDirectory();

    print(dir);

    // Mendapatkan nama file dari URL
    // final Uri uri = Uri.parse(imageUrl);
    // final fileName = uri.pathSegments.last;

    if (imageUrl.isNotEmpty) {
      final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      // Mendownload file ke lokasi lokal
      final downloadsDirectory = '${dir!.path}/${imageName}.txt';
      print(downloadsDirectory);
      // final File file = File(downloadsDirectory);
      // await storageRef.writeToFile(file);
      try {
        await Dio().download(imageUrl, downloadsDirectory);
      } catch (e) {
        print(e);
      }
      // await GallerySaver.saveImage(downloadsDirectory, toDcim: true);
    }
  }

  //delete update previous foto
  void deleteEncryptImage(String imageUrl) async {
    if (imageUrl.isNotEmpty) {
      final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();
    }
  }

  void requestPermission() async {
//permission_handler 10.2.0
    await Permission.manageExternalStorage.request();
  }
}
