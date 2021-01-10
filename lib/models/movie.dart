import 'package:flutter/foundation.dart';
import './genre.dart';

class Movie {
  int id;
  String backdropPath;
  String originalLanguage;
  String status;
  bool adult;
  String title;
  List<int> genreIds;

  double voteAverage;
  String posterPath;
  double popularity;
  int voteCount;
  String overview;
  String releaseDate;
  Movie({
    @required this.id,
    @required this.originalLanguage,
    @required this.backdropPath,
    @required this.adult,
    @required this.status,
    @required this.title,
    @required this.posterPath,
    @required this.voteAverage,
    @required this.popularity,
    @required this.voteCount,
    @required this.overview,
    @required this.releaseDate,
    this.genreIds,
  })  : assert(id != null),
        assert(backdropPath != null),
        assert(posterPath != null),
        assert(title != null);

  Movie.fromJson(Map<String, dynamic> json) {
    if (json['poster_path'] != null && json['backdrop_path'] != null) {
      popularity =
          json['popularity'].toDouble() ?? json['popularity'].toDouble();
      voteCount = json['vote_count'] ?? json['vote_count'];
      posterPath = json['poster_path'] ?? json['poster_path'];
      id = json['id'];
      adult = json['adult'];
      backdropPath = json['backdrop_path'] ?? json['backdrop_path'];
      originalLanguage = json['original_language'];
      title = json['title'];
      voteAverage = json['vote_average'].toDouble();
      overview = json['overview'];
      releaseDate = json['release_date'];
      genreIds = json['genre_ids'].cast<int>();

 
    }
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Movie &&
        o.id == id &&
        o.originalLanguage == originalLanguage &&
        o.backdropPath == backdropPath &&
        o.adult == adult &&
        o.status == status &&
        o.title == title &&
        o.posterPath == posterPath &&
        o.voteAverage == voteAverage &&
        o.popularity == popularity &&
        o.voteCount == voteCount &&
        o.overview == overview &&
        o.releaseDate == releaseDate;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      originalLanguage.hashCode ^
      backdropPath.hashCode ^
      adult.hashCode ^
      status.hashCode ^
      title.hashCode ^
      posterPath.hashCode ^
      voteAverage.hashCode ^
      popularity.hashCode ^
      voteCount.hashCode ^
      overview.hashCode ^
      releaseDate.hashCode;
}
