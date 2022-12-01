import 'package:pharmatask/Core/Failure/exceptions.dart';
import 'package:pharmatask/Core/Network/network_connection_checker.dart';
import 'package:pharmatask/features/Movies/Data/Datasource/movies_local_datasource.dart';
import 'package:pharmatask/features/Movies/Domain/Repository/movies_repo.dart';

import '../Datasource/movies_remote_datasource.dart';
import '../Model/movies_model.dart';

class MovieRepositoryImpl implements MoviesRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final MoviesLocalDataSource moviesLocalDataSource;
  final NetworkInfo networkInfo;
  MovieRepositoryImpl(
      {required this.movieRemoteDataSource,
      required this.moviesLocalDataSource,
      required this.networkInfo});
  @override
  Future<List<Movie>> getMovies() async {
    if (await networkInfo.isConnected) {
      List<Movie> moviesList = await movieRemoteDataSource.getMovies();
      moviesLocalDataSource.insertMoviesDao(moviesList);
      return moviesList;
    } else {
      try {
        return await moviesLocalDataSource.getMoviesDao();
      } on EmptyCacheException {
        throw EMPTY_CACHE_FAILURE_MESSAGE;
      }
    }
  }
}
