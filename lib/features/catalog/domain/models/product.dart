class ProductVariant {
  final String id;
  final String label;
  final double costPrice;
  final double sellingPrice;
  final int stock;
  final String status;

  ProductVariant({
    required this.id,
    required this.label,
    required this.costPrice,
    required this.sellingPrice,
    required this.stock,
    required this.status,
  });
}

class Product {
  final String id;
  final String name;
  final List<String> tags;
  final String category;
  final String status;
  final List<ProductVariant> variants;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.tags,
    required this.category,
    required this.status,
    required this.variants,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}