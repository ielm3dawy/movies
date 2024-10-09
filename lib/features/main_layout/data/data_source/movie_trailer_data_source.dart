import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/config/constants.dart';

abstract class BaseMovieTrailerDataSource{
  Future<Either<String, String>> getMovieTrailerUrl(int movieID);
}

class RemoteMovieTrailerDataSource implements BaseMovieTrailerDataSource{
  @override
  Future<Either<String, String>> getMovieTrailerUrl(int movieID) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/movie/$movieID/videos?api_key=${Constants.apiKey}'),
    );
    
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      final video = data['results'].firstWhere(
            (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );

      if (video != null) {
        return right('https://www.youtube.com/watch?v=${video['key']}');
      } else {
        return right("");
      }
    } else {
      return Left("failed to get movie trailer from api, ${response.statusCode}, ${response.body}");
    }
  }
}
