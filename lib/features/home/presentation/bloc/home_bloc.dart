import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadImages>(_onLoadImages);
  }

  void _onLoadImages(LoadImages event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // ...simulate fetching data...
      await Future.delayed(const Duration(seconds: 1));
      // In a real app, fetch from repository/data source
      const imageUrls = [
        'https://i.ytimg.com/vi/vXIek3627DY/maxresdefault.jpg',
        'https://5.imimg.com/data5/IJ/TD/MY-19422102/fish-aquarium-500x500.jpg',
        'https://thumbs.dreamstime.com/b/fish-aquarium-fish-sucker-plecostomus-small-beautiful-aquarium-108376595.jpg',
        'https://freshwateraquatica.org/cdn/shop/products/Screenshot_78.png?v=1693570790',
      ];
      const offerCarouselImages = [
        'https://i.ytimg.com/vi/vXIek3627DY/maxresdefault.jpg',
        'https://5.imimg.com/data5/IJ/TD/MY-19422102/fish-aquarium-500x500.jpg',
        'https://thumbs.dreamstime.com/b/fish-aquarium-fish-sucker-plecostomus-small-beautiful-aquarium-108376595.jpg',
        'https://freshwateraquatica.org/cdn/shop/products/Screenshot_78.png?v=1693570790',
      ];
      emit(HomeLoaded(imageUrls, offerCarouselImages));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
