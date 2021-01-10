part of 'trending_cubit.dart';

@immutable
abstract class TrendingState {
  const TrendingState();
}

class TrendingInitial extends TrendingState {
  const TrendingInitial();
}

class TrendingLoading extends TrendingState {
  const TrendingLoading();
}

class TrendingLoaded extends TrendingState {
  final Trending movies;
  const TrendingLoaded(this.movies);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TrendingLoaded && o.movies == movies;
  }

  @override
  int get hashCode => movies.hashCode;
}

class TrendingLoadingError extends TrendingState {
  final String error;
  const TrendingLoadingError(this.error);
}
