import './repositories/cart_repository.dart';
import './repositories/category_repository.dart';
import './repositories/product_repository.dart';
import './services/cart_service.dart';

final ProductRepository productRepository = InMemoryProductRepository();
final CategoryRepository categoryRepository = InMemoryCategoryRepository();
final CartRepository cartRepository = SqliteCartRepository();
final CartService cartService = CartService(productRepository, cartRepository);
