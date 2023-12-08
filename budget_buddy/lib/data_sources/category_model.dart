class Category{
  late final String categoryID;
  final String userID;
  final String cName;
  final String cImagePath;
  final String isIncome;
  Category(this.userID, this.cName, this.cImagePath, this.isIncome){
    categoryID = generateUniqueCID();
  }
  String generateUniqueCID(){
    String cID = "test";
    return cID;
  }
}