import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/data_sources/repositories/category_repository.dart';

class CategoryPresenter {
  final CategoryRepository _repository = CategoryRepository();
  void fetchCategories(
      String userID,
      Function(List<MyCategory>) onCategoriesFetched,
      Function(String) onError) {
    _repository.fetchCategories(userID).listen((categories) {
      onCategoriesFetched(categories);
    }, onError: (error) {
      onError("Error fetching categories: $error");
    });
  }

  Future<void> addCategories(MyCategory newCategory, Function() onCategoryAdded,
      Function(String) onError) async {
    try {
      await _repository.addCategory(newCategory);
      onCategoryAdded();
    } catch (e) {
      onError("Error adding category: $e");
    }
  }

  void fetchCategoryData(String userId, String? categoryId,
      Function(String, String) onDataFetched, Function(String) onError) {
    _repository.fetchCategoryData(userId, categoryId, onDataFetched, onError);
  }

  void fetchCategoryType(String userId, String? categoryId,
      Function(bool) onDataFetched, Function(String) onError) {
    _repository.fetchCategoryType(userId, categoryId, onDataFetched, onError);
  }

  Future<void> deleteCategory(String? categoryId, Function() onDeleteSuccess,
      Function(String) onError) async {
    try {
      await _repository.deleteCategory(categoryId);
      onDeleteSuccess();
    } catch (error) {
      onError('Error deleting category: $error');
    }
  }
}
