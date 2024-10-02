class Movie {
  final int id;
  final String title;
  final String posterPath;

  Movie({required this.id, required this.title, required this.posterPath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
    );
  }
}