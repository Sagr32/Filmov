import 'package:filmov/models/movie.dart';

class Trending {
  int page;

  List<Movie> movies;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Trending && o.page == page && o.movies == movies;
  }

  @override
  int get hashCode => page.hashCode ^ movies.hashCode;

  Trending({this.page, this.movies});
  // : assert(page != null),
  //   assert(totalResult != null),
  //   assert(totalPages != null),
  //   assert(movies != null),
  //   super([page, totalResult, totalPages, movies]);

  Trending.fromJson(Map<String, dynamic> json) {
    page = json["page"];

    movies = (json["results"] as List).map((e) => Movie.fromJson(e)).toList();
  }
}
