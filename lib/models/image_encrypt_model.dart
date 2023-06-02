import 'package:cloud_firestore/cloud_firestore.dart';

class ImageEncryptModel {
  String imageid;
  String imageName;
  String imageUrl;
  DateTime createdAt;
  String userid;

  ImageEncryptModel(
      {required this.imageid,
      required this.imageName,
      required this.imageUrl,
      required this.createdAt,
      required this.userid});

  static ImageEncryptModel fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ImageEncryptModel(
      imageid: snapshot['imageid'],
      imageName: snapshot['imageName'],
      imageUrl: snapshot['imageUrl'],
      createdAt: snapshot['createdAt'],
      userid: snapshot['userid'],
    );
  }

  Map<String, dynamic> toJson() => {
        "imageid": imageid,
        "imageName": imageName,
        "imageUrl": imageUrl,
        "createdAt": createdAt,
        "userid": userid,
      };
}
