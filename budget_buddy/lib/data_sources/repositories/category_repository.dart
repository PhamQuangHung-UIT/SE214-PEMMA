import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addCategory(MyCategory newCategory) async {
    try {
      CollectionReference categoriesCollection =
          _firestore.collection('categories');
      await categoriesCollection
          .doc(newCategory.categoryID)
          .set(newCategory.toMap());
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

  Future<void> deleteCategory(String? categoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .delete();
      print('Category deleted successfully');
    } catch (error) {
      print('Error deleting category: $error');
      throw 'Error deleting category: $error';
    }
  }

  Future<void> fetchCategoryData(String userId, String? categoryId,
      Function(String, String) onDataFetched, Function(String) onError) async {
    try {
      FirebaseFirestore.instance
          .collection("categories")
          .where("userID", isEqualTo: userId)
          .where("categoryID", isEqualTo: categoryId)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          String cName = querySnapshot.docs[0]['cName'];
          String cImagePath = querySnapshot.docs[0]['cImagePath'];
          onDataFetched(cName, cImagePath);
        } else {
          onError("Document not found!");
        }
      }, onError: (error) {
        onError("Error: $error");
      });
    } catch (error) {
      onError("Error: $error");
    }
  }

  Future<void> fetchCategoryType(String userId, String? categoryId,
      Function(bool) onDataFetched, Function(String) onError) async {
    try {
      FirebaseFirestore.instance
          .collection("categories")
          .where("userID", isEqualTo: userId)
          .where("categoryID", isEqualTo: categoryId)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          bool isIncome = querySnapshot.docs[0]['isIncome'];
          onDataFetched(isIncome);
        } else {
          onError("Document not found!");
        }
      }, onError: (error) {
        onError("Error: $error");
      });
    } catch (error) {
      onError("Error: $error");
    }
  }
}
