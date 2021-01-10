import 'package:filmov/models/discover.dart';
import 'package:filmov/models/movie.dart';
import 'package:filmov/models/trending.dart';

abstract class MovieRepository {
  Future<Movie> getMovie(int movieId);
  Future<Discover> discoverMoviesByPopularity();
  Future<Discover> discoverMoviesByVoteAvg();
  Future<Discover> discoverMoviesByRevenue();
  Future<Discover> discoverMoviesComingSoon();
  Future<Discover> getSimilarMovies(int id);
  Future<Discover> searchMovie(String query);
  Future<Trending> getTrending();
}
