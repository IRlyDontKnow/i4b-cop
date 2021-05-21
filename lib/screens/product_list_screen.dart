import 'package:flutter/material.dart';
import '../model/product.dart';
import '../screens/product_screen.dart';
import '../services/cart_service.dart';
import '../widgets/product_list_item.dart';
import '../repositories/product_repository.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = '/products';

  final ProductRepository productRepository;
  final CartService cartService;
  final String categoryId;
  final String categoryName;

  const ProductListScreen({
    Key key,
    @required this.productRepository,
    @required this.categoryId,
    @required this.categoryName,
    @required this.cartService,
  }) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class ProductListScreenArguments {
  final String categoryId;
  final String categoryName;

  ProductListScreenArguments(this.categoryId, this.categoryName);
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future:
            widget.productRepository.getProductsByCategoryId(widget.categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return _buildEmpty();
            }

            return _buildProductList(context, snapshot.data);
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildProductList(BuildContext context, List<ProductModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, index) {
        var product = products[index];

        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductScreen.routeName,
              arguments: ProductScreenArguments(product.id),
            );
          },
          child: ProductListItem(
            name: product.name,
            articleNumber: product.articleNumber,
            mainImage: product.mainImage,
            price: product.price,
            attributes: product.attributes ?? [],
            addToCart: () async {
              var cartItem = await widget.cartService.addToCart(product.id, 1);

              if (cartItem == null) {
                return;
              }

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Product "${cartItem.productName}" added to cart',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.green,
              ));
            },
          ),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text(
        'This category is empty.',
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
