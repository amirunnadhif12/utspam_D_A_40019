import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/transaksi_model.dart';

class TransaksiController extends ChangeNotifier {
  List<TransaksiModel> _list = [];
  List<TransaksiModel> get list => _list;

  TransaksiController() {
    loadAll();
  }

  Future<void> loadAll() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('transaksi', orderBy: 'id DESC');
    _list = rows.map((r) => TransaksiModel.fromMap(r)).toList();
    notifyListeners();
  }

  Future<void> addTransaksi(TransaksiModel t) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert('transaksi', t.toMap());
    t.id = id;
    _list.insert(0, t);
    notifyListeners();
  }

  Future<void> updateTransaksi(TransaksiModel t) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('transaksi', t.toMap(), where: 'id = ?', whereArgs: [t.id]);
    final idx = _list.indexWhere((e) => e.id == t.id);
    if (idx >= 0) _list[idx] = t;
    notifyListeners();
  }

  Future<void> deleteTransaksi(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('transaksi', where: 'id = ?', whereArgs: [id]);
    _list.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
