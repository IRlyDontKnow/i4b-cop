import 'package:flutter/material.dart';
import '../model/category.dart';
import '../repositories/category_repository.dart';
import '../screens/product_list_screen.dart';
import '../widgets/category_list_item.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';

  final CategoryRepository categoryRepository;
  final String categoryId;
  final String categoryName;

  const CategoryScreen({
    Key key,
    @required this.categoryRepository,
    @required this.categoryId,
    @required this.categoryName,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class CategoryScreenArguments {
  final String categoryId;
  final String categoryName;

  CategoryScreenArguments(this.categoryId, this.categoryName);
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder<List<CategoryModel>>(
          future: widget.categoryRepository
              .getCategoriesByParentId(widget.categoryId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildList(snapshot.data);
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
          initialData: [],
        ),
      ),
    );
  }

  Widget _buildList(List<CategoryModel> categories) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var category = categories[index];

        return CategoryListItem(
          name: category.name,
          image: category.image,
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductListScreen.routeName,
              arguments: ProductListScreenArguments(
                category.id,
                category.name,
              ),
            );
          },
        );
      },
      itemCount: categories.length,
    );
  }
}
