class CarouselItem {
  final String imageUrl;
  final String title;
  final String description;

  CarouselItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

class HomeRepository {
  final List<String> imageUrls = [
    'https://i.ytimg.com/vi/vXIek3627DY/maxresdefault.jpg',
    'https://5.imimg.com/data5/IJ/TD/MY-19422102/fish-aquarium-500x500.jpg',
    'https://thumbs.dreamstime.com/b/fish-aquarium-fish-sucker-plecostomus-small-beautiful-aquarium-108376595.jpg',
    'https://freshwateraquatica.org/cdn/shop/products/Screenshot_78.png?v=1693570790',
  ];

  final List<CarouselItem> offerCarouselItems = [
    CarouselItem(
      imageUrl: 'https://i.ytimg.com/vi/vXIek3627DY/maxresdefault.jpg',
      title: 'Discover Rare Fish',
      description: 'Explore a variety of exotic fish species.',
    ),
    CarouselItem(
      imageUrl: 'https://5.imimg.com/data5/IJ/TD/MY-19422102/fish-aquarium-500x500.jpg',
      title: 'Aquarium Essentials',
      description: 'Find everything you need for a thriving aquarium.',
    ),
    CarouselItem(
      imageUrl: 'https://thumbs.dreamstime.com/b/fish-aquarium-fish-sucker-plecostomus-small-beautiful-aquarium-108376595.jpg',
      title: 'Expert Care Tips',
      description: 'Learn how to keep your fish healthy and happy.',
    ),
    CarouselItem(
      imageUrl: 'https://freshwateraquatica.org/cdn/shop/products/Screenshot_78.png?v=1693570790',
      title: 'Special Offers',
      description: 'Don\'t miss out on our limited-time deals!',
    ),
  ];

  Future<List<String>> fetchImages() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return imageUrls;
  }

  Future<List<CarouselItem>> fetchOfferCarouselItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return offerCarouselItems;
  }
}