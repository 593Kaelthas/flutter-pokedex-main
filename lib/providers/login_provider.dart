import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  Future<void> signIn(String usuario, String clave) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: usuario,
        password: clave,
      );
      _user = result.user;
      notifyListeners();
    } catch (error) {
      print("No se pudo iniciar sesión: $error");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> checkCurrentUser() async {
    _user = _auth.currentUser;
    notifyListeners();
  }
}
