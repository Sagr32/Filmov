import 'package:filmov/models/movie.dart';

class Discover {
  int page;
  int totalResult;
  int totalPages;
  List<Movie> movies;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Discover &&
        o.page == page &&
        o.totalResult == totalResult &&
        o.totalPages == totalPages &&
        o.movies == movies;
  }

  @override
  int get hashCode =>
      page.hashCode ^ totalResult.hashCode ^ totalPages.hashCode ^movies.hashCode ;

  Discover({this.page, this.totalPages, this.totalResult, this.movies});
  // : assert(page != null),
  //   assert(totalResult != null),
  //   assert(totalPages != null),
  //   assert(movies != null),
  //   super([page, totalResult, totalPages, movies]);

  Discover.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    totalResult = json["total_results"];
    totalPages = json["total_pages"];
    movies = (json["results"] as List).map((e) => Movie.fromJson(e)).toList();
  }
}

// "page": 1,
// "total_results": 10000,
// "total_pages": 500,
