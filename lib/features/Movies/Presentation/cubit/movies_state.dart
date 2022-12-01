part of 'movies_cubit.dart';

abstract class MoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<Movie> moviesList;
  MoviesLoadedState(this.moviesList);
  @override
  List<Object> get props => [moviesList];
}

class MoviesErrorState extends MoviesState {
  final String errorMessage;
  MoviesErrorState(this.errorMessage);
@override
List<Object> get props => [errorMessage];
}
