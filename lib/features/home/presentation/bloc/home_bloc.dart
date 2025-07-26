import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:myapp/features/home/domain/usecases/get_home_images_usecase.dart'; // Import the use cases

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeImagesUseCase _getHomeImagesUseCase;
  final GetOfferCarouselItemsUseCase _getOfferCarouselItemsUseCase;

  HomeBloc(this._getHomeImagesUseCase, this._getOfferCarouselItemsUseCase) : super(HomeInitial()) {
    on<LoadImages>(_onLoadImages);
  }

  void _onLoadImages(LoadImages event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Fetch data from the use cases
      final imageUrls = await _getHomeImagesUseCase.execute();
      final offerCarouselItems = await _getOfferCarouselItemsUseCase.execute();

      emit(HomeLoaded(imageUrls, offerCarouselItems));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}