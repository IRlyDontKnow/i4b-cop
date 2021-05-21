import '../model/product.dart';
import '../data.dart' as SampleData;

abstract class ProductRepository {
  Future<ProductModel> getProductById(String productId);
  Future<List<ProductModel>> getProductsByCategoryId(String categoryId);
  Future<List<ProductModel>> getFeaturedProducts();
}

class InMemoryProductRepository implements ProductRepository {
  @override
  Future<ProductModel> getProductById(String productId) async {
    var product =
        SampleData.products.firstWhere((product) => product.id == productId);

    await Future.delayed(Duration(seconds: 1));

    return product;
  }

  Future<List<ProductModel>> getProductsByCategoryId(String categoryId) async {
    var products = SampleData.products
        .where((product) => product.categoryId == categoryId)
        .toList();

    await Future.delayed(Duration(seconds: 1));

    return products;
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    await Future.delayed(Duration(seconds: 1));

    return SampleData.products.where((product) => product.featured).toList();
  }
}
