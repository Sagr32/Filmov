part of 'similarmovies_cubit.dart';

@immutable
abstract class SimilarMoviesState {
  const SimilarMoviesState();
}

class SimilarMoviesInitial extends SimilarMoviesState {
  const SimilarMoviesInitial();
}

class SimilarMoviesLoading extends SimilarMoviesState {
  const SimilarMoviesLoading();
}

class SimilarMoviesLoaded extends SimilarMoviesState {
   final Discover movies;
 const SimilarMoviesLoaded(this.movies);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SimilarMoviesLoaded && o.movies == movies;
  }

  @override
  int get hashCode => movies.hashCode;
}

class SimilarMoviesLoadingError extends SimilarMoviesState {
  final String error;
  const SimilarMoviesLoadingError(this.error);
}
