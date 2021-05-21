class CategoryModel {
  final String id;
  final String name;
  final String image;
  List<CategoryModel> children = List.empty();

  CategoryModel(this.id, this.name, {this.children, this.image});

  bool get hasChildren {
    return children != null && children.isNotEmpty;
  }
}
