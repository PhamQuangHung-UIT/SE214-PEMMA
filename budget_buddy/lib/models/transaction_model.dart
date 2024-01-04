class Transaction {
  final String userId;
  final String transactionId;
  final String? categoryId;
  final double amount;
  final String date;
  final String time;
  final String note;

  Transaction(
      {required this.userId,
      required this.transactionId,
      required this.categoryId,
      required this.amount,
      required this.date,
      required this.time,
      required this.note});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'transactionId': transactionId,
      'categoryId': categoryId,
      'amount': amount,
      'date': date,
      'time': time,
      'note': note,
    };
  }

  Transaction.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        transactionId = map['transactionId'],
        categoryId = map['categoryId'],
        amount = (map['amount'] ?? 0).toDouble(), // Chuyển đổi sang double
        date = map['date'],
        time = map['time'],
        note = map['note'];
}
