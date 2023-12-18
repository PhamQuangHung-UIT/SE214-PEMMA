import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addCategory(MyCategory newCategory) async {
    try {
      CollectionReference categoriesCollection = _firestore.collection('categories');
      await categoriesCollection.doc(newCategory.categoryID).set(newCategory.toMap());
      print("Added category successfully with id: ${newCategory.categoryID}");
    } catch (e) {
      print("Error adding category: $e");
    }
  }
  Stream<List<MyCategory>> fetchCategories(String userID) {
    try {
      return _firestore
          .collection('categories')
          .where('userID', isEqualTo: userID)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.map((doc) {
        return MyCategory.fromMap(doc.data() as Map<String, dynamic>);
      }).toList());
    } catch (e) {
      print("Error fetching goals: $e");
      return Stream.empty(); // Trả về Stream rỗng trong trường hợp lỗi
    }
  }
  void deleteCategory(MyCategory delCategory){
    try{
      _firestore.collection('categories').doc(delCategory.categoryID).delete().then(
              (doc) => print('Category deleted'));
    } catch (e) {
      print("Error updating category $e");
    }
  }
}