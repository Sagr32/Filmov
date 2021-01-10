part of 'search_cubit.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final Discover movies;
  const SearchLoaded(this.movies);
}

class SearchLoadingError extends SearchState {
  final String error;

  const SearchLoadingError(this.error);
}
