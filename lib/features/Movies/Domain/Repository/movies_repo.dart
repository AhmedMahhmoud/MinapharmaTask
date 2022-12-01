import 'package:pharmatask/features/Movies/Data/Model/movies_model.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getMovies();
}
