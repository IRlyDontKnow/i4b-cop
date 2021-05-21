import 'package:flutter/material.dart';
import '../model/cart.dart';
import '../repositories/cart_repository.dart';
import '../widgets/cart_item.dart';

class ShoppingCartScreen extends StatefulWidget {
  static const String routeName = '/shopping-cart';

  final CartRepository cartRepository;

  const ShoppingCartScreen({
    Key key,
    @required this.cartRepository,
  }) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  String futureBuilderKey = "initial";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping cart')),
      body: FutureBuilder<List<CartItemModel>>(
        future: widget.cartRepository.getAllItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final cartItems = snapshot.data;

            return cartItems.isNotEmpty
                ? _buildItemsList(context, cartItems)
                : _buildEmpty();
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, List<CartItemModel> cartItems) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (_, index) {
        final cartItem = cartItems[index];

        return CartItem(
          productImage: cartItem.productImage,
          productName: cartItem.productName,
          quantity: cartItem.quantity,
          price: cartItem.price,
          onDelete: () async {
            await widget.cartRepository.removeItem(cartItem.id);

            setState(() {});

            Scaffold.of(context).showSnackBar(SnackBar(
              content: const Text(
                'Cart item removed.',
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
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text(
        'Cart is empty.',
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
