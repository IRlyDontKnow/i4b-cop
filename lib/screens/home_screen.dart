import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:i4b_cop/screens/account_screen.dart';
import '../screens/shopping_cart_screen.dart';
import '../services/cart_service.dart';
import '../model/product.dart';
import '../repositories/product_repository.dart';
import '../screens/category_screen.dart';
import '../screens/product_list_screen.dart';
import '../screens/product_screen.dart';
import '../widgets/category_list.dart';
import '../widgets/featured_product.dart';
import '../data.dart' as SampleData;

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  final ProductRepository productRepository;
  final CartService cartService;

  const HomeScreen({
    Key key,
    @required this.productRepository,
    @required this.cartService,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Car Parts',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'Shopping Cart',
            onPressed: () {
              Navigator.pushNamed(context, ShoppingCartScreen.routeName);
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, AccountScreen.routeName);
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Account',
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _FeaturedProducts(
                productRepository: widget.productRepository,
                cartService: widget.cartService,
              ),
              SizedBox(height: 16.0),
              Text(
                'Categories',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 10.0),
              CategoryList(
                categories: SampleData.categories,
                onCategoryTap: (category) {
                  if (category.hasChildren) {
                    Navigator.pushNamed(
                      context,
                      CategoryScreen.routeName,
                      arguments:
                          CategoryScreenArguments(category.id, category.name),
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      ProductListScreen.routeName,
                      arguments: ProductListScreenArguments(
                        category.id,
                        category.name,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedProducts extends StatelessWidget {
  final ProductRepository productRepository;
  final CartService cartService;

  const _FeaturedProducts({
    Key key,
    @required this.productRepository,
    @required this.cartService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured',
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 16.0),
          FutureBuilder(
            future: productRepository.getFeaturedProducts(),
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _buildList(snapshot.data);
              }

              return _buildLoading();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<ProductModel> products) {
    return Container(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final product = products[index];

          return FeaturedProduct(
            key: Key('home_featured_$index'),
            name: product.name,
            image: product.mainImage,
            price: product.price,
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductScreen.routeName,
                arguments: ProductScreenArguments(product.id),
              );
            },
            addToCart: () async {
              var cartItem = await cartService.addToCart(product.id, 1);

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
          );
        },
        itemCount: products.length,
        separatorBuilder: (_, index) {
          return SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}
