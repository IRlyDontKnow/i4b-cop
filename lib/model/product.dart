import 'package:flutter/material.dart';
import '../model/product_attribute.dart';

class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final String articleNumber;
  final double price;
  final int stock;
  final bool featured;
  final String mainImage;
  List<ProductAttributeModel> attributes = List.empty();
  List<String> images = List.empty();

  ProductModel({
    @required this.id,
    @required this.name,
    @required this.categoryId,
    @required this.articleNumber,
    this.price = 0,
    this.stock = 0,
    this.featured = false,
    this.mainImage,
    this.images,
    this.attributes,
  });
}
