import 'package:equatable/equatable.dart';
import 'package:myapp/features/home/data/repositories/home_repository.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> imageUrls;
  final List<CarouselItem> offerCarouselImages;

  const HomeLoaded(this.imageUrls, this.offerCarouselImages);

  @override
  List<Object> get props => [imageUrls, offerCarouselImages];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
