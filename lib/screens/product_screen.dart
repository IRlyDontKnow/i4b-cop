import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/product_attributes.dart';
import '../model/product.dart';
import '../repositories/product_repository.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/product';

  final ProductRepository productRepository;
  final String productId;

  const ProductScreen({
    Key key,
    @required this.productRepository,
    @required this.productId,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class ProductScreenArguments {
  final String productId;

  ProductScreenArguments(this.productId);
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _amountController =
      TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.productRepository.getProductById(widget.productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final product = snapshot.data as ProductModel;

          return Scaffold(
            key: Key('product_details_screen'),
            appBar: AppBar(
              title: Text(
                product.name,
              ),
            ),
            bottomNavigationBar: _buildNavigationBar(context),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildGallery(product.images),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _buildDetails(product),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[350],
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            elevation: 0,
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Add to cart'),
            onPressed: () {
              print('Add to cart');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGallery(List<String> images) {
    return Container(
        height: 250,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 250,
            enableInfiniteScroll: true,
          ),
          items: images.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image.asset(
                    'assets/$imagePath',
                  ),
                );
              },
            );
          }).toList(),
        ));
  }

  Widget _buildDetails(ProductModel product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.name,
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          '${product.price} \$',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.0),
        ProductAttributes(attributes: product.attributes ?? []),
      ],
    );
  }
}
