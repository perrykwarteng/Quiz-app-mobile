import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this for Firestore
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Add this for Firestore

  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? number;
  String? indexNumber;

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String number,
    required String indexNumber,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.number = number;
        this.indexNumber = indexNumber;
        userName = '$firstName $lastName';

        // Store additional user data in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'number': number,
          'indexNumber': indexNumber,
        });

        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = _auth.currentUser;
      if (user != null) {
        // Retrieve user data from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          var data = userDoc.data() as Map<String, dynamic>;
          firstName = data['firstName'];
          lastName = data['lastName'];
          this.email = data['email'];
          number = data['number'];
          indexNumber = data['indexNumber'];
          userName = '$firstName $lastName';

          notifyListeners();
        }
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> update({
    String? firstName,
    String? lastName,
    String? email,
    String? number,
    String? indexNumber,
  }) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Update Firebase Authentication profile (e.g., display name)
        if (firstName != null && lastName != null) {
          await user.updateProfile(displayName: '$firstName $lastName');
        }

        // Update additional user data in Firestore
        await _firestore.collection('users').doc(user.uid).update({
          if (firstName != null) 'firstName': firstName,
          if (lastName != null) 'lastName': lastName,
          if (email != null) 'email': email,
          if (number != null) 'number': number,
          if (indexNumber != null) 'indexNumber': indexNumber,
        });

        // Update local state
        this.firstName = firstName ?? this.firstName;
        this.lastName = lastName ?? this.lastName;
        this.email = email ?? this.email;
        this.number = number ?? this.number;
        this.indexNumber = indexNumber ?? this.indexNumber;
        userName = '$firstName $lastName';

        notifyListeners();
      } catch (e) {
        throw Exception(e.toString());
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    userName = null;
    firstName = null;
    lastName = null;
    email = null;
    number = null;
    indexNumber = null;
    notifyListeners();
  }
}
