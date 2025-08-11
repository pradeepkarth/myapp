import 'package:myapp/features/catalog/domain/models/product.dart';

class CatalogRepository {
  List<Product> getDummyProducts() {
    return [
      Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 1',
        price: 19.99,
      ),
      Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 2',
        price: 29.99,
      ),
      Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 3',
        price: 39.99,
      ),
      Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 4',
        price: 49.99,
      ),
      Product(
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 5',
        price: 59.99,
      ),
    ];
  }
}