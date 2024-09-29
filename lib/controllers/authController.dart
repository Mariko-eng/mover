import 'package:bus_stop/views/v3/auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/auth/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Client? _client;
  bool _isLoading = false;

  Client? get client => _client;

  bool get isLoading => _isLoading;

  UserProvider() {
    _fireSetUp();
  }

  _fireSetUp() {
    _isLoading = true;
    notifyListeners();
    _auth.authStateChanges().listen(_onStateChanged);
  }

  _onStateChanged(User? user) async {
    if (user == null) {
      _client = null;
      _isLoading = false;
      notifyListeners();
    } else {
      try {
        Client clientResult = await getProfile(uid: user.uid);
        _client = clientResult;
        _isLoading = false;
        notifyListeners();
      } catch (e) {
        await _auth.signOut();
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool exists = await checkIfUserExists(email);
      if (exists == false) {
        _isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(
            msg: "Account Not Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _client = null;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "Something Went Wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _client = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerClient(
      {required String email,
      required String password,
      required String phoneNumber,
      required String username}) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool exists = await checkIfUserExists(email);
      if (exists == true) {
        _isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(
            msg: "Account Already Exists!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Client? res = await createProfile(
          uid: userCredential.user!.uid,
          email: email,
          phoneNumber: phoneNumber,
          username: username);
      _client = res;
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _client = null;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _client = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _isLoading = true;
    notifyListeners();
    await _auth.signOut();
    _isLoading = false;
    notifyListeners();
    Get.offAll(const AuthWrapperView());
    // Get.offAll(const AuthWrapper());
  }
}
