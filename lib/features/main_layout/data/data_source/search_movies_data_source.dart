import 'package:dartz/dartz.dart';
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/features/main_layout/data/models/movie_model.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class BaseSearchMoviesDataSource{
  Future<Either<String, List<MovieData>>> getSearchMoviesList(String query);
}

class RemoteSearchMoviesDataSource implements BaseSearchMoviesDataSource{
  @override
  Future<Either<String, List<MovieData>>> getSearchMoviesList(String query) async {
    final url = '${Constants.baseUrl}/search/movie?api_key=${Constants.apiKey}&query=$query';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final data = json.decode(response.body);

      List<MovieData> searchMoviesList = [];
      for(var e in List.from(data["results"])){
        searchMoviesList.add(MovieModel.fromJson(e));
      }
      return Right(searchMoviesList);
    } else {
      return Left("failed to get serach movies list from api, ${response.statusCode}, ${response.toString()}");
    }


  }

}
