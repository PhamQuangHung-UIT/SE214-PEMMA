class User {
  String? userId;
  String fullname;
  double balance;
  String currency;

  User(
      {required this.userId,
      required this.fullname,
      this.balance = 0,
      this.currency = 'usd'});

  User.onlyNameAndBalance(
      {required this.userId,
      required this.fullname,
      required this.balance,
      this.currency = 'usd'});

  @override
  String toString() => 'User: $userId'
      '\n+ fullname: $fullname'
      '\n+ balance: $balance'
      '\n+ currency: $currency';

  Map<String, dynamic> toMap() => {
        'fullname': fullname,
        'balance': balance,
        'currency': currency,
      };
}
