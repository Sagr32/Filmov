import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:filmov/models/discover.dart';
import 'package:filmov/models/movie.dart';
import 'package:filmov/repository/movies_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _movieRepository;
  MovieCubit(this._movieRepository) : super(MovieInitial());

  Future<Movie> getMovie(int movieId) async {
    try {
      emit(MovieLoading());
      final movie = await _movieRepository.getMovie(movieId);
      emit(MovieLoaded(movie));
    } on SocketException catch (e) {
      emit(MovieLoadingError(e.toString()));
    } catch (e) {
      emit(MovieLoadingError(e));
    }
  }
}
