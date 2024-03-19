import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/auth/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      try{
        Client clientResult = await getProfile(uid: user.uid);
        _client = clientResult;
        _isLoading = false;
        notifyListeners();
      }catch(e){
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
      if(exists == false){
        _isLoading = false;
        notifyListeners();
        Get.snackbar("Sorry", "Account Not Found!",
            backgroundColor: Colors.orange, colorText: Colors.white
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
      Get.snackbar("Failed", e.message!,
          backgroundColor: Colors.orange, colorText: Colors.white
      );
      _client = null;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      print(e.toString());
      Get.snackbar("Failed", "Something Went Wrong",
          backgroundColor: Colors.orange, colorText: Colors.white
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
      if(exists == true){
        _isLoading = false;
        notifyListeners();
        Get.snackbar("Sorry", "Account Already Exists!",
            backgroundColor: Colors.orange, colorText: Colors.white
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
      Get.snackbar("Failed", e.message!,
          backgroundColor: Colors.orange, colorText: Colors.white
      );
      _client = null;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      print(e.toString());
      Get.snackbar("Failed", "Something Went Wrong",
          backgroundColor: Colors.orange, colorText: Colors.white
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
    Get.offAll(const AuthWrapper());
  }

  Future<bool> deleteUserAccount({required String email, required String password}) async {
    FirebaseApp myApp = await Firebase.initializeApp(
        name: 'ticket', options: Firebase.app().options);
    FirebaseAuth autApp = FirebaseAuth.instanceFor(app: myApp);
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential result = await autApp.signInWithEmailAndPassword(
          email: email, password: password);
      await result.user!.delete();
      await myApp.delete();
      await _auth.signOut();
      _isLoading = false;
      notifyListeners();
      Get.snackbar("Account Deleted Successfully", "Come Again",
          backgroundColor: Colors.green, colorText: Colors.white);
      return true;
    } catch (e) {
      String err = e.toString();
      print(err);
      _isLoading = false;
      notifyListeners();
      Get.snackbar("Failed to Delete Account", "Come Again",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }
}
