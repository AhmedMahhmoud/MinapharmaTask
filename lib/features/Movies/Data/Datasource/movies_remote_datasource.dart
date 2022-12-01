import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pharmatask/Core/constants/constants.dart';

import '../Model/movies_model.dart';

class MovieRemoteDataSource {
  Future<List<Movie>> getMovies() async {
    var response = await http.get(
        Uri.parse("${Constants.baseURL}Top250Movies/${Constants.apiKey}"),
        headers: {
          'Content-type': 'application/json',
        });

    var decodedResponse = json.decode(response.body)['items'] as List;
    return decodedResponse.map((e) => Movie.fromMap(e)).toList();
  }
}
