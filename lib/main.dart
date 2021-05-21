import 'package:flutter/material.dart';
import 'package:i4b_cop/screens/account_screen.dart';
import './screens/shopping_cart_screen.dart';
import './sqlite.dart';
import './screens/category_screen.dart';
import './screens/home_screen.dart';
import './screens/product_list_screen.dart';
import './screens/product_screen.dart';
import './container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SqliteDb();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I4B Car Parts',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) {
          return HomeScreen(
            productRepository: di.productRepository,
            cartService: di.cartService,
          );
        },
        CategoryScreen.routeName: (context) {
          final args = ModalRoute.of(context).settings.arguments
              as CategoryScreenArguments;

          return CategoryScreen(
            categoryRepository: di.categoryRepository,
            categoryId: args.categoryId,
            categoryName: args.categoryName,
          );
        },
        ProductListScreen.routeName: (context) {
          final args = ModalRoute.of(context).settings.arguments
              as ProductListScreenArguments;

          return ProductListScreen(
            productRepository: di.productRepository,
            cartService: di.cartService,
            categoryId: args.categoryId,
            categoryName: args.categoryName,
          );
        },
        ProductScreen.routeName: (context) {
          final args = ModalRoute.of(context).settings.arguments
              as ProductScreenArguments;

          return ProductScreen(
            productRepository: di.productRepository,
            productId: args.productId,
          );
        },
        ShoppingCartScreen.routeName: (context) => ShoppingCartScreen(
              cartRepository: di.cartRepository,
            ),
        AccountScreen.routeName: (context) => AccountScreen(),
      },
    );
  }
}
