import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:filmov/repository/movies_api_provider.dart';
import 'package:filmov/repository/movies_repository.dart';
import 'package:meta/meta.dart';
import '../../models/trending.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final MovieRepository _movieRepository;

  TrendingCubit(this._movieRepository) : super(TrendingInitial());
  Future getTrending() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(TrendingLoading());
        final movies = await _movieRepository.getTrending();
        emit(TrendingLoaded(movies));
        // isOnline = true;
      } else {
        emit(TrendingLoadingError("Try again later"));
      }
      // isOnline = false;
    } on NetworkException catch (e) {
      emit(TrendingLoadingError(e.toString()));
    } on SocketException catch (e) {
      emit(TrendingLoadingError(e.toString()));
    }
  }
}
