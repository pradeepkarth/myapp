import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:myapp/features/home/domain/usecases/get_home_images_usecase.dart'; // Import the use cases

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeImagesUseCase _getHomeImagesUseCase;
  final GetOfferCarouselImagesUseCase _getOfferCarouselImagesUseCase;

  HomeBloc(this._getHomeImagesUseCase, this._getOfferCarouselImagesUseCase) : super(HomeInitial()) {
    on<LoadImages>(_onLoadImages);
  }

  void _onLoadImages(LoadImages event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Fetch data from the use cases
      final imageUrls = await _getHomeImagesUseCase.execute();
      final offerCarouselImages = await _getOfferCarouselImagesUseCase.execute();

      emit(HomeLoaded(imageUrls, offerCarouselImages));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
