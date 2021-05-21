import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const CategoryListItem({
    Key key,
    @required this.name,
    this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    if (this.image != null && this.image.isNotEmpty) {
      children = [
        ...children,
        Image.asset(
          'assets/${this.image}',
          width: 75,
          height: 75,
        ),
        SizedBox(width: 24.0),
      ];
    }

    children = [
      ...children,
      Text(
        this.name,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ];

    return Card(
      elevation: 2,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: children),
        ),
        onTap: this.onTap,
      ),
    );
  }
}
