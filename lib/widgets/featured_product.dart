import 'package:flutter/material.dart';

class FeaturedProduct extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final VoidCallback onTap;
  final VoidCallback addToCart;

  const FeaturedProduct({
    Key key,
    @required this.name,
    @required this.image,
    @required this.price,
    this.onTap,
    this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        elevation: 1,
        child: InkWell(
          onTap: () {
            if (this.onTap != null) {
              this.onTap();
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/${this.image}',
                  width: 75,
                  height: 75,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  this.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '${price.toString()} \$',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                RaisedButton(
                  child: Text('Add to cart'),
                  onPressed: () {
                    if (this.addToCart != null) {
                      this.addToCart();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
