import 'package:cloud_firestore/cloud_firestore.dart';

class MyCategory{
  final String? categoryID;
  final String userID;
  final String cName;
  final String cImagePath;
  final bool isIncome;
  MyCategory({this.categoryID,required this.userID, required this.cName, required this.cImagePath, required this.isIncome});
  Map<String, dynamic> toMap() {
    return {
      'categoryID': categoryID,
      'userID': userID,
      'cName': cName,
      'cImagePath': cImagePath,
      'isIncome': isIncome
    };
  }
  MyCategory.fromMap(Map<String, dynamic> map)
      : categoryID = map['categoryID'],
        userID = map['userID'],
        cName = map['cName'],
        cImagePath = map['cImagePath'],
        isIncome = map['isIncome'];

  factory MyCategory.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return MyCategory(
        categoryID : document.id,
        userID : data['userID'],
        cName : data['cName'],
        cImagePath : data['cImagePath'],
        isIncome : data['isIncome'],
    );
  }
}