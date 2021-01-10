part of 'discoversoon_cubit.dart';

@immutable
abstract class DiscoverSoonState {
  const DiscoverSoonState();
}

class DiscoversoonInitial extends DiscoverSoonState {
  const DiscoversoonInitial();
}

class DiscoverSoonLoading extends DiscoverSoonState {
  const DiscoverSoonLoading();
}

class DiscoverSoonLoaded extends DiscoverSoonState {
  final Discover movies;

  const DiscoverSoonLoaded(this.movies);
    @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscoverSoonLoaded && o.movies == movies;
  }

  @override
  int get hashCode => movies.hashCode;
}

class DiscoverSoonLoadingError extends DiscoverSoonState {
  final String error;
  const DiscoverSoonLoadingError(this.error);
}
