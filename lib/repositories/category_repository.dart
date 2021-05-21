import '../model/category.dart';
import '../data.dart' as SampleData;

abstract class CategoryRepository {
  Future<List<CategoryModel>> getRootCategories();
  Future<List<CategoryModel>> getCategoriesByParentId(String parentId);
}

class InMemoryCategoryRepository implements CategoryRepository {
  @override
  Future<List<CategoryModel>> getRootCategories() async {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getCategoriesByParentId(String parentId) async {
    var parentCategory =
        SampleData.categories.firstWhere((c) => c.id == parentId);

    if (parentCategory == null) {
      return List.empty();
    }

    return parentCategory.children ?? [];
  }
}
