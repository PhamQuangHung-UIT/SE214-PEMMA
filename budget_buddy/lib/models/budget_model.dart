class Budget {
  final String userid;
  final String categoryName;
  final String imagePath;
  final double budget;
  final double spentAmount;
  final bool isEveryMonth;

  Budget(
      {required this.userid,
      required this.categoryName,
      required this.imagePath,
      required this.budget,
      required this.spentAmount,
      required this.isEveryMonth});
}
