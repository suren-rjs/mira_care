// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mira_care/resources/data/model/auth_user.dart';

_UserService userService = _UserService.instance;

class _UserService {
  _UserService._();

  static final _UserService instance = _UserService._();

  final _users = FirebaseFirestore.instance.collection("Users");

  Future<AuthUser?> get(String uid) async {
    List<AuthUser>? list = [];
    AuthUser? userInfo;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _users.where('uid', isEqualTo: uid).get();
    try {
      list = querySnapshot.docs
          .map((e) => AuthUser.fromJson(e.data(), e.id))
          .cast<AuthUser>()
          .toList();
      userInfo = list.first;
    } catch (e) {}
    return userInfo;
  }

  Future<bool> add(AuthUser user) async {
    return await _users.add(user.toJson()).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> update(AuthUser user) async {
    return await _users.doc(user.id).update(user.toJson()).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> delete(String id) async {
    return await _users.doc(id).delete().then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }
}
