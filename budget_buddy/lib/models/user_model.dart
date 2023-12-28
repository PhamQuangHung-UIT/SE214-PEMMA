import 'package:firebase_auth/firebase_auth.dart' as firebase;

class User {
  String? userId;
  String fullname;
  num balance;
  String currency;
  firebase.User? firebaseUser;

  User(
      {required this.userId,
      required this.fullname,
      this.balance = 0,
      this.currency = 'USD',
      this.firebaseUser});

  factory User.fromMap(Map<String, dynamic> map) => User(
      userId: map['userId'],
      fullname: map['fullname'],
      balance: map['balance'],
      currency: map['currency']);

  @override
  String toString() => 'User: $userId'
      '\n+ fullname: $fullname'
      '\n+ balance: $balance'
      '\n+ currency: $currency';

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'fullname': fullname,
        'balance': balance,
        'currency': currency,
      };
}
