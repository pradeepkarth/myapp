import 'package:equatable/equatable.dart'; // Add equatable dependency

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> imageUrls;

  const HomeLoaded(this.imageUrls);

  @override
  List<Object> get props => [imageUrls];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}