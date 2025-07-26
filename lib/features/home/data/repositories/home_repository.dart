class HomeRepository {
  final imageUrls = [
    'https://i.ytimg.com/vi/vXIek3627DY/maxresdefault.jpg',
    'https://5.imimg.com/data5/IJ/TD/MY-19422102/fish-aquarium-500x500.jpg',
    'https://thumbs.dreamstime.com/b/fish-aquarium-fish-sucker-plecostomus-small-beautiful-aquarium-108376595.jpg',
    'https://freshwateraquatica.org/cdn/shop/products/Screenshot_78.png?v=1693570790',
  ];
  final offerCarouselImages = [
    'https://i.ytimg.com/vi/vXIek3627DY/maxresdefault.jpg',
    'https://5.imimg.com/data5/IJ/TD/MY-19422102/fish-aquarium-500x500.jpg',
    'https://thumbs.dreamstime.com/b/fish-aquarium-fish-sucker-plecostomus-small-beautiful-aquarium-108376595.jpg',
    'https://freshwateraquatica.org/cdn/shop/products/Screenshot_78.png?v=1693570790',
  ];

  Future<List<String>> fetchImages() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return imageUrls;
  }

  Future<List<String>> fetchOfferCarouselImages() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return offerCarouselImages;
  }
}