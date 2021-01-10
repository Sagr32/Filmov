part of 'discoverpopularity_cubit.dart';

@immutable
abstract class DiscoverPopularityState {
  const DiscoverPopularityState();
}

class DiscoverPopularityInitial extends DiscoverPopularityState {}

class DiscoverByPopularityLoading extends DiscoverPopularityState {
  const DiscoverByPopularityLoading();
}

class DiscoverByPopularityLoaded extends DiscoverPopularityState {
  final Discover movies;
  const DiscoverByPopularityLoaded(this.movies);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscoverByPopularityLoaded && o.movies == movies;
  }

  @override
  int get hashCode => movies.hashCode;
}

class DiscoverByPopularityLoadingError extends DiscoverPopularityState {
  final String error;
  DiscoverByPopularityLoadingError(this.error);
}
