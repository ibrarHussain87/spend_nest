import "package:cloud_firestore/cloud_firestore.dart";

class Expense {
  const Expense({
    this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  final String? id;
  final String userId;
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      "title": title,
      "amount": amount,
      "category": category,
      "date": Timestamp.fromDate(date),
    };
  }

  static Expense fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return Expense(
      id: doc.id,
      userId: d["userId"] as String? ?? "",
      title: d["title"] as String? ?? "",
      amount: (d["amount"] as num?)?.toDouble() ?? 0,
      category: d["category"] as String? ?? "Other",
      date: (d["date"] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
