import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> registration({
    required String email,
    required String password,
    required String name,
    required File photo,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String photoURL =
          await uploadProfilePicture(userCredential.user!.uid, photo);
      await userCredential.user
          ?.updateProfile(displayName: name, photoURL: photoURL);

      // Reload the user to get the updated info
      await userCredential.user?.reload();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return 'Registration failed: ${e.toString()}';
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return 'Login failed: ${e.toString()}';
    }
  }

  Future<String> uploadProfilePicture(String uid, File photo) async {
    try {
      Reference ref = _storage.ref().child('profile_pictures').child(uid);
      UploadTask uploadTask = ref.putFile(photo);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }

  Future<void> updateUsername(String uid, String username) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(username);
        await user.reload(); // Ensure user data is reloaded
      } else {
        throw Exception('User is not signed in.');
      }
    } catch (e) {
      throw Exception('Failed to update username: $e');
    }
  }

  Future<void> updateEmail(String uid, String email) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(email);
        await user.reload(); // Ensure user data is reloaded
      } else {
        throw Exception('User is not signed in.');
      }
    } catch (e) {
      throw Exception('Failed to update email: $e');
    }
  }
}
