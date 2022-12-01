import 'dart:developer';

import 'package:pharmatask/features/Movies/Data/Model/movies_model.dart';
import 'dart:convert';
import 'package:sembast/sembast.dart';

import '../../../Core/Failure/exceptions.dart';
import '../sembast.dart';

class MoviesDao {
  Future<Database> get _db async => await AppDatabase.instance.database;
  var store = StoreRef.main();
  Future insertMovies(List<Movie> movies) async {
    List movieModelToJson =
        movies.map((movieItem) => movieItem.toJson()).toList();
    await store.record('movies').put(await _db, json.encode(movieModelToJson));
    log("movies added successfully");
  }

  Future getMovies() async {
    final jsonString = await store.record('movies').get(await _db);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<Movie> jsonToMovietModels =
          decodeJsonData.map<Movie>((movie) => Movie.fromJson(movie)).toList();
      return jsonToMovietModels;
    } else {
      throw EmptyCacheException();
    }
  }
}
