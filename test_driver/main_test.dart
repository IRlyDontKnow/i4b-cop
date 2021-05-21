import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Home screen featured products', () {
    final firstFeaturedFinder = find.byValueKey('home_featured_0');
    final productScreenFinder = find.byValueKey('product_details_screen');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Opens product details when tapped on featured product', () async {
      await Future.delayed(Duration(seconds: 2));

      await driver.tap(firstFeaturedFinder);

      await Future.delayed(Duration(seconds: 2));

      final isProductScreenPresent = await isPresent(
          productScreenFinder, driver,
          timeout: Duration(seconds: 3));

      expect(isProductScreenPresent, true);
    });
  });
}

isPresent(SerializableFinder byValueKey, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(byValueKey, timeout: timeout);
    return true;
  } catch (exception) {
    return false;
  }
}
