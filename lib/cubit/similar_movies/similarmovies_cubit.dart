import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:meta/meta.dart';
import '../../models/discover.dart';

part 'similarmovies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  final MovieRepository _movieRepository;
  SimilarMoviesCubit(this._movieRepository) : super(SimilarMoviesInitial());

  Future getSimilarMovies(int id) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(SimilarMoviesLoading());
        final movies = await _movieRepository.getSimilarMovies(id);
        emit(SimilarMoviesLoaded(movies));
        // isOnline = true;
      } else {
        emit(SimilarMoviesLoadingError("Try again later"));
      }
      // isOnline = false;
    } on NetworkException catch (e) {
      emit(SimilarMoviesLoadingError(e.toString()));
    } on SocketException catch (e) {
      emit(SimilarMoviesLoadingError(e.toString()));
    }
  }
}
