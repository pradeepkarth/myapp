import 'package:flutter/material.dart';
import 'package:myapp/features/catalog/domain/models/product.dart';
import 'package:myapp/features/catalog/data/repositories/catalog_repository.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
      ),
      body: _CatalogGridView(),
    );
  }
}

class _CatalogGridView extends StatefulWidget {
  @override
  __CatalogGridViewState createState() => __CatalogGridViewState();
}

class __CatalogGridViewState extends State<_CatalogGridView> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = CatalogRepository().getDummyProducts();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2; // Default for smaller screens

    if (screenWidth >= 600 && screenWidth < 1200) {
      crossAxisCount = 3;
    } else if (screenWidth >= 1200) {
      crossAxisCount = 4;
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Number of columns based on screen width
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7, // Adjust as needed for card height
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Image.network(product.imageUrl, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('\$${product.price.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}