import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:meta/meta.dart';
import '../../models/discover.dart';
part 'discovervote_state.dart';

class DiscoverVoteCubit extends Cubit<DiscoverVoteState> {
  final MovieRepository _movieRepository;

  DiscoverVoteCubit(this._movieRepository) : super(DiscoverVoteInitial());

  Future discoverMoviesByVoteAvg() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(DiscoverByVoteLoading());
        final movies = await _movieRepository.discoverMoviesByVoteAvg();
        emit(DiscoverByVoteLoaded(movies));
        // isOnline = true;
      } else {
        emit(DiscoverByVoteLoadingError("Try again later"));
      }
      // isOnline = false;
    } on NetworkException catch (e) {
      emit(DiscoverByVoteLoadingError(e.toString()));
    } on SocketException catch (e) {
      emit(DiscoverByVoteLoadingError(e.toString()));
    }
  }
}
