import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/product_attribute.dart';

class ProductAttributes extends StatelessWidget {
  final List<ProductAttributeModel> attributes;

  const ProductAttributes({Key key, @required this.attributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (attributes.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Item details',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 12.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: attributes.length,
            itemBuilder: (context, index) {
              var attribute = attributes[index];

              return Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                color: index.isEven ? Colors.grey[300] : Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      attribute.label,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      attribute.value,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
