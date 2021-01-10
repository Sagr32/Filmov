part of 'discovervote_cubit.dart';

@immutable
abstract class DiscoverVoteState {
  const DiscoverVoteState();
}

class DiscoverVoteInitial extends DiscoverVoteState {}



class DiscoverByVoteLoading extends DiscoverVoteState {
  const DiscoverByVoteLoading();
}


class DiscoverByVoteLoaded extends DiscoverVoteState {
  final Discover movies;
  const DiscoverByVoteLoaded(this.movies);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscoverByVoteLoaded && o.movies == movies;
  }

  @override
  int get hashCode => movies.hashCode;
}


class DiscoverByVoteLoadingError extends DiscoverVoteState {
  final String error;
  DiscoverByVoteLoadingError(this.error);
}