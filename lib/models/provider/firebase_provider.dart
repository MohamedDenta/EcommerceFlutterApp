import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../user.dart';

class FirebaseProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User _user = new User();
  User get user => _user;
  set setuser(u) => _user = u;
  FirebaseProvider() {
    getInstance();
  }
  getInstance() {
    _firebaseAuth.currentUser().then((onValue) async {
      if (onValue == null) {
        return;
      }
      var docs = await UserServices.getallusers();
      var b = false;
      for (var item in docs) {
        if (item['email'] == onValue.email) {
          _user.email = item['email'];
          _user.name = item['username'];
          _user.gender = item['gender'];
          _user.avatar = item['avatar'];
          UserUpdateInfo info = UserUpdateInfo();
          info.displayName = item['username'];
          info.photoUrl = item['avatar'];
          onValue.updateProfile(info);
          b = true;
          break;
        }
      }
      if (!b) {
        _user.email = onValue.email;
        _user.name = onValue.displayName;
      }
      notifyListeners();
    });
  }

  updateUser(User u) async {
    _user.name = u.name;
    _user.avatar = u.avatar;
    var auth = await _firebaseAuth.currentUser();
    Firestore.instance.collection(UserServices.ref).document(auth.uid).setData({
      'username': _user.name,
      'avatar': _user.avatar,
      'email': _user.email,
      'gender': _user.gender,
    }, merge: true).then((onValue) {});
    var info = UserUpdateInfo();
    info.displayName = u.name;
    info.photoUrl = u.avatar;
    auth.updateProfile(info);
    auth.reload();
    notifyListeners();

  }

  updateEmail(String email) async {
    _user.email = email;
    var auth = await _firebaseAuth.currentUser();
    // update in fire store
    Firestore.instance.collection(UserServices.ref).document(auth.uid).setData({
      'email': email,
    }, merge: true).then((onValue) {});
    // update in authentication
    auth.updateEmail(email);
    auth.reload();
    notifyListeners();
  }

  updatePwd(String pwd) async {
    _user.password = pwd;
    var auth = await _firebaseAuth.currentUser();
    // update in fire store
    // Firestore.instance.collection(UserServices.ref).document(auth.uid).setData({
    //   'password': pwd,
    // }, merge: true).then((onValue) {});
    // update in authentication
    auth.updatePassword(pwd);
    auth.reload();
    notifyListeners();
  }

  logout() {
    FirebaseAuth.instance.signOut().then((onValue) {
      //_user = User();
      notifyListeners();
    });
  }
}
