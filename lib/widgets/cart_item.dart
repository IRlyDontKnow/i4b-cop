import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final VoidCallback onDelete;

  const CartItem({
    Key key,
    @required this.productName,
    @required this.productImage,
    @required this.price,
    @required this.quantity,
    this.onDelete,
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
            'assets/${this.productImage}',
            width: 75,
            height: 75,
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${this.price}\$',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Quantity: ${this.quantity}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                if (this.onDelete != null) {
                  this.onDelete();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
