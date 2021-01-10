part of 'movie_cubit.dart';

abstract class MovieState  {
  const MovieState();

  
}

class MovieInitial extends MovieState {
  const MovieInitial();
}

class MovieLoading extends MovieState {
  const MovieLoading();
}

class MovieLoaded extends MovieState {
  final Movie movie;
  const MovieLoaded(this.movie);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MovieLoaded && o.movie == movie;
  }

  @override
  int get hashCode => movie.hashCode;
}

class MovieLoadingError extends MovieState {
  final String error;
  MovieLoadingError(this.error);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MovieLoadingError && o.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
