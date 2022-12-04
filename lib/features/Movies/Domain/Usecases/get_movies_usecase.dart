import 'package:pharmatask/features/Movies/Domain/Repository/movies_repo.dart';

import '../../Data/Model/movies_model.dart';

class GetMoviesUsecase {
  final MoviesRepository movieRepository;
  GetMoviesUsecase(this.movieRepository);

  Future<List<Movie>> call() async {
    return await movieRepository.getMovies();
  }
}
