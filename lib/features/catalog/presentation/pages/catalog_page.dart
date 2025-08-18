import 'package:flutter/material.dart';
import 'package:myapp/features/catalog/domain/models/product.dart';
import 'package:myapp/features/catalog/data/repositories/catalog_repository.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: _CatalogGridView(),
      backgroundColor: theme.colorScheme.background,
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth >= 600 && screenWidth < 1200) {
      crossAxisCount = 3;
    } else if (screenWidth >= 1200) {
      crossAxisCount = 4;
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductCard(product: product);
      },
    );
  }
}

class _ProductCard extends StatefulWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  late ProductVariant selectedVariant;

  @override
  void initState() {
    super.initState();
    selectedVariant = widget.product.variants.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final product = widget.product;
    final inStock = selectedVariant.status == 'in_stock';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: theme.dividerColor,
                        child: Icon(Icons.image, size: 48, color: theme.iconTheme.color),
                      ),
                    ),
                  ),
                  Center(
                    child: DropdownButton<ProductVariant>(
                      value: selectedVariant,
                      alignment: Alignment.center,
                      icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
                      underline: SizedBox.shrink(),
                      padding: EdgeInsets.zero,
                      focusColor: Colors.transparent,
                      isExpanded: false,
                      items: product.variants.map((variant) {
                        return DropdownMenuItem<ProductVariant>(
                          value: variant,
                          child: Text(
                            variant.label,
                            style: theme.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      onChanged: (variant) {
                        if (variant != null) {
                          setState(() {
                            selectedVariant = variant;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: inStock ? () {} : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: inStock ? colorScheme.primary : colorScheme.surfaceVariant,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.add,
                        color: inStock ? colorScheme.onPrimary : colorScheme.onSurface.withOpacity(0.5),
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: _ProductDetails(
            product: product,
            variant: selectedVariant,
          ),
        ),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;
  final ProductVariant variant;
  const _ProductDetails({required this.product, required this.variant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final inStock = variant.status == 'in_stock';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text(product.category,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            )),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: -8,
          children: product.tags
              .map((tag) => Chip(
                    label: Text(tag, style: theme.textTheme.labelSmall),
                    backgroundColor: colorScheme.primary.withOpacity(0.08),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        Text(
          inStock ? 'In Stock (${variant.stock})' : 'Out of Stock',
          style: theme.textTheme.labelSmall?.copyWith(
            color: inStock ? colorScheme.primary : colorScheme.error,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Price: ₹${variant.sellingPrice.toStringAsFixed(2)}',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: inStock ? colorScheme.primary : colorScheme.error,
          ),
        ),
      ],
    );
  }
}
