import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageEncryption {
  Future<Uint8List?> encryptImage(data) async {
    final key = Key.fromSecureRandom(16);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encryptedFile = encrypter.encryptBytes(data, iv: iv);
    return encryptedFile.bytes;
  }

  Future encryptAndUploadImage(File imageFile) async {
    // Membaca data gambar sebagai byte
    List<int> imageBytes = await imageFile.readAsBytes();

    // Membuat objek kunci enkripsi

    final key = Key.fromSecureRandom(16);
    // final key = Key.fromUtf8('zsmLvr_YU6u6F3e1VmXl3IAbeyFkQpGhIZupAV2TL4g=');
    final iv = IV.fromLength(16);

    // Membuat objek enkripsi menggunakan AES
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    // Mengenkripsi data gambar
    final encryptedImage = encrypter.encryptBytes(imageBytes, iv: iv);

    print(encryptedImage);

    // Mengunggah gambar terenkripsi ke Firebase Storage
    return encryptedImage.bytes;
  }
}
