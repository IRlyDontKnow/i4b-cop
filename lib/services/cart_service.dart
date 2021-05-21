import 'package:uuid/uuid.dart';
import '../model/cart.dart';
import '../repositories/cart_repository.dart';
import '../repositories/product_repository.dart';

class CartService {
  final ProductRepository productRepository;
  final CartRepository cartRepository;

  CartService(this.productRepository, this.cartRepository);

  Future<CartItemModel> addToCart(String productId, int quantity) async {
    var product = await productRepository.getProductById(productId);

    if (product == null) {
      return null;
    }

    var cartItem = await cartRepository.getByProductId(product.id);

    if (cartItem != null) {
      cartItem.incrementQuantity();

      await cartRepository.updateItem(cartItem);

      return cartItem;
    } else {
      cartItem = CartItemModel(
        id: Uuid().v4(),
        productId: product.id,
        productName: product.name,
        productImage: product.mainImage,
        price: product.price,
        quantity: quantity,
      );

      await cartRepository.addItem(cartItem);
    }

    return cartItem;
  }
}
