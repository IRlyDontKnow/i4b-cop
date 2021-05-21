import '../sqlite.dart';
import '../model/cart.dart';

abstract class CartRepository {
  Future addItem(CartItemModel item);
  Future removeItem(String itemId);
  Future updateItem(CartItemModel item);
  Future<CartItemModel> getByProductId(String itemId);
  Future<List<CartItemModel>> getAllItems();
}

class SqliteCartRepository implements CartRepository {
  @override
  Future addItem(CartItemModel item) async {
    final database = await SqliteDb.instance.database;

    await database.insert('cart_items', <String, dynamic>{
      "id": item.id,
      "product_name": item.productName,
      "product_id": item.productId,
      "product_image": item.productImage,
      "quantity": item.quantity,
      "price": (item.price * 100).toInt(),
    });
  }

  Future updateItem(CartItemModel item) async {
    final database = await SqliteDb.instance.database;

    await database.update(
      'cart_items',
      <String, dynamic>{
        "id": item.id,
        "product_name": item.productName,
        "product_id": item.productId,
        "product_image": item.productImage,
        "quantity": item.quantity,
        "price": (item.price * 100).toInt(),
      },
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<List<CartItemModel>> getAllItems() async {
    final database = await SqliteDb.instance.database;

    final results = await database.query('cart_items');

    return List.generate(results.length, (i) {
      return _createCartItemModel(results[i]);
    });
  }

  Future<CartItemModel> getByProductId(String productId) async {
    final database = await SqliteDb.instance.database;

    var results = await database.query(
      'cart_items',
      where: 'product_id = ?',
      whereArgs: [productId],
      limit: 1,
    );

    if (results.length == 0) {
      return null;
    }

    return _createCartItemModel(results.first);
  }

  Future removeItem(String itemId) async {
    final database = await SqliteDb.instance.database;

    await database.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [itemId],
    );
  }

  CartItemModel _createCartItemModel(Map<String, dynamic> row) {
    return CartItemModel(
      id: row['id'],
      productId: row['product_id'],
      productName: row['product_name'],
      productImage: row['product_image'],
      price: (row['price'] / 100),
      quantity: row['quantity'],
    );
  }
}
