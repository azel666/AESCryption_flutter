import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageDecryption {
  Future decryptImage(String encryptedImagePath) async {
    // Membaca data gambar terenkripsi dari Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child(encryptedImagePath);
    final downloadData = await storageRef.getData();

    // Membaca kunci enkripsi
    final key = Key.fromUtf8('alfredzich666');
    final iv = IV.fromLength(16);

    // Membuat objek dekripsi menggunakan AES
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    // Mendekripsi data gambar
    // final decryptedImage = encrypter.decryptBytes(Encrypted(downloadData), iv: iv);

    // Menyimpan gambar terdekripsi sebagai file
    File decryptedImageFile = File('path_to_save_decrypted_image.jpg');
    // await decryptedImageFile.writeAsBytes(decryptedImage);

    print('Decryption complete');
  }

  Future decryptAndUploadImage(File encryptedFile) async {
    // Membaca data gambar sebagai byte
    final imageBytes = await encryptedFile.readAsBytes();

    // Membaca kunci enkripsi
    final key = Key.fromSecureRandom(16);

    // final key = Key.fromUtf8('zsmLvr_YU6u6F3e1VmXl3IAbeyFkQpGhIZupAV2TL4g=');
    final iv = IV.fromLength(16);

    // Membuat objek dekripsi menggunakan AES
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    // Mendekripsi data gambar
    final decryptedImage =
        encrypter.decryptBytes(Encrypted(imageBytes), iv: iv);

    // Menyimpan gambar terdekripsi sebagai file
    return decryptedImage;
  }
}
