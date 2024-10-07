import 'package:flutter/material.dart';
import '../../../../models (will be deleted)/movie.dart';
import '../../../movie_screen/movie_details_screen.dart';

class WatchListScreen extends StatefulWidget {
  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final List<Movie> watchlist = [
    Movie(id: 1, title: 'Inception', posterPath: '/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg'),
    Movie(id: 2, title: 'The Dark Knight', posterPath: '/qJ2tW6WMUDux911r6m7haRef0WH.jpg'),
    Movie(id: 3, title: 'Interstellar', posterPath: '/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: watchlist.map((movie) {
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: 50,
              fit: BoxFit.cover,
            ),
            title: Text(movie.title, style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  watchlist.remove(movie);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(movieId: movie.id),
                ),
              );
            },
          );
        }).toList(),
      );
  }
}