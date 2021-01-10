import 'dart:io';

import 'package:filmov/models/discover.dart';
import 'package:filmov/models/movie.dart';
import 'package:filmov/models/trending.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:filmov/util/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesApiProvider implements MovieRepository {
  final String baseUrl = "https://api.themoviedb.org/3/";

  @override
  Future<Movie> getMovie(int movieId) async {
    var response = await http.get(baseUrl + "movie/$movieId?api_key=$kApiKey");
    // https://api.themoviedb.org/3/movie/1622?api_key=ea301cf8c2528de0b5b4574f32fc665a&language=en-US

    // var response = await http.get(baseUrl + "movie/upcoming?api_key=$key");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // isOnline = true;
      } else {}
      // isOnline = false;
    } on SocketException catch (e) {} on NetworkException catch (e) {}

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      Movie movie = Movie.fromJson(data);
      return movie;
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<Discover> discoverMoviesByPopularity() async {
//ea301cf8c2528de0b5b4574f32fc665a&language=en-US&sort_by=popularity.desc
    var response = await http.get(baseUrl +
        "discover/movie?api_key=$kApiKey&language=en-US&sort_by=popularity.desc&include_adult=false");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          Discover movies = Discover.fromJson(data);
          return movies;
        } else {
          throw NetworkException();
        }
        // isOnline = true;
      } else {
        throw NetworkException();
      }
      // isOnline = false;
    } on SocketException catch (e) {
      throw NetworkException();
    } on NetworkException catch (e) {
      throw NetworkException();
    }
  }

  @override
  Future<Discover> discoverMoviesByVoteAvg() async {
    var response = await http.get(baseUrl +
        "discover/movie?api_key=$kApiKey&language=en-US&sort_by=vote_count.desc&include_adult=false");

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          Discover movies = Discover.fromJson(data);
          return movies;
        } else {
          throw NetworkException();
        }
      } else {
        throw NetworkException();
      }
      // isOnline = false;
    } on SocketException catch (_) {
      throw NetworkException();
    } on NetworkException catch (_) {
      throw NetworkException();
    }
  }

  @override
  Future<Discover> discoverMoviesByRevenue() async {
    var response = await http.get(baseUrl +
        "discover/movie?api_key=$kApiKey&language=en-US&sort_by=revenue.desc&include_adult=false");

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          Discover movies = Discover.fromJson(data);
          return movies;
        } else {
          throw NetworkException();
        }
      } else {
        throw NetworkException();
      }
      // isOnline = false;
    } on SocketException catch (e) {
      throw NetworkException();
    } on NetworkException catch (e) {
      throw NetworkException();
    }
  }

  @override
  Future<Discover> discoverMoviesComingSoon() async {
    var response = await http.get(baseUrl +
        "discover/movie?api_key=$kApiKey&language=en-US&sort_by=release_date.desc&include_adult=false&include_video=false&page=10&year=2020");

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          Discover movies = Discover.fromJson(data);
          return movies;
        } else {
          throw NetworkException();
        }
      } else {
        throw NetworkException();
      }
      // isOnline = false;
    } on SocketException catch (e) {
      throw NetworkException();
    } on NetworkException catch (e) {
      throw NetworkException();
    }
  }

  @override
  Future<Trending> getTrending() async {
// https://api.themoviedb.org/3/
    var response =
        await http.get(baseUrl + "trending/movie/week?api_key=$kApiKey");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          Trending movies = Trending.fromJson(data);
          return movies;
        } else {
          throw NetworkException();
        }
      } else {
        throw NetworkException();
      }
      // isOnline = false;
    } on SocketException catch (e) {
      throw NetworkException();
    } on NetworkException catch (e) {
      throw NetworkException();
    }
  }

  @override
  Future<Discover> getSimilarMovies(int id) async {
    var response = await http.get(baseUrl +
        "discover/movie?api_key=$kApiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$id");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          Discover movies = Discover.fromJson(data);
          return movies;
        } else {
          throw NetworkException();
        }
      } else {
        throw NetworkException();
      }
      // isOnline = false;
    } on SocketException catch (e) {
      throw NetworkException();
    } on NetworkException catch (e) {
      throw NetworkException();
    }
  }

  @override
  Future<Discover> searchMovie(String query) async {
    // https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher
    var response =
        await http.get(baseUrl + "search/movie?api_key=$kApiKey&query=$query");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          Discover movies = Discover.fromJson(data);
          return movies;
        } else {
          throw NetworkException();
        }
      } else {
        throw NetworkException();
      }
      // isOnline = false;
    } on SocketException catch (e) {
      throw NetworkException();
    } on NetworkException catch (e) {
      throw NetworkException();
    }
  }

  //
}

class NetworkException implements Exception {}
