import 'package:equatable/equatable.dart';

class MovieData extends Equatable {
  final int id;
  final bool adult;
  final String language;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;

  const MovieData({
    required this.id,
    required this.adult,
    required this.language,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [id, title, posterPath];
}
