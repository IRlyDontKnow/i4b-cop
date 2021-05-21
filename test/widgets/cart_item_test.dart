import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i4b_cop/widgets/cart_item.dart';

void main() {
  testWidgets(
    'Cart item has name, price, quantity and image',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CartItem(
              productName: 'BrakePads',
              productImage:
                  'products/brake-system/be96928a-7c54-41f9-b45f-cacaf1be84ea_1.jpg',
              quantity: 5,
              price: 10.99,
            ),
          ),
        ),
      );

      final productNameFinder = find.text('BrakePads');
      final priceFinder = find.text('10.99\$');
      final imageFinder = find.byWidgetPredicate((widget) =>
          widget is Image && widget.height == 75.0 && widget.width == 75.0);
      final quantityFinder = find.text('Quantity: 5');

      expect(productNameFinder, findsOneWidget);
      expect(priceFinder, findsOneWidget);
      expect(imageFinder, findsOneWidget);
      expect(quantityFinder, findsOneWidget);
    },
  );
}
