import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '4cd13bc715cb348bbad54a9b2ece43b0';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<String> fetchMovieVideo(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/$movieId/videos?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final video = data['results'].firstWhere(
            (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );

      if (video != null) {
        return 'https://www.youtube.com/watch?v=${video['key']}';
      } else {
        throw Exception('No trailer found');
      }
    } else {
      throw Exception('Failed to load trailer');
    }
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final url = '$baseUrl/search/movie?api_key=$apiKey&query=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      print('HTTP request failed, statusCode: ${response.statusCode}, response: ${response.body}');
      throw Exception('Failed to search movies');
    }
  }

  Future<List<dynamic>> fetchSimilarMovies(int movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/$movieId/similar?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load similar movies');
    }
  }

  Future<List<dynamic>> fetchGenres() async {
    final response = await http.get(
      Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['genres'];
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<dynamic>> fetchMoviesByGenre(int genreId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies by genre');
    }
  }
}