import 'package:flutter/material.dart';
import '../model/product_attribute.dart';

class ProductListItem extends StatelessWidget {
  final String name;
  final String articleNumber;
  final String mainImage;
  final double price;
  final List<ProductAttributeModel> attributes;
  final VoidCallback addToCart;

  const ProductListItem({
    Key key,
    @required this.name,
    @required this.articleNumber,
    @required this.mainImage,
    @required this.price,
    this.attributes,
    this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/${this.mainImage}',
            width: 75,
            height: 75,
          ),
          SizedBox(width: 12.0),
          _buildDetails(context),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Article number: ${this.articleNumber}',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            this.name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (attributes != null && attributes.isNotEmpty) ...[
            SizedBox(
              height: 8.0,
            ),
            Wrap(
              runSpacing: 4.0,
              spacing: 8.0,
              children: attributes
                  .getRange(0, 3)
                  .map((a) => _buildAttributeChip(a))
                  .toList(),
            ),
          ],
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$price \$',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart_rounded),
                iconSize: 32.0,
                color: Colors.blue,
                onPressed: () {
                  if (this.addToCart != null) {
                    this.addToCart();
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAttributeChip(ProductAttributeModel attribute) {
    return Container(
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Text('${attribute.value}'),
    );
  }
}
