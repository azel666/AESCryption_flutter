import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistem_kriptografi/models/user_model.dart' as model;

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get User Details
  Future<model.User> getUser() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnapshot(snapshot);
  }

  /// Signup Method
  Future<String> register({
    required username,
    required email,
    required password,
    required noTelp,
  }) async {
    String res = 'Some error occurred';

    try {
      // DateTime dateTime = DateTime.now();

      // String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          noTelp.isNotEmpty) {
        // Register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Add user to DB
        String uid = credential.user!.uid;
        final user = model.User(
          userid: uid,
          uName: username,
          email: email,
          noTelp: noTelp,
          role: "user",
          createdAt: DateTime.now(),
        );
        _firestore.collection('users').doc(uid).set(user.toJson());

        res = 'Success';
      } else {
        res = 'Please enter all the field';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /// Login Method
  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'Success';
      } else {
        res = 'Please enter all the field';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
