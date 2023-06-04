import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

String? finalEncrypt;

class ImageEncryption {
  Future encryptImageFile(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    final key = Key.fromUtf8('15helloTCJTALK20');
    final iv = IV.fromUtf8('HgNRbGHbDSz9T0CC');
    // final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    final encryptedFile = encrypter.encryptBytes(imageBytes, iv: iv);
    final result = encryptedFile.base64;
    finalEncrypt = result;
    Uint8List? encrypt = result.isNotEmpty
        ? Uint8List.fromList(utf8.encode(finalEncrypt!))
        : null;
    return encrypt;
  }

  Future encryptAndUploadImage(File imageFile) async {
    // Membaca data gambar sebagai byte
    List<int> imageBytes = await imageFile.readAsBytes();

    // Membuat objek kunci enkripsi

    // final key = Key.fromSecureRandom(16);
    final key = Key.fromUtf8('15helloTCJTALK20');
    // final key = Key.fromUtf8('zsmLvr_YU6u6F3e1VmXl3IAbeyFkQpGhIZupAV2TL4g=');
    final iv = IV.fromLength(16);

    // Membuat objek enkripsi menggunakan AES
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    // Mengenkripsi data gambar
    final encryptedImage = encrypter.encryptBytes(imageBytes, iv: iv);

    print(encryptedImage);
    print(encryptedImage.bytes);

    // Mengunggah gambar terenkripsi ke Firebase Storage
    return encryptedImage.bytes;
  }
}
