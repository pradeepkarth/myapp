import 'package:myapp/features/catalog/domain/models/product.dart';

class CatalogRepository {
  List<Product> getDummyProducts() {
    return [
      Product(
        id: 'prod_black_telescope_eye_goldfish',
        name: 'Black Telescope Eye Goldfish',
        tags: ['goldfish', 'freshwater', 'community'],
        category: 'Live Fish',
        status: 'active',
        variants: [
          ProductVariant(
            id: 'var_small',
            label: 'Small - 3 in',
            costPrice: 10,
            sellingPrice: 20,
            stock: 12,
            status: 'in_stock',
          ),
          ProductVariant(
            id: 'var_medium',
            label: 'Medium - 5 in',
            costPrice: 30,
            sellingPrice: 60,
            stock: 0,
            status: 'out_of_stock',
          ),
          ProductVariant(
            id: 'var_large',
            label: 'Large - 7 in',
            costPrice: 50,
            sellingPrice: 80,
            stock: 5,
            status: 'in_stock',
          ),
        ],
        imageUrl: 'https://coburgaquarium.com.au/cdn/shop/products/BlackMooreGoldfish-Copy_f4775228-e4f0-4c0d-8cac-fa5b59b72d73.jpg?v=1675995719',
        createdAt: DateTime.parse('2025-08-09T06:00:00Z'),
        updatedAt: DateTime.parse('2025-08-16T06:00:00Z'),
      ),
    ];
  }
}