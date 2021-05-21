import './model/category.dart';
import './model/product_attribute.dart';
import './model/product.dart';

final List<CategoryModel> categories = [
  CategoryModel(
    'brake-system',
    'Brake System',
    image: 'categories/brake-system.png',
    children: [
      CategoryModel('brake-system/brake-discs', 'Brake Discs',
          image: 'categories/brake-discs.png'),
      CategoryModel('brake-system/brake-pads', 'Brake Pads',
          image: 'categories/brake-pads.png'),
    ],
  ),
  CategoryModel('engine', 'Engine', image: 'categories/engine.png'),
  CategoryModel('electrics', 'Electrics', image: 'categories/electrics.png'),
  CategoryModel('body', 'Body', image: 'categories/body.png'),
  CategoryModel('exhaust-system', 'Exhaust System',
      image: 'categories/exhaust-system.png'),
  CategoryModel('clutch-and-parts', 'Clutch & Parts',
      image: 'categories/clutch-and-parts.png'),
  CategoryModel('transmission', 'Transmission',
      image: 'categories/transmission.png'),
  CategoryModel('tuning', 'Tuning', image: 'categories/tuning.png'),
];

final List<ProductModel> products = [
  // https://www.autodoc.co.uk/ridex/7998901
  ProductModel(
    id: '7998901',
    categoryId: 'brake-system/brake-discs',
    name: 'RIDEX Brake Disc',
    articleNumber: '82B0003',
    featured: true,
    price: 10.29,
    stock: 17,
    mainImage:
        'products/brake-system/be96928a-7c54-41f9-b45f-cacaf1be84ea_2.png',
    attributes: <ProductAttributeModel>[
      ProductAttributeModel('Fitting Position', 'Rear axle'),
      ProductAttributeModel('Diameter [mm]', '230,0'),
      ProductAttributeModel('Brake Disc Type', 'Solid'),
      ProductAttributeModel('Centering Diameter [mm]', '65.0'),
      ProductAttributeModel('Number of Holes', '5'),
      ProductAttributeModel('Bolt Hole Circle Ø [mm]', '100'),
    ],
    images: <String>[
      'products/brake-system/be96928a-7c54-41f9-b45f-cacaf1be84ea_1.jpg',
      'products/brake-system/be96928a-7c54-41f9-b45f-cacaf1be84ea_2.png',
      'products/brake-system/be96928a-7c54-41f9-b45f-cacaf1be84ea_3.png',
    ],
  ),

  /** Engine */
  // https://www.autodoc.co.uk/ajusa/7249291
  ProductModel(
    id: '7249291',
    categoryId: 'engine',
    name: 'AJUSA Gasket Set',
    articleNumber: '52140000',
    featured: true,
    price: 103.94,
    stock: 8,
    mainImage: 'products/engine/7249291_1.jpg',
    attributes: <ProductAttributeModel>[],
    images: <String>[
      'products/engine/7249291_1.jpg',
    ],
  ),
  // https://www.autodoc.co.uk/bosch/1150389
  ProductModel(
    id: '1150389',
    categoryId: 'engine',
    name: 'BOSH Injector 630cc',
    articleNumber: '0 280 156 061',
    featured: true,
    price: 48.54,
    stock: 73,
    mainImage: 'products/engine/1150389_1.jpg',
    attributes: <ProductAttributeModel>[],
    images: <String>[
      'products/engine/1150389_1.jpg',
      'products/engine/1150389_2.jpg',
      'products/engine/1150389_3.jpg',
    ],
  ),
];
