import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistem_kriptografi/models/image_decrypt_model.dart';
import 'package:sistem_kriptografi/models/image_encrypt_model.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String randomName = DateTime.now().millisecondsSinceEpoch.toString();
  //add data aduan ke firestore
  Future<String> addImageEncrypt(String imageName, String imageUrl) async {
    String res = "Some error occurred";
    try {
      final col = _firestore.collection('images_encrypt');
      final doc = col.doc();
      ImageEncryptModel images = ImageEncryptModel(
        imageid: doc.id,
        imageName: imageName,
        imageUrl: imageUrl,
        randomName: randomName,
        createdAt: DateTime.now(),
        userid: uid,
      );
      _firestore.collection('images_encrypt').doc(doc.id).set(images.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addImageDecrypt(String imageName, String imageUrl) async {
    String res = "Some error occurred";
    try {
      final col = _firestore.collection('images_decrypt');
      final doc = col.doc();
      ImageDecryptModel images = ImageDecryptModel(
        imageid: doc.id,
        imageName: imageName,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
        userid: uid,
      );
      _firestore.collection('images_decrypt').doc(doc.id).set(images.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
