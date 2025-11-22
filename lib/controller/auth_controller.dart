import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  UserModel? user;

  bool get isLoggedIn => user != null;

  Future<bool> register({
    required String nama,
    required String username,
    required String telepon,
    required String alamat,
    required String password,
  }) async {
    final db = await DatabaseHelper.instance.database;
    final map = {
      'nama': nama,
      'username': username,
      'telepon': telepon,
      'alamat': alamat,
      'password': password,
    };

    try {
      final id = await db.insert('user', map);
      user = UserModel(id: id, nama: nama, username: username, telepon: telepon, alamat: alamat, password: password);
      notifyListeners();
      return true;
    } catch (e) {
      // kemungkinan username duplicate
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    final db = await DatabaseHelper.instance.database;
    final res = await db.query('user', where: 'username = ? AND password = ?', whereArgs: [username, password], limit: 1);
    if (res.isNotEmpty) {
      user = UserModel.fromMap(res.first);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    user = null;
    notifyListeners();
  }

  Future<bool> updateUser({
    required int id,
    required String nama,
    required String username,
    required String telepon,
    required String alamat,
    String? password,
    String? avatarUrl,
  }) async {
    final db = await DatabaseHelper.instance.database;
    final map = {
      'nama': nama,
      'username': username,
      'telepon': telepon,
      'alamat': alamat,
    };
    if (password != null) map['password'] = password;
    if (avatarUrl != null) map['avatarUrl'] = avatarUrl;

    try {
      await db.update('user', map, where: 'id = ?', whereArgs: [id]);
      final res = await db.query('user', where: 'id = ?', whereArgs: [id], limit: 1);
      if (res.isNotEmpty) {
        user = UserModel.fromMap(res.first);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
