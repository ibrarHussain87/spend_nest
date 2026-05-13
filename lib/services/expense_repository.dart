import "package:cloud_firestore/cloud_firestore.dart";

import "../models/expense.dart";

class ExpenseRepository {
  ExpenseRepository(this._userId);

  final String _userId;

  String get userId => _userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection("expenses");

  Stream<List<Expense>> watchExpenses() {
    return _col.where("userId", isEqualTo: _userId).snapshots().map((snap) {
      final list = snap.docs.map(Expense.fromDoc).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      return list;
    });
  }

  Future<void> add(Expense expense) async {
    await _col.add(expense.toFirestore());
  }

  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
