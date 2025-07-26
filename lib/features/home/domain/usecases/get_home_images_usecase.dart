import 'package:myapp/features/home/data/repositories/home_repository.dart';

class GetHomeImagesUseCase {
  final HomeRepository _homeRepository;

  GetHomeImagesUseCase(this._homeRepository);

  Future<List<String>> execute() async {
    return _homeRepository.fetchImages();
  }
}

class GetOfferCarouselItemsUseCase {
  final HomeRepository _homeRepository;

  GetOfferCarouselItemsUseCase(this._homeRepository);

  Future<List<CarouselItem>> execute() async {
    return _homeRepository.fetchOfferCarouselItems();
  }
}