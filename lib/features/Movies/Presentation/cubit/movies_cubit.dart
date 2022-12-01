import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmatask/features/Movies/Domain/Usecases/get_movies_usecase.dart';

import '../../Data/Model/movies_model.dart';
part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetMoviesUsecase moviesUsecase;
  MoviesCubit(this.moviesUsecase) : super(MoviesInitial());
  getMovies() async {
    try {
      emit(MoviesLoadingState());
      var moviesList = await moviesUsecase();
      emit(MoviesLoadedState(moviesList));
    } catch (e) {
      emit(MoviesErrorState(e.toString()));
    }
  }
}
