import 'package:myapp/features/home/data/repositories/home_repository.dart';

class GetHomeImagesUseCase {
  final HomeRepository _homeRepository;

  GetHomeImagesUseCase(this._homeRepository);

  Future<List<String>> execute() async {
    return _homeRepository.fetchImages();
  }
}

class GetOfferCarouselImagesUseCase {
  final HomeRepository _homeRepository;

  GetOfferCarouselImagesUseCase(this._homeRepository);

  Future<List<String>> execute() async {
    return _homeRepository.fetchOfferCarouselImages();
  }
}