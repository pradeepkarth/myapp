import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> imageUrls;
  final List<String> offerCarouselImages; // Add list for carousel images

  const HomeLoaded(this.imageUrls, this.offerCarouselImages); // Update constructor

  @override
  List<Object> get props => [imageUrls, offerCarouselImages]; // Include in props
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}