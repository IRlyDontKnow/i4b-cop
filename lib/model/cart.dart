import 'package:flutter/material.dart';

class CartModel {
  List<CartItemModel> items = List.empty();

  CartModel({
    @required this.items,
  }) : assert(items.isNotEmpty);
}

class CartItemModel {
  String id;
  String productName;
  String productId;
  String productImage;
  int quantity;
  double price;

  CartItemModel({
    @required this.id,
    @required this.productName,
    @required this.productId,
    @required this.productImage,
    @required this.quantity,
    @required this.price,
  });

  void incrementQuantity() {
    quantity += 1;
  }
}
