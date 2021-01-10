part of 'discoverrevenue_cubit.dart';

@immutable
abstract class DiscoverRevenueState {
  const DiscoverRevenueState();
}

class DiscoverrevenueInitial extends DiscoverRevenueState {}

class DiscoverByRevenueLoading extends DiscoverRevenueState {
  const DiscoverByRevenueLoading();
}



class DiscoverByRevenueLoaded extends DiscoverRevenueState {
  final Discover movies;
  const DiscoverByRevenueLoaded(this.movies);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscoverByRevenueLoaded && o.movies == movies;
  }

  @override
  int get hashCode => movies.hashCode;
}

class DiscoverByRevenueLoadingError extends DiscoverRevenueState {
  final String error;
  DiscoverByRevenueLoadingError(this.error);
}
