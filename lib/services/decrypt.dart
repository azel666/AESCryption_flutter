import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class ImageDecryption {
  Future decryptedImageFile(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    final key = Key.fromUtf8('15helloTCJTALK20');
    final iv = IV.fromUtf8('HgNRbGHbDSz9T0CC');
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    final encrypted = Encrypted.fromBase64(utf8.decode(imageBytes));
    final decrypted = encrypter.decryptBytes(encrypted, iv: iv);

    return Uint8List.fromList(decrypted);
  }

  Future decryptAndUploadImage(File imageFile) async {
    // Membaca kunci
    List<int> imageBytes = await imageFile.readAsBytes();
    Uint8List uint8FileBytes = Uint8List.fromList(imageBytes);

    final key = Key.fromUtf8('15helloTCJTALK20');

    final iv = IV.fromLength(16);

    // Membuat objek dekripsi menggunakan AES
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    // Mendekripsi data gambar
    final decryptedImage =
        encrypter.decryptBytes(Encrypted(uint8FileBytes), iv: iv);

    // Menyimpan gambar terdekripsi sebagai file

    return decryptedImage;
  }
}
