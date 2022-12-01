import 'package:pharmatask/Core/Failure/exceptions.dart';
import 'package:pharmatask/services/sembast_database/Movies/movies_db.dart';

import '../Model/movies_model.dart';

class MoviesLocalDataSource {
  final MoviesDao moviesDao;
  MoviesLocalDataSource({required this.moviesDao});
  getMoviesDao() async {
    List<Movie> movieList = await moviesDao.getMovies();
    if (movieList.isNotEmpty) {
      return movieList;
    } else {
      throw EmptyCacheException();
    }
  }

  insertMoviesDao(List<Movie> movies) async {
    await moviesDao.insertMovies(movies);
  }
}
