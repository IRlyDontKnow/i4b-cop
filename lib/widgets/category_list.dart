import 'package:flutter/material.dart';
import '../model/category.dart';
import './category_list_item.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel) onCategoryTap;

  const CategoryList({Key key, @required this.categories, this.onCategoryTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        final category = this.categories[index];

        return CategoryListItem(
          name: category.name,
          image: category.image,
          onTap: () {
            if (onCategoryTap != null) {
              onCategoryTap(category);
            }
          },
        );
      },
      itemCount: categories.length,
    );
  }
}
